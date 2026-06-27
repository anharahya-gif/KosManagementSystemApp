import 'package:equatable/equatable.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';

abstract class RecycleBinState extends Equatable {
  const RecycleBinState();

  @override
  List<Object?> get props => [];
}

class RecycleBinInitial extends RecycleBinState {}

class RecycleBinLoading extends RecycleBinState {}

class RecycleBinLoaded extends RecycleBinState {
  final List<PropertyEntity> deletedProperties;
  final List<RoomEntity> deletedRooms;
  final List<ResidentEntity> deletedResidents;

  const RecycleBinLoaded({
    required this.deletedProperties,
    required this.deletedRooms,
    required this.deletedResidents,
  });

  @override
  List<Object?> get props => [deletedProperties, deletedRooms, deletedResidents];
}

class RecycleBinActionSuccess extends RecycleBinState {
  final String message;

  const RecycleBinActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class RecycleBinError extends RecycleBinState {
  final String message;

  const RecycleBinError(this.message);

  @override
  List<Object?> get props => [message];
}
