import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/contract/domain/entities/invoice_entity.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_cubit.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_state.dart';
import 'package:kms/features/contract/presentation/pages/record_payment_page.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> with SingleTickerProviderStateMixin {
  late InvoiceCubit _invoiceCubit;
  late TabController _tabController;
  final AppDatabase _db = sl<AppDatabase>();

  Map<String, String> _residentNames = {};
  Map<String, String> _roomNumbers = {};

  // Menyimpan ID invoice yang di-select untuk pembayaran massal
  final List<InvoiceEntity> _selectedInvoices = [];

  @override
  void initState() {
    super.initState();
    _invoiceCubit = sl<InvoiceCubit>();
    _tabController = TabController(length: 4, vsync: this);
    _loadData();
  }

  void _loadData() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _invoiceCubit.fetchInvoices(authState.user.organizationId);
      _loadMappings();
    }
  }

  void _loadMappings() async {
    final resList = await _db.select(_db.residents).get();
    final roomList = await _db.select(_db.rooms).get();
    final contracts = await _db.select(_db.contracts).get();

    // Map contractId -> residentName / roomNumber via contract relations
    final Map<String, String> contractToResident = {};
    final Map<String, String> contractToRoom = {};

    final residentMap = {for (var r in resList) r.id: r.fullName};
    final roomMap = {for (var r in roomList) r.id: r.roomNumber};

    for (var c in contracts) {
      contractToResident[c.id] = residentMap[c.residentId] ?? 'N/A';
      contractToRoom[c.id] = roomMap[c.roomId] ?? 'N/A';
    }

    setState(() {
      _residentNames = contractToResident;
      _roomNumbers = contractToRoom;
    });
  }

  Color _getStatusColor(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.paid:
        return AppTheme.secondaryColor;
      case InvoiceStatus.partiallyPaid:
        return AppTheme.primaryColor;
      case InvoiceStatus.overdue:
        return AppTheme.dangerColor;
      case InvoiceStatus.unpaid:
      default:
        return AppTheme.warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _invoiceCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _loadData();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppTheme.primaryColor,
                tabs: const [
                  Tab(text: 'Semua'),
                  Tab(text: 'Belum Lunas'),
                  Tab(text: 'Lunas'),
                  Tab(text: 'Jatuh Tempo'),
                ],
              ),
            ),
          ),
          body: BlocConsumer<InvoiceCubit, InvoiceState>(
            listener: (context, state) {
              if (state is InvoiceActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                setState(() {
                  _selectedInvoices.clear();
                });
                _loadData();
              }
            },
            builder: (context, state) {
              if (state is InvoiceLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is InvoicesLoaded) {
                final invoices = state.invoices;

                if (invoices.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Tagihan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tagihan otomatis terbuat ketika ada kontrak aktif.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildInvoiceList(invoices),
                    _buildInvoiceList(invoices.where((i) => i.status != InvoiceStatus.paid).toList()),
                    _buildInvoiceList(invoices.where((i) => i.status == InvoiceStatus.paid).toList()),
                    _buildInvoiceList(invoices
                        .where((i) => i.status != InvoiceStatus.paid && i.dueDate.isBefore(DateTime.now()))
                        .toList()),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: _selectedInvoices.isNotEmpty
              ? FloatingActionButton.extended(
                  backgroundColor: AppTheme.secondaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    // Sorting berdasarkan jatuh tempo terlama dahulu untuk alokasi dana yang benar
                    _selectedInvoices.sort((a, b) => a.dueDate.compareTo(b.dueDate));
                    
                    final authState = context.read<AuthCubit>().state;
                    if (authState is AuthSuccess) {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecordPaymentPage(
                            organizationId: authState.user.organizationId,
                            invoicesToPay: List.from(_selectedInvoices),
                          ),
                        ),
                      );
                      if (result == true) {
                        _loadData();
                      }
                    }
                  },
                  icon: const Icon(Icons.payment),
                  label: Text('Bayar Terpilih (${_selectedInvoices.length})'),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildInvoiceList(List<InvoiceEntity> invoices) {
    if (invoices.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada tagihan di kategori ini.',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final inv = invoices[index];
        final isSelected = _selectedInvoices.any((i) => i.id == inv.id);
        final residentName = _residentNames[inv.contractId] ?? (_residentNames.isEmpty ? 'Memuat...' : 'Tanpa Kontrak');
        final roomNumber = _roomNumbers[inv.contractId] ?? (_roomNumbers.isEmpty ? 'Memuat...' : 'N/A');
        final statusColor = _getStatusColor(inv.status);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? AppTheme.secondaryColor : const Color(0xFF334155),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onLongPress: () {
              if (inv.status == InvoiceStatus.paid) return; // Lunas tidak bisa dibayar lagi
              setState(() {
                if (isSelected) {
                  _selectedInvoices.removeWhere((i) => i.id == inv.id);
                } else {
                  _selectedInvoices.add(inv);
                }
              });
            },
            onTap: () {
              if (_selectedInvoices.isNotEmpty) {
                if (inv.status == InvoiceStatus.paid) return;
                setState(() {
                  if (isSelected) {
                    _selectedInvoices.removeWhere((i) => i.id == inv.id);
                  } else {
                    _selectedInvoices.add(inv);
                  }
                });
              } else {
                // Tampilkan opsi bayar tunggal langsung
                if (inv.status != InvoiceStatus.paid) {
                  setState(() {
                    _selectedInvoices.add(inv);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invoice dipilih. Tekan tombol Bayar di bawah.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (_selectedInvoices.isNotEmpty && inv.status != InvoiceStatus.paid) ...[
                    Checkbox(
                      activeColor: AppTheme.secondaryColor,
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          if (val == true) {
                            _selectedInvoices.add(inv);
                          } else {
                            _selectedInvoices.removeWhere((i) => i.id == inv.id);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              inv.invoiceNumber,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                inv.status.name.toUpperCase(),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$residentName ($roomNumber)',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jatuh Tempo: ${DateFormatter.formatShort(DateFormatter.toIsoDateString(inv.dueDate))}',
                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              'Sisa: ${CurrencyFormatter.format(inv.remainingDebt)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
