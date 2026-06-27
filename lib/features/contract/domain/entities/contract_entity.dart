enum ContractStatus {
  active,
  completed,
  terminated;

  static ContractStatus fromString(String value) {
    return ContractStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ContractStatus.active,
    );
  }
}

class ContractEntity {
  final String id;
  final String organizationId;
  final String residentId;
  final String roomId;
  final DateTime startDate;
  final DateTime endDate;
  final String billingCycle; // 'monthly', 'yearly'
  final double pricePerCycle;
  final double depositAmount;
  final ContractStatus status;
  final DateTime createdAt;

  const ContractEntity({
    required this.id,
    required this.organizationId,
    required this.residentId,
    required this.roomId,
    required this.startDate,
    required this.endDate,
    required this.billingCycle,
    required this.pricePerCycle,
    required this.depositAmount,
    required this.status,
    required this.createdAt,
  });
}
