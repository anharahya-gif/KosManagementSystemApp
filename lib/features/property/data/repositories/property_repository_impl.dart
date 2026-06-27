import 'package:drift/drift.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/errors/failures.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/result.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/domain/repositories/property_repository.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final AppDatabase _db;

  PropertyRepositoryImpl(this._db);

  PropertyEntity _toPropertyEntity(Property row) {
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
  }

  RoomEntity _toRoomEntity(Room row) {
    return RoomEntity(
      id: row.id,
      propertyId: row.propertyId,
      roomNumber: row.roomNumber,
      buildingName: row.buildingName,
      floorName: row.floorName,
      pricePerMonth: CurrencyFormatter.toRupiahDouble(row.pricePerMonth),
      status: RoomStatus.fromString(row.status),
      images: row.images != null && row.images!.isNotEmpty ? row.images!.split(',') : const [],
      facilities: row.facilities != null && row.facilities!.isNotEmpty ? row.facilities!.split(',') : const [],
      deletedAt: row.deletedAt,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<Result<List<PropertyEntity>>> getProperties(String organizationId) async {
    try {
      final query = _db.select(_db.properties)
        ..where((t) => t.organizationId.equals(organizationId) & t.deletedAt.isNull());
      final rows = await query.get();
      return Success(rows.map(_toPropertyEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data properti: $e"));
    }
  }

  @override
  Future<Result<PropertyEntity>> getPropertyById(String id) async {
    try {
      final query = _db.select(_db.properties)..where((t) => t.id.equals(id));
      final row = await query.getSingle();
      return Success(_toPropertyEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil detail properti: $e"));
    }
  }

  @override
  Future<Result<void>> createProperty(PropertyEntity property) async {
    try {
      await _db.into(_db.properties).insert(
            PropertiesCompanion.insert(
              id: property.id,
              organizationId: property.organizationId,
              name: property.name,
              address: property.address,
              type: property.type,
              latitude: Value(property.latitude),
              longitude: Value(property.longitude),
              createdAt: Value(property.createdAt),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menyimpan properti: $e"));
    }
  }

  @override
  Future<Result<void>> updateProperty(PropertyEntity property) async {
    try {
      await _db.update(_db.properties).replace(
            PropertiesCompanion(
              id: Value(property.id),
              organizationId: Value(property.organizationId),
              name: Value(property.name),
              address: Value(property.address),
              latitude: Value(property.latitude),
              longitude: Value(property.longitude),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memperbarui properti: $e"));
    }
  }

  @override
  Future<Result<List<RoomEntity>>> getRooms(String propertyId) async {
    try {
      final query = _db.select(_db.rooms)
        ..where((t) => t.propertyId.equals(propertyId) & t.deletedAt.isNull());
      final rows = await query.get();
      return Success(rows.map(_toRoomEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data kamar: $e"));
    }
  }

  @override
  Future<Result<RoomEntity>> getRoomById(String id) async {
    try {
      final query = _db.select(_db.rooms)..where((t) => t.id.equals(id));
      final row = await query.getSingle();
      return Success(_toRoomEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil detail kamar: $e"));
    }
  }

  @override
  Future<Result<void>> createRoom(RoomEntity room) async {
    try {
      await _db.into(_db.rooms).insert(
            RoomsCompanion.insert(
              id: room.id,
              propertyId: room.propertyId,
              roomNumber: room.roomNumber,
              buildingName: Value(room.buildingName),
              floorName: Value(room.floorName),
              pricePerMonth: CurrencyFormatter.toCents(room.pricePerMonth),
              status: Value(room.status.name),
              images: Value(room.images.join(',')),
              facilities: Value(room.facilities.join(',')),
              createdAt: Value(room.createdAt),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal membuat kamar baru: $e"));
    }
  }

  @override
  Future<Result<void>> updateRoom(RoomEntity room) async {
    try {
      await _db.update(_db.rooms).replace(
            RoomsCompanion(
              id: Value(room.id),
              propertyId: Value(room.propertyId),
              roomNumber: Value(room.roomNumber),
              buildingName: Value(room.buildingName),
              floorName: Value(room.floorName),
              pricePerMonth: Value(CurrencyFormatter.toCents(room.pricePerMonth)),
              status: Value(room.status.name),
              images: Value(room.images.join(',')),
              facilities: Value(room.facilities.join(',')),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memperbarui data kamar: $e"));
    }
  }

  @override
  Future<Result<void>> updateRoomStatus(String roomId, RoomStatus status) async {
    try {
      final query = _db.update(_db.rooms)..where((t) => t.id.equals(roomId));
      await query.write(
        RoomsCompanion(
          status: Value(status.name),
        ),
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memperbarui status kamar: $e"));
    }
  }

  @override
  Future<Result<void>> softDeleteProperty(String id) async {
    try {
      await _db.transaction(() async {
        final now = DateTime.now();
        // 1. Soft delete properti
        final propQuery = _db.update(_db.properties)..where((t) => t.id.equals(id));
        await propQuery.write(PropertiesCompanion(deletedAt: Value(now)));

        // 2. Soft delete semua kamar di properti ini
        final roomQuery = _db.update(_db.rooms)..where((t) => t.propertyId.equals(id));
        await roomQuery.write(RoomsCompanion(deletedAt: Value(now)));
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus properti (soft delete): $e"));
    }
  }

  @override
  Future<Result<void>> restoreProperty(String id) async {
    try {
      await _db.transaction(() async {
        // 1. Restore properti
        final propQuery = _db.update(_db.properties)..where((t) => t.id.equals(id));
        await propQuery.write(const PropertiesCompanion(deletedAt: Value(null)));

        // 2. Restore semua kamar di properti ini
        final roomQuery = _db.update(_db.rooms)..where((t) => t.propertyId.equals(id));
        await roomQuery.write(const RoomsCompanion(deletedAt: Value(null)));
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memulihkan properti: $e"));
    }
  }

  @override
  Future<Result<void>> hardDeleteProperty(String id) async {
    try {
      await _db.transaction(() async {
        // Hapus kamar permanen
        final roomQuery = _db.delete(_db.rooms)..where((t) => t.propertyId.equals(id));
        await roomQuery.go();

        // Hapus properti permanen
        final propQuery = _db.delete(_db.properties)..where((t) => t.id.equals(id));
        await propQuery.go();
      });
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus permanen properti: $e"));
    }
  }

  @override
  Future<Result<void>> softDeleteRoom(String id) async {
    try {
      final now = DateTime.now();
      final query = _db.update(_db.rooms)..where((t) => t.id.equals(id));
      await query.write(RoomsCompanion(deletedAt: Value(now)));
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus kamar (soft delete): $e"));
    }
  }

  @override
  Future<Result<void>> restoreRoom(String id) async {
    try {
      final query = _db.update(_db.rooms)..where((t) => t.id.equals(id));
      await query.write(const RoomsCompanion(deletedAt: Value(null)));
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memulihkan kamar: $e"));
    }
  }

  @override
  Future<Result<void>> hardDeleteRoom(String id) async {
    try {
      final query = _db.delete(_db.rooms)..where((t) => t.id.equals(id));
      await query.go();
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus permanen kamar: $e"));
    }
  }
}
