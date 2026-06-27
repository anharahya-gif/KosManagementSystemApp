import 'package:kms/core/utils/result.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';

abstract class ResidentRepository {
  Future<Result<List<ResidentEntity>>> getResidents(String organizationId);
  Future<Result<ResidentEntity>> getResidentById(String id);
  Future<Result<void>> createResident(ResidentEntity resident);
  Future<Result<void>> updateResident(ResidentEntity resident);
  Future<Result<void>> updateResidentStatus(String residentId, ResidentStatus status);

  Future<Result<void>> softDeleteResident(String id);
  Future<Result<void>> restoreResident(String id);
  Future<Result<void>> hardDeleteResident(String id);
}
