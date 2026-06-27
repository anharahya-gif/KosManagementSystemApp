import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

/// Service untuk export dan import seluruh data database SQLite ke/dari JSON.
/// Digunakan sebagai backup selama proses pengembangan.
class BackupService {
  final AppDatabase _db;

  BackupService(this._db);

  // ──────────────────────────────────────────────
  //  EXPORT: Database → JSON File
  // ──────────────────────────────────────────────

  /// Mengekspor seluruh data dari database ke file JSON.
  /// Mengembalikan path file JSON yang dihasilkan.
  Future<String> exportToJson() async {
    final data = <String, dynamic>{};
    data['_meta'] = {
      'exportedAt': DateTime.now().toIso8601String(),
      'schemaVersion': _db.schemaVersion,
      'appName': 'KMS - Kos Management System',
    };

    // Export setiap tabel
    data['organizations'] = await _exportTable(_db.organizations);
    data['userProfiles'] = await _exportTable(_db.userProfiles);
    data['properties'] = await _exportTable(_db.properties);
    data['propertyManagers'] = await _exportTable(_db.propertyManagers);
    data['rooms'] = await _exportTable(_db.rooms);
    data['residents'] = await _exportTable(_db.residents);
    data['contracts'] = await _exportTable(_db.contracts);
    data['invoices'] = await _exportTable(_db.invoices);
    data['payments'] = await _exportTable(_db.payments);
    data['paymentItems'] = await _exportTable(_db.paymentItems);
    data['maintenanceTickets'] = await _exportTable(_db.maintenanceTickets);
    data['auditLogs'] = await _exportTable(_db.auditLogs);
    data['roomFacilities'] = await _exportTable(_db.roomFacilities);

    // Simpan ke file (Coba ke folder Downloads jika memungkinkan)
    Directory? dir;
    try {
      if (Platform.isAndroid) {
        final downloadDir = Directory('/storage/emulated/0/Download');
        if (await downloadDir.exists()) {
          dir = downloadDir;
        } else {
          dir = await getExternalStorageDirectory();
        }
      } else {
        dir = await getDownloadsDirectory();
      }
    } catch (_) {
      // Fallback jika provider crash
    }
    dir ??= await getApplicationDocumentsDirectory();

    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    var file = File('${dir.path}/kms_backup_$timestamp.json');
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    try {
      await file.writeAsString(jsonString);
    } catch (_) {
      // Fallback jika tidak ada akses tulis di folder publik (Android Scoped Storage)
      final fallbackDir = await getApplicationDocumentsDirectory();
      file = File('${fallbackDir.path}/kms_backup_$timestamp.json');
      await file.writeAsString(jsonString);
    }

    return file.path;
  }

  /// Helper generik: membaca seluruh baris dari tabel dan
  /// mengonversi ke List<Map<String, dynamic>>.
  Future<List<Map<String, dynamic>>> _exportTable<T extends HasResultSet>(
    ResultSetImplementation<T, dynamic> table,
  ) async {
    final rows = await _db.select(table).get();
    return rows.map((row) {
      final dataClass = row as DataClass;
      return dataClass.toJson();
    }).toList();
  }

  // ──────────────────────────────────────────────
  //  IMPORT: JSON File → Database
  // ──────────────────────────────────────────────

  /// Mengimpor data dari file JSON ke database.
  /// Data yang ada akan dihapus terlebih dahulu (full restore).
  Future<ImportResult> importFromJson(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return ImportResult(success: false, message: 'File tidak ditemukan: $filePath');
      }

      final jsonString = await file.readAsString();
      var data = jsonDecode(jsonString) as Map<String, dynamic>;

      // Auto-migrate data if schemaVersion is older
      final meta = data['_meta'] as Map<String, dynamic>?;
      final fileVersion = meta != null ? (meta['schemaVersion'] is num ? (meta['schemaVersion'] as num).toInt() : 1) : 1;
      data = _migrateBackupData(data, fileVersion, _db.schemaVersion);

