import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/domain/entities/payment_entity.dart';
import 'package:kms/features/contract/domain/repositories/contract_repository.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final ContractRepository _repository;

  InvoiceCubit(this._repository) : super(InvoiceInitial());

  Future<void> fetchInvoices(String organizationId) async {
    emit(InvoiceLoading());
    final result = await _repository.getInvoices(organizationId);
    if (result.isSuccess) {
      emit(InvoicesLoaded(result.dataOrNull!));
    } else {
      emit(InvoiceError(result.failureOrNull!.message));
    }
  }

  Future<void> fetchInvoicesByContract(String contractId) async {
    emit(InvoiceLoading());
    final result = await _repository.getInvoicesByContract(contractId);
    if (result.isSuccess) {
      emit(InvoicesLoaded(result.dataOrNull!));
    } else {
      emit(InvoiceError(result.failureOrNull!.message));
    }
  }

  Future<void> addPayment({
    required PaymentEntity payment,
    required List<PaymentItemEntity> allocations,
  }) async {
    emit(InvoiceLoading());
    final result = await _repository.recordPayment(
      payment: payment,
      allocations: allocations,
    );
    if (result.isSuccess) {
      emit(const InvoiceActionSuccess("Pembayaran berhasil dicatat."));
      fetchInvoices(payment.organizationId);
    } else {
      emit(InvoiceError(result.failureOrNull!.message));
    }
  }

  Future<void> confirmPaymentVerification(String paymentId, String organizationId) async {
    emit(InvoiceLoading());
    final result = await _repository.verifyPayment(paymentId);
    if (result.isSuccess) {
      emit(const InvoiceActionSuccess("Pembayaran berhasil diverifikasi."));
      fetchInvoices(organizationId);
    } else {
      emit(InvoiceError(result.failureOrNull!.message));
    }
  }
}
