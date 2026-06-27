import 'package:equatable/equatable.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';

abstract class PropertyState extends Equatable {
  const PropertyState();

  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState {}

class PropertyLoading extends PropertyState {}

class PropertiesLoaded extends PropertyState {
  final List<PropertyEntity> properties;

  const PropertiesLoaded(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyDetailLoaded extends PropertyState {
  final PropertyEntity property;
  final List<RoomEntity> rooms;

  const PropertyDetailLoaded({required this.property, required this.rooms});

  @override
  List<Object?> get props => [property, rooms];
}

class PropertyActionSuccess extends PropertyState {
  final String message;

  const PropertyActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PropertyError extends PropertyState {
  final String message;

  const PropertyError(this.message);

  @override
  List<Object?> get props => [message];
}
