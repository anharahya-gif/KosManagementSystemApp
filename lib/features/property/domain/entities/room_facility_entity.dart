enum RoomFacilityCondition {
  good,
  broken,
  needsRepair;

  static RoomFacilityCondition fromString(String value) {
    switch (value) {
      case 'broken':
        return RoomFacilityCondition.broken;
      case 'needs_repair':
      case 'needsRepair':
        return RoomFacilityCondition.needsRepair;
      case 'good':
      default:
        return RoomFacilityCondition.good;
    }
  }

  String toDbValue() {
    switch (this) {
      case RoomFacilityCondition.broken:
        return 'broken';
      case RoomFacilityCondition.needsRepair:
        return 'needs_repair';
      case RoomFacilityCondition.good:
      default:
        return 'good';
    }
  }

  String toReadableString() {
    switch (this) {
      case RoomFacilityCondition.broken:
        return 'Rusak';
      case RoomFacilityCondition.needsRepair:
        return 'Perlu Perbaikan';
      case RoomFacilityCondition.good:
      default:
        return 'Bagus';
    }
  }
}

class RoomFacilityEntity {
  final String id;
  final String roomId;
  final String name;
  final RoomFacilityCondition condition;
  final String? description;
  final DateTime createdAt;

  const RoomFacilityEntity({
    required this.id,
    required this.roomId,
    required this.name,
    required this.condition,
    this.description,
    required this.createdAt,
  });
}
