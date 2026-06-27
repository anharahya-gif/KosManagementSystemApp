import 'package:equatable/equatable.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';

abstract class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object?> get props => [];
}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractsLoaded extends ContractState {
  final List<ContractEntity> contracts;

  const ContractsLoaded(this.contracts);

  @override
  List<Object?> get props => [contracts];
}

class ContractActionSuccess extends ContractState {
  final String message;

  const ContractActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ContractError extends ContractState {
  final String message;

  const ContractError(this.message);

  @override
  List<Object?> get props => [message];
}
