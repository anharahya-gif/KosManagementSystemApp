import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';
import 'package:kms/features/resident/domain/repositories/resident_repository.dart';
import 'package:kms/features/resident/presentation/cubit/resident_state.dart';

class ResidentCubit extends Cubit<ResidentState> {
  final ResidentRepository _repository;

  ResidentCubit(this._repository) : super(ResidentInitial());

  Future<void> fetchResidents(String organizationId) async {
    emit(ResidentLoading());
    final result = await _repository.getResidents(organizationId);
    if (result.isSuccess) {
      emit(ResidentsLoaded(result.dataOrNull!));
    } else {
      emit(ResidentError(result.failureOrNull!.message));
    }
  }

  Future<void> addResident(ResidentEntity resident) async {
    emit(ResidentLoading());
    final result = await _repository.createResident(resident);
    if (result.isSuccess) {
      emit(const ResidentActionSuccess("Penghuni berhasil didaftarkan."));
      fetchResidents(resident.organizationId);
    } else {
      emit(ResidentError(result.failureOrNull!.message));
    }
  }

  Future<void> editResident(ResidentEntity resident) async {
    emit(ResidentLoading());
    final result = await _repository.updateResident(resident);
    if (result.isSuccess) {
      emit(const ResidentActionSuccess("Profil penghuni berhasil diperbarui."));
      fetchResidents(resident.organizationId);
    } else {
      emit(ResidentError(result.failureOrNull!.message));
    }
  }
}
