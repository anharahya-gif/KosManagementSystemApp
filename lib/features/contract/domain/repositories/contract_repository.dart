import 'package:kms/core/utils/result.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/domain/entities/payment_entity.dart';

abstract class ContractRepository {
  // Contracts
  Future<Result<List<ContractEntity>>> getContracts(String organizationId);
  Future<Result<ContractEntity>> getContractById(String id);
  Future<Result<void>> createContract(ContractEntity contract);
  Future<Result<void>> terminateContract(String contractId, DateTime terminationDate);
  Future<Result<void>> changeRoom(String contractId, String newRoomId, DateTime effectiveDate);
  Future<Result<void>> renewContract(String oldContractId, ContractEntity newContract);

  // Invoices
  Future<Result<List<InvoiceEntity>>> getInvoices(String organizationId);
  Future<Result<List<InvoiceEntity>>> getInvoicesByContract(String contractId);
  Future<Result<InvoiceEntity>> getInvoiceById(String id);
  Future<Result<void>> generateScheduledInvoices(String organizationId, DateTime referenceDate);

  // Payments
  Future<Result<void>> recordPayment({
    required PaymentEntity payment,
    required List<PaymentItemEntity> allocations,
  });
  Future<Result<List<PaymentEntity>>> getPayments(String organizationId);
  Future<Result<void>> verifyPayment(String paymentId);

  // Dashboard Metrics
  Future<Result<Map<String, double>>> getDashboardMetrics(String organizationId, {String? propertyId});
}