      int totalRows = 0;

      await _db.transaction(() async {
        // 1. Hapus semua data (urutan penting karena foreign key)
        await _db.delete(_db.auditLogs).go();
        await _db.delete(_db.roomFacilities).go();
        await _db.delete(_db.paymentItems).go();
        await _db.delete(_db.payments).go();
        await _db.delete(_db.invoices).go();
        await _db.delete(_db.contracts).go();
        await _db.delete(_db.maintenanceTickets).go();
        await _db.delete(_db.residents).go();
        await _db.delete(_db.rooms).go();
        await _db.delete(_db.propertyManagers).go();
        await _db.delete(_db.properties).go();
        await _db.delete(_db.userProfiles).go();
        await _db.delete(_db.organizations).go();

        // 2. Masukkan data baru (urutan penting karena foreign key)
        totalRows += await _importOrganizations(data['organizations'] as List<dynamic>? ?? []);
        totalRows += await _importUserProfiles(data['userProfiles'] as List<dynamic>? ?? []);
        totalRows += await _importProperties(data['properties'] as List<dynamic>? ?? []);
        totalRows += await _importPropertyManagers(data['propertyManagers'] as List<dynamic>? ?? []);
        totalRows += await _importRooms(data['rooms'] as List<dynamic>? ?? []);
        totalRows += await _importResidents(data['residents'] as List<dynamic>? ?? []);
        totalRows += await _importContracts(data['contracts'] as List<dynamic>? ?? []);
        totalRows += await _importInvoices(data['invoices'] as List<dynamic>? ?? []);
        totalRows += await _importPayments(data['payments'] as List<dynamic>? ?? []);
        totalRows += await _importPaymentItems(data['paymentItems'] as List<dynamic>? ?? []);
        totalRows += await _importMaintenanceTickets(data['maintenanceTickets'] as List<dynamic>? ?? []);
        totalRows += await _importAuditLogs(data['auditLogs'] as List<dynamic>? ?? []);
        totalRows += await _importRoomFacilities(data['roomFacilities'] as List<dynamic>? ?? []);
      });

