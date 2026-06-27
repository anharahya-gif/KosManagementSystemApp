import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/domain/entities/payment_entity.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_cubit.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_state.dart';
import 'package:uuid/uuid.dart';

class RecordPaymentPage extends StatefulWidget {
  final String organizationId;
  final List<InvoiceEntity> invoicesToPay;

  const RecordPaymentPage({
    super.key,
    required this.organizationId,
    required this.invoicesToPay,
  });

  @override
  State<RecordPaymentPage> createState() => _RecordPaymentPageState();
}

class _RecordPaymentPageState extends State<RecordPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedMethod = 'transfer';
  DateTime _paymentDate = DateTime.now();

  late InvoiceCubit _invoiceCubit;
  double _totalOutstanding = 0.0;

  // Menyimpan data alokasi bayar hasil kalkulasi
  List<Map<String, dynamic>> _allocationsPreview = [];

  @override
  void initState() {
    super.initState();
    _invoiceCubit = sl<InvoiceCubit>();

    // Hitung total piutang yang dipilih
    for (var inv in widget.invoicesToPay) {
      _totalOutstanding += inv.remainingDebt;
    }

    _amountController.text = _totalOutstanding.toStringAsFixed(0);
    _calculateAllocations(_totalOutstanding);
  }

  /// Melakukan simulasi alokasi dana secara real-time berdasarkan input nominal
  void _calculateAllocations(double inputAmount) {
    double money = inputAmount;
    List<Map<String, dynamic>> previews = [];

    for (var inv in widget.invoicesToPay) {
      final outstanding = inv.remainingDebt;
      double allocated = 0.0;

      if (money > 0) {
        allocated = money >= outstanding ? outstanding : money;
        money -= allocated;
      }

      previews.add({
        'invoice': inv,
        'allocated': allocated,
        'remaining': outstanding - allocated,
      });
    }

    setState(() {
      _allocationsPreview = previews;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _invoiceCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CATAT PEMBAYARAN'),
        ),
        body: BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceActionSuccess) {
              Navigator.pop(context, true); // Pop and refresh
            }

            if (state is InvoiceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSummaryCard(),
                  const SizedBox(height: 24),
                  const Text(
                    'Detail Transaksi Pembayaran',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Uang Diterima (Rp)',
                    ),
                    onChanged: (val) {
                      final input = double.tryParse(val.trim()) ?? 0.0;
                      _calculateAllocations(input);
                    },
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Jumlah uang tidak boleh kosong';
                      }
                      final amount = double.tryParse(val.trim());
                      if (amount == null || amount <= 0) {
                        return 'Masukkan jumlah uang yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedMethod,
                    decoration: const InputDecoration(
                      labelText: 'Metode Pembayaran',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'transfer', child: Text('Transfer Bank')),
                      DropdownMenuItem(value: 'cash', child: Text('Cash / Tunai')),
                      DropdownMenuItem(value: 'qris', child: Text('QRIS')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedMethod = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal Bayar:', style: TextStyle(fontSize: 14)),
                      OutlinedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _paymentDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _paymentDate = picked;
                            });
                          }
                        },
                        child: Text(DateFormatter.formatDateTimeReadable(_paymentDate)),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Simulasi Alokasi Tagihan (FIFO)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  _buildAllocationsPreviewList(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: state is InvoiceLoading ? null : _submit,
                    child: state is InvoiceLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Simpan Pembayaran'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL TUNGGAKAN TERPILIH',
            style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            CurrencyFormatter.format(_totalOutstanding),
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Jumlah Tagihan: ${widget.invoicesToPay.length} Invoice',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAllocationsPreviewList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _allocationsPreview.length,
      itemBuilder: (context, index) {
        final item = _allocationsPreview[index];
        final InvoiceEntity inv = item['invoice'];
        final double allocated = item['allocated'];
        final double remaining = item['remaining'];

        Color statusColor = Colors.grey;
        String statusText = "Tidak Terbayar";

        if (allocated >= inv.remainingDebt) {
          statusColor = AppTheme.secondaryColor;
          statusText = "Lunas";
        } else if (allocated > 0) {
          statusColor = AppTheme.primaryColor;
          statusText = "Cicil (Sebagian)";
        }

        return Card(
          color: Theme.of(context).cardTheme.color!.withOpacity(0.5),
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF334155), width: 0.8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inv.invoiceNumber,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Jatuh Tempo: ${DateFormatter.formatShort(DateFormatter.toIsoDateString(inv.dueDate))}',
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+ ${CurrencyFormatter.format(allocated)}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: statusColor, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        statusText.toUpperCase(),
                        style: TextStyle(color: statusColor, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final totalAmount = double.parse(_amountController.text.trim());
      final paymentId = const Uuid().v4();

      final payment = PaymentEntity(
        id: paymentId,
        organizationId: widget.organizationId,
        paymentDate: _paymentDate,
        amount: totalAmount,
        paymentMethod: _selectedMethod,
        verified: true, // Auto-verified oleh manager/owner di Fase 1 lokal
        createdAt: DateTime.now(),
      );

      final List<PaymentItemEntity> allocations = [];
      for (var preview in _allocationsPreview) {
        final double allocated = preview['allocated'];
        final InvoiceEntity inv = preview['invoice'];

        if (allocated > 0) {
          allocations.add(
            PaymentItemEntity(
              id: const Uuid().v4(),
              paymentId: paymentId,
              invoiceId: inv.id,
              amountAllocated: allocated,
            ),
          );
        }
      }

      _invoiceCubit.addPayment(
        payment: payment,
        allocations: allocations,
      );
    }
  }
}
