enum UserRole {
  owner,
  manager,
  resident;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.resident,
    );
  }
}

class UserProfileEntity {
  final String id;
  final String organizationId;
  final String fullName;
  final String phoneNumber;
  final String email;
  final UserRole role;

  const UserProfileEntity({
    required this.id,
    required this.organizationId,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  bool get isOwner => role == UserRole.owner;
  bool get isManager => role == UserRole.manager;
  bool get isResident => role == UserRole.resident;
}
