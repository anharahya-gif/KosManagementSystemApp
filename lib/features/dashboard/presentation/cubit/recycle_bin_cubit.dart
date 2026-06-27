import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/features/dashboard/presentation/cubit/recycle_bin_state.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/domain/repositories/property_repository.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';
import 'package:kms/features/resident/domain/repositories/resident_repository.dart';

class RecycleBinCubit extends Cubit<RecycleBinState> {
  final AppDatabase _db;
  final PropertyRepository _propertyRepository;
  final ResidentRepository _residentRepository;

  RecycleBinCubit({
    required AppDatabase db,
    required PropertyRepository propertyRepository,
    required ResidentRepository residentRepository,
  })  : _db = db,
        _propertyRepository = propertyRepository,
        _residentRepository = residentRepository,
        super(RecycleBinInitial());

  /// Memuat semua item yang ter-soft-delete dalam organisasi
  Future<void> fetchDeletedItems(String organizationId) async {
    emit(RecycleBinLoading());
    try {
      // 1. Ambil properti terhapus
      final propertiesQuery = _db.select(_db.properties)
        ..where((t) => t.organizationId.equals(organizationId) & t.deletedAt.isNotNull());
      final deletedPropRows = await propertiesQuery.get();
      final deletedProperties = deletedPropRows.map((row) {
        return PropertyEntity(
          id: row.id,
          organizationId: row.organizationId,
          name: row.name,
          address: row.address,
          type: row.type,
          latitude: row.latitude,
          longitude: row.longitude,
          deletedAt: row.deletedAt,
          createdAt: row.createdAt,
        );
      }).toList();

      // 2. Ambil kamar terhapus
      // Kita perlu mencocokkan properti milik organisasi ini terlebih dahulu
      final properties = await (_db.select(_db.properties)
            ..where((t) => t.organizationId.equals(organizationId)))
          .get();
      final propIds = properties.map((p) => p.id).toList();

      List<RoomEntity> deletedRooms = [];
      if (propIds.isNotEmpty) {
        final roomsQuery = _db.select(_db.rooms)
          ..where((t) => t.propertyId.isIn(propIds) & t.deletedAt.isNotNull());
        final deletedRoomRows = await roomsQuery.get();
        deletedRooms = deletedRoomRows.map((row) {
          return RoomEntity(
            id: row.id,
            propertyId: row.propertyId,
            roomNumber: row.roomNumber,
            buildingName: row.buildingName,
            floorName: row.floorName,
            pricePerMonth: CurrencyFormatter.toRupiahDouble(row.pricePerMonth),
            status: RoomStatus.fromString(row.status),
            deletedAt: row.deletedAt,
            createdAt: row.createdAt,
          );
        }).toList();
      }

      // 3. Ambil penghuni terhapus
      final residentsQuery = _db.select(_db.residents)
        ..where((t) => t.organizationId.equals(organizationId) & t.deletedAt.isNotNull());
      final deletedResRows = await residentsQuery.get();
      final deletedResidents = deletedResRows.map((row) {
        return ResidentEntity(
          id: row.id,
          organizationId: row.organizationId,
          userId: row.userId,
          fullName: row.fullName,
          phoneNumber: row.phoneNumber,
          email: row.email,
          idCardNumber: row.idCardNumber,
          status: ResidentStatus.fromString(row.status),
          deletedAt: row.deletedAt,
          createdAt: row.createdAt,
        );
      }).toList();

      emit(RecycleBinLoaded(
        deletedProperties: deletedProperties,
        deletedRooms: deletedRooms,
        deletedResidents: deletedResidents,
      ));
    } catch (e) {
      emit(RecycleBinError("Gagal mengambil isi Recycle Bin: $e"));
    }
  }

  /// Memulihkan item dari Recycle Bin
  Future<void> restoreItem(String type, String id, String organizationId) async {
    emit(RecycleBinLoading());
    try {
      if (type == 'property') {
        final res = await _propertyRepository.restoreProperty(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      } else if (type == 'room') {
        final res = await _propertyRepository.restoreRoom(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      } else if (type == 'resident') {
        final res = await _residentRepository.restoreResident(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      }
      emit(const RecycleBinActionSuccess("Item berhasil dipulihkan."));
      fetchDeletedItems(organizationId);
    } catch (e) {
      emit(RecycleBinError("Gagal memulihkan data: $e"));
    }
  }

  /// Menghapus item secara permanen (Hard Delete)
  Future<void> hardDeleteItem(String type, String id, String organizationId) async {
    emit(RecycleBinLoading());
    try {
      if (type == 'property') {
        final res = await _propertyRepository.hardDeleteProperty(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      } else if (type == 'room') {
        final res = await _propertyRepository.hardDeleteRoom(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      } else if (type == 'resident') {
        final res = await _residentRepository.hardDeleteResident(id);
        if (res.isFailure) throw Exception(res.failureOrNull!.message);
      }
      emit(const RecycleBinActionSuccess("Item dihapus permanen dari database."));
      fetchDeletedItems(organizationId);
    } catch (e) {
      emit(RecycleBinError("Gagal menghapus data secara permanen: $e"));
    }
  }
}
