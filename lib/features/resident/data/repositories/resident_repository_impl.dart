import 'package:drift/drift.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/errors/failures.dart';
import 'package:kms/core/utils/result.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';
import 'package:kms/features/resident/domain/repositories/resident_repository.dart';

class ResidentRepositoryImpl implements ResidentRepository {
  final AppDatabase _db;

  ResidentRepositoryImpl(this._db);

  ResidentEntity _toResidentEntity(Resident row) {
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
  }

  @override
  Future<Result<List<ResidentEntity>>> getResidents(String organizationId) async {
    try {
      final query = _db.select(_db.residents)
        ..where((t) => t.organizationId.equals(organizationId) & t.deletedAt.isNull());
      final rows = await query.get();
      return Success(rows.map(_toResidentEntity).toList());
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil data penghuni: $e"));
    }
  }

  @override
  Future<Result<ResidentEntity>> getResidentById(String id) async {
    try {
      final query = _db.select(_db.residents)..where((t) => t.id.equals(id));
      final row = await query.getSingle();
      return Success(_toResidentEntity(row));
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mengambil detail penghuni: $e"));
    }
  }

  @override
  Future<Result<void>> createResident(ResidentEntity resident) async {
    try {
      await _db.into(_db.residents).insert(
            ResidentsCompanion.insert(
              id: resident.id,
              organizationId: resident.organizationId,
              userId: Value(resident.userId),
              fullName: resident.fullName,
              phoneNumber: resident.phoneNumber,
              email: Value(resident.email),
              idCardNumber: Value(resident.idCardNumber),
              status: Value(resident.status.name),
              createdAt: Value(resident.createdAt),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal mendaftarkan penghuni baru: $e"));
    }
  }

  @override
  Future<Result<void>> updateResident(ResidentEntity resident) async {
    try {
      await _db.update(_db.residents).replace(
            ResidentsCompanion(
              id: Value(resident.id),
              organizationId: Value(resident.organizationId),
              userId: Value(resident.userId),
              fullName: Value(resident.fullName),
              phoneNumber: Value(resident.phoneNumber),
              email: Value(resident.email),
              idCardNumber: Value(resident.idCardNumber),
              status: Value(resident.status.name),
            ),
          );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memperbarui profil penghuni: $e"));
    }
  }

  @override
  Future<Result<void>> updateResidentStatus(String residentId, ResidentStatus status) async {
    try {
      final query = _db.update(_db.residents)..where((t) => t.id.equals(residentId));
      await query.write(
        ResidentsCompanion(
          status: Value(status.name),
        ),
      );
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memperbarui status penghuni: $e"));
    }
  }

  @override
  Future<Result<void>> softDeleteResident(String id) async {
    try {
      final now = DateTime.now();
      final query = _db.update(_db.residents)..where((t) => t.id.equals(id));
      await query.write(ResidentsCompanion(deletedAt: Value(now)));
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus penghuni (soft delete): $e"));
    }
  }

  @override
  Future<Result<void>> restoreResident(String id) async {
    try {
      final query = _db.update(_db.residents)..where((t) => t.id.equals(id));
      await query.write(const ResidentsCompanion(deletedAt: Value(null)));
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal memulihkan data penghuni: $e"));
    }
  }

  @override
  Future<Result<void>> hardDeleteResident(String id) async {
    try {
      final query = _db.delete(_db.residents)..where((t) => t.id.equals(id));
      await query.go();
      return const Success(null);
    } catch (e) {
      return FailureResult(DatabaseFailure("Gagal menghapus permanen penghuni: $e"));
    }
  }
}
