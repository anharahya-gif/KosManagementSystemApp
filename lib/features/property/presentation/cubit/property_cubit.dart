import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/domain/repositories/property_repository.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository _repository;

  PropertyCubit(this._repository) : super(PropertyInitial());

  Future<void> fetchProperties(String organizationId) async {
    emit(PropertyLoading());
    final result = await _repository.getProperties(organizationId);
    if (result.isSuccess) {
      emit(PropertiesLoaded(result.dataOrNull!));
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> fetchPropertyDetail(String propertyId) async {
    emit(PropertyLoading());
    final propResult = await _repository.getPropertyById(propertyId);
    if (propResult.isSuccess) {
      final roomsResult = await _repository.getRooms(propertyId);
      if (roomsResult.isSuccess) {
        emit(PropertyDetailLoaded(
          property: propResult.dataOrNull!,
          rooms: roomsResult.dataOrNull!,
        ));
      } else {
        emit(PropertyError(roomsResult.failureOrNull!.message));
      }
    } else {
      emit(PropertyError(propResult.failureOrNull!.message));
    }
  }

  Future<void> addProperty(PropertyEntity property) async {
    emit(PropertyLoading());
    final result = await _repository.createProperty(property);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Properti berhasil ditambahkan."));
      fetchProperties(property.organizationId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> editProperty(PropertyEntity property) async {
    emit(PropertyLoading());
    final result = await _repository.updateProperty(property);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Properti berhasil diperbarui."));
      fetchProperties(property.organizationId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> addRoom(RoomEntity room) async {
    emit(PropertyLoading());
    final result = await _repository.createRoom(room);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Kamar berhasil ditambahkan."));
      fetchPropertyDetail(room.propertyId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> editRoom(RoomEntity room) async {
    emit(PropertyLoading());
    final result = await _repository.updateRoom(room);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Kamar berhasil diperbarui."));
      fetchPropertyDetail(room.propertyId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> toggleRoomMaintenance(String roomId, String propertyId, bool isMaintenance) async {
    emit(PropertyLoading());
    final status = isMaintenance ? RoomStatus.maintenance : RoomStatus.vacant;
    final result = await _repository.updateRoomStatus(roomId, status);
    if (result.isSuccess) {
      emit(PropertyActionSuccess(isMaintenance
          ? "Kamar berhasil dimasukkan ke daftar perbaikan."
          : "Kamar selesai diperbaiki dan siap disewa."));
      fetchPropertyDetail(propertyId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> softDeleteProperty(String id, String organizationId) async {
    emit(PropertyLoading());
    final result = await _repository.softDeleteProperty(id);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Properti berhasil dipindahkan ke kotak sampah."));
      fetchProperties(organizationId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }

  Future<void> softDeleteRoom(String id, String propertyId) async {
    emit(PropertyLoading());
    final result = await _repository.softDeleteRoom(id);
    if (result.isSuccess) {
      emit(const PropertyActionSuccess("Kamar berhasil dipindahkan ke kotak sampah."));
      fetchPropertyDetail(propertyId);
    } else {
      emit(PropertyError(result.failureOrNull!.message));
    }
  }
}
