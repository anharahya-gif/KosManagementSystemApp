import 'package:equatable/equatable.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';

abstract class ResidentState extends Equatable {
  const ResidentState();

  @override
  List<Object?> get props => [];
}

class ResidentInitial extends ResidentState {}

class ResidentLoading extends ResidentState {}

class ResidentsLoaded extends ResidentState {
  final List<ResidentEntity> residents;

  const ResidentsLoaded(this.residents);

  @override
  List<Object?> get props => [residents];
}

class ResidentActionSuccess extends ResidentState {
  final String message;

  const ResidentActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ResidentError extends ResidentState {
  final String message;

  const ResidentError(this.message);

  @override
  List<Object?> get props => [message];
}
