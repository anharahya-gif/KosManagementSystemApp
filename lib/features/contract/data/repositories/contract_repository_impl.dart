import 'package:drift/drift.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/errors/failures.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/result.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/domain/entities/payment_entity.dart';
import 'package:kms/features/contract/domain/repositories/contract_repository.dart';
import 'package:uuid/uuid.dart';

class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  ContractRepositoryImpl(this._db);

  ContractEntity _toContractEntity(Contract row) {
    return ContractEntity(
      id: row.id,
      organizationId: row.organizationId,
      residentId: row.residentId,
      roomId: row.roomId,
      startDate: row.startDate,
      endDate: row.endDate,
      billingCycle: row.billingCycle,
      pricePerCycle: CurrencyFormatter.toRupiahDouble(row.pricePerCycle),
      depositAmount: CurrencyFormatter.toRupiahDouble(row.depositAmount),
      status: ContractStatus.fromString(row.status),
      createdAt: row.createdAt,
    );
  }

  InvoiceEntity _toInvoiceEntity(Invoice row) {
    return InvoiceEntity(
      id: row.id,
      organizationId: row.organizationId,
      contractId: row.contractId,
      invoiceNumber: row.invoiceNumber,
      dueDate: row.dueDate,
      amountDue: CurrencyFormatter.toRupiahDouble(row.amountDue),
      amountPaid: CurrencyFormatter.toRupiahDouble(row.amountPaid),
      status: InvoiceStatus.fromString(row.status),
      createdAt: row.createdAt,
    );
  }

  PaymentEntity _toPaymentEntity(Payment row) {
    return PaymentEntity(
      id: row.id,
      organizationId: row.organizationId,
      paymentDate: row.paymentDate,
      amount: CurrencyFormatter.toRupiahDouble(row.amount),
      paymentMethod: row.paymentMethod,
      proofUrl: row.proofUrl,
      verified: row.verified,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<Result<List<ContractEntity>>> getContracts(String organizationId) async {
    try {
      final query = _db.select(_db.contracts)
        ..where((t) => t.organizationId.equals(organizationId));
      final rows = await query.get();
      return Success(rows.map(_toContractEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data kontrak: $e"));
    }
  }

  @override
  Future<Result<ContractEntity>> getContractById(String id) async {
    try {
      final query = _db.select(_db.contracts)..where((t) => t.id.equals(id));
      final row = await query.getSingle();
      return Success(_toContractEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil detail kontrak: $e"));
    }
  }

  @override
  Future<Result<void>> createContract(ContractEntity contract) async {
    try {
      await _db.transaction(() async {
        // 1. Insert contract
        await _db.into(_db.contracts).insert(
              ContractsCompanion.insert(
                id: contract.id,
                organizationId: contract.organizationId,
                residentId: contract.residentId,
                roomId: contract.roomId,
                startDate: contract.startDate,
                endDate: contract.endDate,
                billingCycle: Value(contract.billingCycle),
                pricePerCycle: CurrencyFormatter.toCents(contract.pricePerCycle),
                depositAmount: Value(CurrencyFormatter.toCents(contract.depositAmount)),
                status: Value(contract.status.name),
                createdAt: Value(contract.createdAt),
              ),
            );

        // 2. Update room status to 'occupied'
        final roomQuery = _db.update(_db.rooms)..where((t) => t.id.equals(contract.roomId));
        await roomQuery.write(const RoomsCompanion(status: Value('occupied')));

        // 3. Update resident status to 'active'
        final residentQuery = _db.update(_db.residents)..where((t) => t.id.equals(contract.residentId));
        await residentQuery.write(const ResidentsCompanion(status: Value('active')));

        // 4. Generate first invoice (atau seluruh invoice terjadwal)
        // Disarankan generate seluruh invoice sepanjang masa kontrak untuk SQLite lokal
        DateTime currentDueDate = contract.startDate;
        int index = 1;
        final priceCents = CurrencyFormatter.toCents(contract.pricePerCycle);

        // A. Generate Deposit Invoice if depositAmount > 0
        if (contract.depositAmount > 0) {
          final depositId = _uuid.v4();
          final depInvoiceNum = 'DEP-${contract.startDate.year}${contract.startDate.month.toString().padLeft(2, '0')}-${contract.id.substring(0, 5)}';
          await _db.into(_db.invoices).insert(
                InvoicesCompanion.insert(
                  id: depositId,
                  organizationId: contract.organizationId,
                  contractId: contract.id,
                  invoiceNumber: depInvoiceNum,
                  dueDate: contract.startDate,
                  amountDue: CurrencyFormatter.toCents(contract.depositAmount),
                  amountPaid: const Value(0),
                  status: const Value('unpaid'),
                  createdAt: Value(contract.createdAt),
                ),
              );
        }

        // B. Generate monthly invoices
        while (currentDueDate.isBefore(contract.endDate)) {
          final invoiceId = _uuid.v4();
          final invoiceNum = 'INV-${currentDueDate.year}${currentDueDate.month.toString().padLeft(2, '0')}-${contract.id.substring(0, 5)}-$index';

          await _db.into(_db.invoices).insert(
                InvoicesCompanion.insert(
                  id: invoiceId,
                  organizationId: contract.organizationId,
                  contractId: contract.id,
                  invoiceNumber: invoiceNum,
                  dueDate: currentDueDate,
                  amountDue: priceCents,
                  amountPaid: const Value(0),
                  status: const Value('unpaid'),
                  createdAt: Value(contract.createdAt),
                ),
              );

          // Increment month safely
          int nextMonth = currentDueDate.month + 1;
          int nextYear = currentDueDate.year;
          if (nextMonth > 12) {
            nextMonth = 1;
            nextYear += 1;
          }
          int day = contract.startDate.day;
          // Clip day if it exceeds total days of the next month (e.g., 31 Jan -> 28 Feb)
          final lastDayOfNextMonth = DateTime(nextYear, nextMonth + 1, 0).day;
          if (day > lastDayOfNextMonth) {
            day = lastDayOfNextMonth;
          }

          currentDueDate = DateTime(nextYear, nextMonth, day);
          index++;
        }
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal membuat kontrak: $e"));
    }
  }

  @override
  Future<Result<void>> terminateContract(String contractId, DateTime terminationDate) async {
    try {
      await _db.transaction(() async {
        // 1. Ambil data kontrak untuk mendapatkan roomId dan residentId
        final contract = await (_db.select(_db.contracts)..where((t) => t.id.equals(contractId))).getSingle();

        // 2. Update status kontrak
        final contractQuery = _db.update(_db.contracts)..where((t) => t.id.equals(contractId));
        await contractQuery.write(const ContractsCompanion(status: Value('terminated')));

        // 3. Kembalikan status kamar menjadi vacant
        final roomQuery = _db.update(_db.rooms)..where((t) => t.id.equals(contract.roomId));
        await roomQuery.write(const RoomsCompanion(status: Value('vacant')));

        // 4. Ubah status resident menjadi checked_out
        final residentQuery = _db.update(_db.residents)..where((t) => t.id.equals(contract.residentId));
        await residentQuery.write(const ResidentsCompanion(status: Value('checked_out')));
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghentikan kontrak: $e"));
    }
  }

  @override
  Future<Result<void>> changeRoom(String contractId, String newRoomId, DateTime effectiveDate) async {
    try {
      await _db.transaction(() async {
        // 1. Ambil data kontrak lama
        final contract = await (_db.select(_db.contracts)..where((t) => t.id.equals(contractId))).getSingle();
        final oldRoomId = contract.roomId;

        // 2. Update status kamar lama menjadi vacant
        final oldRoomQuery = _db.update(_db.rooms)..where((t) => t.id.equals(oldRoomId));
        await oldRoomQuery.write(const RoomsCompanion(status: Value('vacant')));

        // 3. Update status kamar baru menjadi occupied
        final newRoomQuery = _db.update(_db.rooms)..where((t) => t.id.equals(newRoomId));
        await newRoomQuery.write(const RoomsCompanion(status: Value('occupied')));

        // 4. Update data kamar pada kontrak
        final contractQuery = _db.update(_db.contracts)..where((t) => t.id.equals(contractId));
        await contractQuery.write(ContractsCompanion(roomId: Value(newRoomId)));

        // 5. Tambah catatan audit log perpindahan
        final logId = _uuid.v4();
        await _db.into(_db.audit_logs).insert(
              AuditLogsCompanion.insert(
                id: logId,
                organizationId: contract.organizationId,
                userId: 'SYSTEM', // Pada auth lokal, akan disesuaikan dengan active user
                action: 'CHANGE_ROOM',
                description: 'Penghuni pindah kamar dari Room ID $oldRoomId ke Room ID $newRoomId',
                createdAt: Value(effectiveDate),
              ),
            );
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal melakukan pindah kamar: $e"));
    }
  }

  @override
  Future<Result<void>> renewContract(String oldContractId, ContractEntity newContract) async {
    try {
      await _db.transaction(() async {
        // 1. Tandai kontrak lama selesai
        final oldContractQuery = _db.update(_db.contracts)..where((t) => t.id.equals(oldContractId));
        await oldContractQuery.write(const ContractsCompanion(status: Value('completed')));

        // 2. Buat kontrak baru
        await createContract(newContract);
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal melakukan perpanjangan kontrak: $e"));
    }
  }

  @override
  Future<Result<List<InvoiceEntity>>> getInvoices(String organizationId) async {
    try {
      final query = _db.select(_db.invoices)
        ..where((t) => t.organizationId.equals(organizationId));
      final rows = await query.get();
      return Success(rows.map(_toInvoiceEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data tagihan: $e"));
    }
  }

  @override
  Future<Result<List<InvoiceEntity>>> getInvoicesByContract(String contractId) async {
    try {
      final query = _db.select(_db.invoices)..where((t) => t.contractId.equals(contractId));
      final rows = await query.get();
      return Success(rows.map(_toInvoiceEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data tagihan kontrak: $e"));
    }
  }

  @override
  Future<Result<InvoiceEntity>> getInvoiceById(String id) async {
    try {
      final query = _db.select(_db.invoices)..where((t) => t.id.equals(id));
      final row = await query.getSingle();
      return Success(_toInvoiceEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil detail tagihan: $e"));
    }
  }

  @override
  Future<Result<void>> generateScheduledInvoices(String organizationId, DateTime referenceDate) async {
    // Implementasi jika ada scheduler dinamis di SQLite. 
    // Karena kita sudah generate sekaligus di createContract, fungsi ini bisa me-return Success.
    return const Success(null);
  }

  @override
  Future<Result<void>> recordPayment({
    required PaymentEntity payment,
    required List<PaymentItemEntity> allocations,
  }) async {
    try {
      await _db.transaction(() async {
        // 1. Simpan pembayaran
        await _db.into(_db.payments).insert(
              PaymentsCompanion.insert(
                id: payment.id,
                organizationId: payment.organizationId,
                paymentDate: Value(payment.paymentDate),
                amount: CurrencyFormatter.toCents(payment.amount),
                paymentMethod: payment.paymentMethod,
                proofUrl: Value(payment.proofUrl),
                verified: Value(payment.verified),
                createdAt: Value(payment.createdAt),
              ),
            );

        // 2. Simpan alokasi dana
        for (var item in allocations) {
          await _db.into(_db.payment_items).insert(
                PaymentItemsCompanion.insert(
                  id: item.id,
                  paymentId: item.paymentId,
                  invoiceId: item.invoiceId,
                  amountAllocated: CurrencyFormatter.toCents(item.amountAllocated),
                ),
              );

          // 3. Update invoice terkait langsung jika pembayaran terverifikasi
          if (payment.verified) {
            await _updateInvoiceAmountPaid(item.invoiceId, item.amountAllocated);
          }
        }
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mencatat pembayaran: $e"));
    }
  }

  Future<void> _updateInvoiceAmountPaid(String invoiceId, double allocatedAmount) async {
    final invoice = await (_db.select(_db.invoices)..where((t) => t.id.equals(invoiceId))).getSingle();
    
    final allocatedCents = CurrencyFormatter.toCents(allocatedAmount);
    final newPaidCents = invoice.amountPaid + allocatedCents;
    
    String status = 'unpaid';
    if (newPaidCents >= invoice.amountDue) {
      status = 'paid';
    } else if (newPaidCents > 0) {
      status = 'partially_paid';
    }

    final query = _db.update(_db.invoices)..where((t) => t.id.equals(invoiceId));
    await query.write(
      InvoicesCompanion(
        amountPaid: Value(newPaidCents),
        status: Value(status),
      ),
    );
  }

  @override
  Future<Result<List<PaymentEntity>>> getPayments(String organizationId) async {
    try {
      final query = _db.select(_db.payments)
        ..where((t) => t.organizationId.equals(organizationId));
      final rows = await query.get();
      return Success(rows.map(_toPaymentEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data pembayaran: $e"));
    }
  }

  @override
  Future<Result<void>> verifyPayment(String paymentId) async {
    try {
      await _db.transaction(() async {
        // 1. Tandai pembayaran terverifikasi
        final query = _db.update(_db.payments)..where((t) => t.id.equals(paymentId));
        await query.write(const PaymentsCompanion(verified: Value(true)));

        // 2. Ambil seluruh item alokasi pembayaran ini
        final allocations = await (_db.select(_db.payment_items)
              ..where((t) => t.paymentId.equals(paymentId)))
            .get();

        // 3. Aplikasikan masing-masing item ke tagihan (invoices)
        for (var item in allocations) {
          final amountAllocatedRupiah = CurrencyFormatter.toRupiahDouble(item.amountAllocated);
          await _updateInvoiceAmountPaid(item.invoiceId, amountAllocatedRupiah);
        }
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memverifikasi pembayaran: $e"));
    }
  }

  @override
  Future<Result<Map<String, double>>> getDashboardMetrics(String organizationId, {String? propertyId}) async {
    try {
      // 1. Ambil data kamar
      var roomQuery = _db.select(_db.rooms);
      if (propertyId != null) {
        roomQuery = roomQuery..where((t) => t.propertyId.equals(propertyId));
      } else {
        // Scope by organization properties
        final propQuery = _db.select(_db.properties)
          ..where((t) => t.organizationId.equals(organizationId));
        final props = await propQuery.get();
        final propIds = props.map((p) => p.id).toList();
        if (propIds.isEmpty) {
          return const Success({
            'occupancy_rate': 0.0,
            'total_revenue': 0.0,
            'total_receivable': 0.0,
            'vacant_rooms': 0.0,
          });
        }
        roomQuery = roomQuery..where((t) => t.propertyId.isIn(propIds));
      }

      final rooms = await roomQuery.get();
      final totalRooms = rooms.length;
      final occupiedCount = rooms.where((r) => r.status == 'occupied' || r.status == 'reserved').length;
      final vacantCount = rooms.where((r) => r.status == 'vacant').length;
      final occupancyRate = totalRooms > 0 ? (occupiedCount / totalRooms) * 100 : 0.0;

      // 2. Ambil data tagihan (piutang)
      final invoiceQuery = _db.select(_db.invoices)
        ..where((t) => t.organizationId.equals(organizationId));
      final invoices = await invoiceQuery.get();

      double totalReceivable = 0.0;
      for (var inv in invoices) {
        if (inv.status != 'paid') {
          final diffCents = inv.amountDue - inv.amountPaid;
          totalReceivable += CurrencyFormatter.toRupiahDouble(diffCents);
        }
      }

      // 3. Pendapatan berjalan (total terbayar dari invoice yang terdaftar)
      // Kita bisa menghitung total pembayaran terverifikasi
      final paymentQuery = _db.select(_db.payments)
        ..where((t) => t.organizationId.equals(organizationId) & t.verified.equals(true));
      final payments = await paymentQuery.get();
      
      double totalRevenue = 0.0;
      for (var pay in payments) {
        totalRevenue += CurrencyFormatter.toRupiahDouble(pay.amount);
      }

      return Success({
        'occupancy_rate': occupancyRate,
        'total_revenue': totalRevenue,
        'total_receivable': totalReceivable,
        'vacant_rooms': vacantCount.toDouble(),
      });
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memuat metrik dashboard: $e"));
    }
  }
}