      return ImportResult(
        success: true,
        message: 'Berhasil mengimpor $totalRows baris data dari backup.',
      );
    } catch (e) {
      return ImportResult(success: false, message: 'Gagal mengimpor data: $e');
    }
  }

  // ──────────────────────────────────────────────
  //  Per-Table Import Helpers
  // ──────────────────────────────────────────────

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is num) {
      final valInt = value.toInt();
      if (valInt > 9999999999) {
        return DateTime.fromMillisecondsSinceEpoch(valInt);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(valInt * 1000);
      }
    }
    if (value is String) {
      final parsed = DateTime.tryParse(value);
      if (parsed != null) return parsed;
      final numVal = num.tryParse(value);
      if (numVal != null) {
        final valInt = numVal.toInt();
        if (valInt > 9999999999) {
          return DateTime.fromMillisecondsSinceEpoch(valInt);
        } else {
          return DateTime.fromMillisecondsSinceEpoch(valInt * 1000);
        }
      }
    }
    return null;
  }

  Future<int> _importOrganizations(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.organizations).insert(
            OrganizationsCompanion.insert(
              id: m['id'] as String? ?? '',
              name: m['name'] as String? ?? '',
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
              updatedAt: Value(_parseDateTime(m['updated_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importUserProfiles(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.userProfiles).insert(
            UserProfilesCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              fullName: m['full_name'] as String? ?? '',
              phoneNumber: m['phone_number'] as String? ?? '',
              email: m['email'] as String? ?? '',
              role: m['role'] as String? ?? '',
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importProperties(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.properties).insert(
            PropertiesCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              name: m['name'] as String? ?? '',
              address: m['address'] as String? ?? '',
              type: m['type'] as String? ?? '',
              latitude: Value(m['latitude'] is num ? (m['latitude'] as num).toDouble() : null),
              longitude: Value(m['longitude'] is num ? (m['longitude'] as num).toDouble() : null),
              deletedAt: Value(_parseDateTime(m['deleted_at'])),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importPropertyManagers(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.propertyManagers).insert(
            PropertyManagersCompanion.insert(
              id: m['id'] as String? ?? '',
              userId: m['user_id'] as String? ?? '',
              propertyId: m['property_id'] as String? ?? '',
              assignedAt: Value(_parseDateTime(m['assigned_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importRooms(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.rooms).insert(
            RoomsCompanion.insert(
              id: m['id'] as String? ?? '',
              propertyId: m['property_id'] as String? ?? '',
              roomNumber: m['room_number'] as String? ?? '',
              buildingName: Value(m['building_name'] as String?),
              floorName: Value(m['floor_name'] as String?),
              pricePerMonth: m['price_per_month'] is num ? (m['price_per_month'] as num).toInt() : 0,
              status: Value(m['status'] as String? ?? 'vacant'),
              images: Value(m['images'] as String?),
              facilities: Value(m['facilities'] as String?),
              deletedAt: Value(_parseDateTime(m['deleted_at'])),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importResidents(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.residents).insert(
            ResidentsCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              userId: Value(m['user_id'] as String?),
              fullName: m['full_name'] as String? ?? '',
              phoneNumber: m['phone_number'] as String? ?? '',
              email: Value(m['email'] as String?),
              idCardNumber: Value(m['id_card_number'] as String?),
              status: Value(m['status'] as String? ?? 'prospective'),
              deletedAt: Value(_parseDateTime(m['deleted_at'])),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importContracts(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.contracts).insert(
            ContractsCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              residentId: m['resident_id'] as String? ?? '',
              roomId: m['room_id'] as String? ?? '',
              startDate: _parseDateTime(m['start_date']) ?? DateTime.now(),
              endDate: _parseDateTime(m['end_date']) ?? DateTime.now(),
              billingCycle: Value(m['billing_cycle'] as String? ?? 'monthly'),
              pricePerCycle: m['price_per_cycle'] is num ? (m['price_per_cycle'] as num).toInt() : 0,
              depositAmount: Value(m['deposit_amount'] is num ? (m['deposit_amount'] as num).toInt() : 0),
              status: Value(m['status'] as String? ?? 'active'),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importInvoices(List<dynamic> rows) async {
    final Set<String> usedNumbers = {};
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      var invoiceNum = (m['invoice_number'] as String? ?? '').trim();
      if (invoiceNum.isEmpty) {
        invoiceNum = 'INV-AUTO-${_parseDateTime(m['created_at'])?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}-${row.hashCode}';
      }

      var uniqueInvoiceNum = invoiceNum;
      int counter = 1;
      while (usedNumbers.contains(uniqueInvoiceNum)) {
        uniqueInvoiceNum = '$invoiceNum-$counter';
        counter++;
      }
      usedNumbers.add(uniqueInvoiceNum);

      await _db.into(_db.invoices).insert(
            InvoicesCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              contractId: m['contract_id'] as String? ?? '',
              invoiceNumber: uniqueInvoiceNum,
              dueDate: _parseDateTime(m['due_date']) ?? DateTime.now(),
              amountDue: m['amount_due'] is num ? (m['amount_due'] as num).toInt() : 0,
              amountPaid: Value(m['amount_paid'] is num ? (m['amount_paid'] as num).toInt() : 0),
              status: Value(m['status'] as String? ?? 'unpaid'),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importPayments(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.payments).insert(
            PaymentsCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              paymentDate: Value(_parseDateTime(m['payment_date']) ?? DateTime.now()),
              amount: m['amount'] is num ? (m['amount'] as num).toInt() : 0,
              paymentMethod: m['payment_method'] as String? ?? 'transfer',
              proofUrl: Value(m['proof_url'] as String?),
              verified: Value(m['verified'] is bool ? m['verified'] as bool : (m['verified'] == 1 || m['verified'] == 'true')),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importPaymentItems(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.paymentItems).insert(
            PaymentItemsCompanion.insert(
              id: m['id'] as String? ?? '',
              paymentId: m['payment_id'] as String? ?? '',
              invoiceId: m['invoice_id'] as String? ?? '',
              amountAllocated: m['amount_allocated'] is num ? (m['amount_allocated'] as num).toInt() : 0,
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importMaintenanceTickets(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.maintenanceTickets).insert(
            MaintenanceTicketsCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              residentId: m['resident_id'] as String? ?? '',
              roomId: m['room_id'] as String? ?? '',
              title: m['title'] as String? ?? '',
              description: m['description'] as String? ?? '',
              urgency: Value(m['urgency'] as String? ?? 'medium'),
              status: Value(m['status'] as String? ?? 'pending'),
              cost: Value(m['cost'] is num ? (m['cost'] as num).toInt() : null),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importAuditLogs(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.auditLogs).insert(
            AuditLogsCompanion.insert(
              id: m['id'] as String? ?? '',
              organizationId: m['organization_id'] as String? ?? '',
              userId: m['user_id'] as String? ?? '',
              action: m['action'] as String? ?? '',
              description: m['description'] as String? ?? '',
              ipAddress: Value(m['ip_address'] as String?),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Future<int> _importRoomFacilities(List<dynamic> rows) async {
    for (final row in rows) {
      final m = row as Map<String, dynamic>;
      await _db.into(_db.roomFacilities).insert(
            RoomFacilitiesCompanion.insert(
              id: m['id'] as String? ?? '',
              roomId: m['room_id'] as String? ?? '',
              name: m['name'] as String? ?? '',
              condition: m['condition'] as String? ?? 'good',
              description: Value(m['description'] as String?),
              createdAt: Value(_parseDateTime(m['created_at']) ?? DateTime.now()),
            ),
          );
    }
    return rows.length;
  }

  Map<String, dynamic> _migrateBackupData(Map<String, dynamic> data, int fileVersion, int currentVersion) {
    var migratedData = Map<String, dynamic>.from(data);
    
    if (fileVersion < 3) {
      migratedData['roomFacilities'] ??= [];
      final rooms = migratedData['rooms'] as List<dynamic>? ?? [];
      final roomFacilities = migratedData['roomFacilities'] as List<dynamic>;
      
      for (final room in rooms) {
        if (room is Map<String, dynamic>) {
          final roomId = room['id'] as String? ?? '';
          final facilitiesStr = room['facilities'] as String? ?? '';
          if (roomId.isNotEmpty && facilitiesStr.isNotEmpty) {
            final facList = facilitiesStr.split(',');
            for (final facName in facList) {
              final trimmedName = facName.trim();
              if (trimmedName.isNotEmpty) {
                final alreadyExists = roomFacilities.any((f) => 
                  f is Map<String, dynamic> && f['room_id'] == roomId && f['name'] == trimmedName
                );
                if (!alreadyExists) {
                  roomFacilities.add({
                    'id': 'FAC-MIGRATE-${roomId.substring(0, roomId.length > 5 ? 5 : roomId.length)}-${trimmedName.hashCode}',
                    'room_id': roomId,
                    'name': trimmedName,
                    'condition': 'good',
                    'description': 'Migrasi otomatis dari versi lama',
                    'created_at': DateTime.now().toIso8601String(),
                  });
                }
              }
            }
          }
        }
      }
      fileVersion = 3;
    }
    
    return migratedData;
  }
}

/// Hasil operasi import
class ImportResult {
  final bool success;
  final String message;

  const ImportResult({required this.success, required this.message});
}
