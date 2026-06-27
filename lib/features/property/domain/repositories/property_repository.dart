import 'package:kms/core/utils/result.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';

abstract class PropertyRepository {
  Future<Result<List<PropertyEntity>>> getProperties(String organizationId);
  Future<Result<PropertyEntity>> getPropertyById(String id);
  Future<Result<void>> createProperty(PropertyEntity property);
  Future<Result<void>> updateProperty(PropertyEntity property);

  Future<Result<List<RoomEntity>>> getRooms(String propertyId);
  Future<Result<RoomEntity>> getRoomById(String id);
  Future<Result<void>> createRoom(RoomEntity room);
  Future<Result<void>> updateRoom(RoomEntity room);
  Future<Result<void>> updateRoomStatus(String roomId, RoomStatus status);
}
