import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';
import 'package:kms/features/contract/domain/repositories/contract_repository.dart';
import 'package:kms/features/contract/presentation/cubit/contract_state.dart';

class ContractCubit extends Cubit<ContractState> {
  final ContractRepository _repository;

  ContractCubit(this._repository) : super(ContractInitial());

  Future<void> fetchContracts(String organizationId) async {
    emit(ContractLoading());
    final result = await _repository.getContracts(organizationId);
    if (result.isSuccess) {
      emit(ContractsLoaded(result.dataOrNull!));
    } else {
      emit(ContractError(result.failureOrNull!.message));
    }
  }

  Future<void> addContract(ContractEntity contract) async {
    emit(ContractLoading());
    final result = await _repository.createContract(contract);
    if (result.isSuccess) {
      emit(const ContractActionSuccess("Kontrak berhasil diaktifkan."));
      fetchContracts(contract.organizationId);
    } else {
      emit(ContractError(result.failureOrNull!.message));
    }
  }

  Future<void> stopContract(String contractId, String organizationId, DateTime terminationDate) async {
    emit(ContractLoading());
    final result = await _repository.terminateContract(contractId, terminationDate);
    if (result.isSuccess) {
      emit(const ContractActionSuccess("Kontrak berhasil dihentikan."));
      fetchContracts(organizationId);
    } else {
      emit(ContractError(result.failureOrNull!.message));
    }
  }

  Future<void> moveRoom(String contractId, String organizationId, String newRoomId, DateTime effectiveDate) async {
    emit(ContractLoading());
    final result = await _repository.changeRoom(contractId, newRoomId, effectiveDate);
    if (result.isSuccess) {
      emit(const ContractActionSuccess("Berhasil melakukan pindah kamar."));
      fetchContracts(organizationId);
    } else {
      emit(ContractError(result.failureOrNull!.message));
    }
  }

  Future<void> extendContract(String oldContractId, String organizationId, ContractEntity newContract) async {
    emit(ContractLoading());
    final result = await _repository.renewContract(oldContractId, newContract);
    if (result.isSuccess) {
      emit(const ContractActionSuccess("Kontrak berhasil diperpanjang."));
      fetchContracts(organizationId);
    } else {
      emit(ContractError(result.failureOrNull!.message));
    }
  }
}
