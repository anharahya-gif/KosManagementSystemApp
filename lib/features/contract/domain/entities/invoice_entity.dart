enum InvoiceStatus {
  unpaid,
  partiallyPaid,
  paid,
  overdue;

  static InvoiceStatus fromString(String value) {
    switch (value) {
      case 'partially_paid':
        return InvoiceStatus.partiallyPaid;
      case 'paid':
        return InvoiceStatus.paid;
      case 'overdue':
        return InvoiceStatus.overdue;
      case 'unpaid':
      default:
        return InvoiceStatus.unpaid;
    }
  }

  String toDbString() {
    switch (this) {
      case InvoiceStatus.partiallyPaid:
        return 'partially_paid';
      case InvoiceStatus.paid:
        return 'paid';
      case InvoiceStatus.overdue:
        return 'overdue';
      case InvoiceStatus.unpaid:
      default:
        return 'unpaid';
    }
  }
}

class InvoiceEntity {
  final String id;
  final String organizationId;
  final String contractId;
  final String invoiceNumber;
  final DateTime dueDate;
  final double amountDue;
  final double amountPaid;
  final InvoiceStatus status;
  final DateTime createdAt;

  const InvoiceEntity({
    required this.id,
    required this.organizationId,
    required this.contractId,
    required this.invoiceNumber,
    required this.dueDate,
    required this.amountDue,
    required this.amountPaid,
    required this.status,
    required this.createdAt,
  });

  double get remainingDebt => amountDue - amountPaid;
}
