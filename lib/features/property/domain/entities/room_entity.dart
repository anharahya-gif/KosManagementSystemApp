enum RoomStatus {
  vacant,
  occupied,
  reserved,
  maintenance,
  inactive;

  static RoomStatus fromString(String value) {
    return RoomStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RoomStatus.vacant,
    );
  }
}

class RoomEntity {
  final String id;
  final String propertyId;
  final String roomNumber;
  final String? buildingName;
  final String? floorName;
  final double pricePerMonth; // Real double value for UI (converted from cents in repo)
  final RoomStatus status;
  final DateTime createdAt;

  const RoomEntity({
    required this.id,
    required this.propertyId,
    required this.roomNumber,
    this.buildingName,
    this.floorName,
    required this.pricePerMonth,
    required this.status,
    required this.createdAt,
  });
}
