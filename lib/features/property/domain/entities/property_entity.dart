class PropertyEntity {
  final String id;
  final String organizationId;
  final String name;
  final String address;
  final String type; // 'kos', 'kontrakan', 'apartment', 'guesthouse'
  final double? latitude;
  final double? longitude;
  final int managerSharePercent;
  final DateTime? deletedAt;
  final DateTime createdAt;

  const PropertyEntity({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.address,
    required this.type,
    this.latitude,
    this.longitude,
    this.managerSharePercent = 10,
    this.deletedAt,
    required this.createdAt,
  });
}
