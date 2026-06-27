import 'package:equatable/equatable.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/domain/entities/payment_entity.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object?> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoicesLoaded extends InvoiceState {
  final List<InvoiceEntity> invoices;

  const InvoicesLoaded(this.invoices);

  @override
  List<Object?> get props => [invoices];
}

class InvoiceActionSuccess extends InvoiceState {
  final String message;

  const InvoiceActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class InvoiceError extends InvoiceState {
  final String message;

  const InvoiceError(this.message);

  @override
  List<Object?> get props => [message];
}
