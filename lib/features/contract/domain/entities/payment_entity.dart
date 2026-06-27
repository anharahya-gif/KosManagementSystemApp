class PaymentEntity {
  final String id;
  final String organizationId;
  final DateTime paymentDate;
  final double amount;
  final String paymentMethod; // 'transfer', 'cash', 'qris'
  final String? proofUrl;
  final bool verified;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.organizationId,
    required this.paymentDate,
    required this.amount,
    required this.paymentMethod,
    this.proofUrl,
    required this.verified,
    required this.createdAt,
  });
}

class PaymentItemEntity {
  final String id;
  final String paymentId;
  final String invoiceId;
  final double amountAllocated;

  const PaymentItemEntity({
    required this.id,
    required this.paymentId,
    required this.invoiceId,
    required this.amountAllocated,
  });
}
