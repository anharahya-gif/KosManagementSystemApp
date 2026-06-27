enum ResidentStatus {
  prospective,
  active,
  moved,
  checkedOut,
  inactive;

  static ResidentStatus fromString(String value) {
    return ResidentStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ResidentStatus.prospective,
    );
  }
}

class ResidentEntity {
  final String id;
  final String organizationId;
  final String? userId; // linked app account ID
  final String fullName;
  final String phoneNumber;
  final String? email;
  final String? idCardNumber;
  final ResidentStatus status;
  final DateTime createdAt;

  const ResidentEntity({
    required this.id,
    required this.organizationId,
    this.userId,
    required this.fullName,
    required this.phoneNumber,
    this.email,
    this.idCardNumber,
    required this.status,
    required this.createdAt,
  });
}
