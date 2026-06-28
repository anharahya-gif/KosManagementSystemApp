import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' as drift hide Column;
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
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/property_expense_entity.dart';
import 'package:uuid/uuid.dart';

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

  // Bagi Hasil State
  List<PropertyEntity> _properties = [];
  PropertyEntity? _selectedProperty;
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;

  double _totalPemasukan = 0;
  double _totalMaintenance = 0;
  double _totalBiayaRutin = 0;
  List<Map<String, dynamic>> _paymentsInMonth = [];
  List<dynamic> _maintenanceInMonth = [];
  List<dynamic> _expensesInMonth = [];

  @override
  void initState() {
    super.initState();
    _invoiceCubit = sl<InvoiceCubit>();
    _tabController = TabController(length: 5, vsync: this);
    _loadData();
  }

  void _loadData() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _invoiceCubit.fetchInvoices(authState.user.organizationId);
      _loadMappings();
      _loadProfitSharingProperties();
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
                  Tab(text: 'Bagi Hasil'),
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

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildInvoiceList(invoices),
                    _buildInvoiceList(invoices.where((i) => i.status != InvoiceStatus.paid).toList()),
                    _buildInvoiceList(invoices.where((i) => i.status == InvoiceStatus.paid).toList()),
                    _buildInvoiceList(invoices
                        .where((i) => i.status != InvoiceStatus.paid && i.dueDate.isBefore(DateTime.now()))
                        .toList()),
                    _buildProfitSharingTab(),
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

  void _loadProfitSharingProperties() async {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      final query = _db.select(_db.properties)
        ..where((t) => t.organizationId.equals(authState.user.organizationId) & t.deletedAt.isNull());
      final rows = await query.get();
      final entities = rows.map((row) => PropertyEntity(
        id: row.id,
        organizationId: row.organizationId,
        name: row.name,
        address: row.address,
        type: row.type,
        latitude: row.latitude,
        longitude: row.longitude,
        managerSharePercent: row.managerSharePercent,
        createdAt: row.createdAt,
      )).toList();
      
      setState(() {
        _properties = entities;
        if (_properties.isNotEmpty && _selectedProperty == null) {
          _selectedProperty = _properties.first;
        }
      });
      _calculateProfitSharing();
    }
  }

  void _calculateProfitSharing() async {
    if (_selectedProperty == null) return;
    
    final propertyId = _selectedProperty!.id;
    final startOfMonth = DateTime(_selectedYear, _selectedMonth, 1);
    final endOfMonth = DateTime(_selectedYear, _selectedMonth + 1, 1).subtract(const Duration(microseconds: 1));
    
    final rooms = await (_db.select(_db.rooms)..where((r) => r.propertyId.equals(propertyId))).get();
    final roomIds = rooms.map((r) => r.id).toList();
    if (roomIds.isEmpty) {
      setState(() {
        _totalPemasukan = 0;
        _totalMaintenance = 0;
        _totalBiayaRutin = 0;
        _paymentsInMonth = [];
        _maintenanceInMonth = [];
        _expensesInMonth = [];
      });
      return;
    }
    
    final tickets = await (_db.select(_db.maintenanceTickets)
          ..where((t) => 
            t.roomId.isIn(roomIds) & 
            t.status.equals('completed') & 
            t.createdAt.isBetweenValues(startOfMonth, endOfMonth)))
        .get();
        
    final expenses = await (_db.select(_db.propertyExpenses)
          ..where((t) => 
            t.propertyId.equals(propertyId) & 
            t.expenseDate.isBetweenValues(startOfMonth, endOfMonth)))
        .get();
        
    final contracts = await (_db.select(_db.contracts)..where((c) => c.roomId.isIn(roomIds))).get();
    final contractIds = contracts.map((c) => c.id).toList();
    
    List<Map<String, dynamic>> paymentList = [];
    double totalPay = 0;
    
    if (contractIds.isNotEmpty) {
      final invoices = await (_db.select(_db.invoices)..where((i) => i.contractId.isIn(contractIds))).get();
      final invoiceIds = invoices.map((i) => i.id).toList();
      
      if (invoiceIds.isNotEmpty) {
        final paymentItems = await (_db.select(_db.paymentItems)..where((p) => p.invoiceId.isIn(invoiceIds))).get();
        final paymentIds = paymentItems.map((p) => p.paymentId).toList();
        
        if (paymentIds.isNotEmpty) {
          final payments = await (_db.select(_db.payments)
                ..where((p) => 
                  p.id.isIn(paymentIds) & 
                  p.verified.equals(true) & 
                  p.paymentDate.isBetweenValues(startOfMonth, endOfMonth)))
              .get();
              
          final invoiceMap = {for (var inv in invoices) inv.id: inv};
          
          for (var pay in payments) {
            final matchingItems = paymentItems.where((pi) => pi.paymentId == pay.id).toList();
            String residentName = 'Tanpa Kontrak';
            String roomNumber = 'N/A';
            
            if (matchingItems.isNotEmpty) {
              final invId = matchingItems.first.invoiceId;
              final inv = invoiceMap[invId];
              if (inv != null) {
                residentName = _residentNames[inv.contractId] ?? 'Tanpa Kontrak';
                roomNumber = _roomNumbers[inv.contractId] ?? 'N/A';
              }
            }
            
            paymentList.add({
              'payment': pay,
              'residentName': residentName,
              'roomNumber': roomNumber,
            });
            
            totalPay += CurrencyFormatter.toRupiahDouble(pay.amount);
          }
        }
      }
    }
    
    double totalMaint = 0;
    for (var t in tickets) {
      totalMaint += CurrencyFormatter.toRupiahDouble(t.cost ?? 0);
    }
    
    double totalExp = 0;
    for (var e in expenses) {
      totalExp += CurrencyFormatter.toRupiahDouble(e.amount);
    }
    
    setState(() {
      _totalPemasukan = totalPay;
      _totalMaintenance = totalMaint;
      _totalBiayaRutin = totalExp;
      _paymentsInMonth = paymentList;
      _maintenanceInMonth = tickets;
      _expensesInMonth = expenses;
    });
  }

  Widget _buildProfitSharingTab() {
    if (_selectedProperty == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Belum Ada Properti Terdaftar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan properti terlebih dahulu di halaman Properti.',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
      );
    }

    final double totalPengeluaran = _totalMaintenance + _totalBiayaRutin;
    final double pendapatanBersih = _totalPemasukan - totalPengeluaran;
    final int sharePercent = _selectedProperty!.managerSharePercent;
    
    final double bagianPengelola = pendapatanBersih > 0 ? (pendapatanBersih * sharePercent / 100) : 0;
    final double bagianPemilik = pendapatanBersih > 0 ? (pendapatanBersih * (100 - sharePercent) / 100) : 0;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Filter Dropdowns
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<PropertyEntity>(
                  value: _properties.firstWhere((p) => p.id == _selectedProperty!.id, orElse: () => _selectedProperty!),
                  decoration: const InputDecoration(labelText: 'Pilih Properti'),
                  items: _properties.map((p) {
                    return DropdownMenuItem<PropertyEntity>(
                      value: p,
                      child: Text(p.name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedProperty = val);
                      _calculateProfitSharing();
                    }
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedMonth,
                        decoration: const InputDecoration(labelText: 'Bulan'),
                        items: List.generate(12, (index) {
                          final m = index + 1;
                          final months = [
                            'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
                            'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
                          ];
                          return DropdownMenuItem<int>(
                            value: m,
                            child: Text(months[index]),
                          );
                        }),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedMonth = val);
                            _calculateProfitSharing();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _selectedYear,
                        decoration: const InputDecoration(labelText: 'Tahun'),
                        items: List.generate(10, (index) {
                          final y = DateTime.now().year - 3 + index;
                          return DropdownMenuItem<int>(
                            value: y,
                            child: Text(y.toString()),
                          );
                        }),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedYear = val);
                            _calculateProfitSharing();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Financial Cards Overview
        LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 600;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isSmall ? 2 : 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isSmall ? 1.5 : 1.8,
              children: [
                _buildMetricCard(
                  title: 'PEMASUKAN KOTOR',
                  value: CurrencyFormatter.format(_totalPemasukan),
                  color: AppTheme.secondaryColor,
                  icon: Icons.arrow_downward,
                ),
                _buildMetricCard(
                  title: 'TOTAL PENGELUARAN',
                  value: CurrencyFormatter.format(totalPengeluaran),
                  color: AppTheme.dangerColor,
                  icon: Icons.arrow_upward,
                ),
                _buildMetricCard(
                  title: 'PENDAPATAN BERSIH',
                  value: CurrencyFormatter.format(pendapatanBersih),
                  color: pendapatanBersih >= 0 ? AppTheme.accentColor : AppTheme.dangerColor,
                  icon: Icons.account_balance_wallet,
                  spanColumn: !isSmall,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        // Bagi Hasil Split Box
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'PANDUAN BAGI HASIL KEMITRAAN',
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryColor, fontSize: 13),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, size: 18, color: AppTheme.primaryColor),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Bagi hasil dihitung dari Pendapatan Bersih (Pemasukan Kotor dikurangi total pengeluaran operasional). Porsi pengelola adalah $sharePercent%.')),
                        );
                      },
                    )
                  ],
                ),
                const Divider(color: Color(0xFF334155), height: 16),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('HAK PENGELOLA ($sharePercent%)', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(bagianPengelola),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 40, color: const Color(0xFF334155)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('HAK PEMILIK (${100 - sharePercent}%)', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(bagianPemilik),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Quick action: Tambah Biaya Rutin
        ElevatedButton.icon(
          onPressed: _showAddExpenseDialog,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('TAMBAH BIAYA RUTIN'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),

        // Detail Lists (Expandable sections or direct listings)
        const Text(
          'RINCIAN TRANSAKSI PERIODE INI',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 12),

        // 1. Incomes List
        _buildSectionHeader('Pemasukan Sewa Terverifikasi (${_paymentsInMonth.length})', Icons.add_circle, AppTheme.secondaryColor),
        if (_paymentsInMonth.isEmpty)
          _buildEmptyDetailText('Tidak ada pemasukan sewa terverifikasi pada bulan ini.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _paymentsInMonth.length,
            itemBuilder: (context, index) {
              final item = _paymentsInMonth[index];
              final Payment pay = item['payment'];
              final String residentName = item['residentName'];
              final String roomNumber = item['roomNumber'];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.payment, color: AppTheme.secondaryColor),
                title: Text('$residentName (Kamar $roomNumber)'),
                subtitle: Text('${DateFormatter.formatShort(pay.paymentDate.toIso8601String())} | ${pay.paymentMethod.toUpperCase()}'),
                trailing: Text(
                  '+${CurrencyFormatter.format(CurrencyFormatter.toRupiahDouble(pay.amount))}',
                  style: const TextStyle(color: AppTheme.secondaryColor, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        const SizedBox(height: 16),

        // 2. Regular Expenses List
        _buildSectionHeader('Pengeluaran Biaya Rutin (${_expensesInMonth.length})', Icons.receipt_long, AppTheme.warningColor),
        if (_expensesInMonth.isEmpty)
          _buildEmptyDetailText('Tidak ada pengeluaran biaya rutin terdaftar pada bulan ini.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _expensesInMonth.length,
            itemBuilder: (context, index) {
              final PropertyExpense e = _expensesInMonth[index];
              final categoryObj = PropertyExpenseCategory.fromString(e.category);
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  categoryObj == PropertyExpenseCategory.electricity ? Icons.electric_bolt :
                  categoryObj == PropertyExpenseCategory.wifi ? Icons.wifi :
                  categoryObj == PropertyExpenseCategory.water ? Icons.water_drop :
                  Icons.receipt_long,
                  color: AppTheme.warningColor,
                ),
                title: Text(e.name),
                subtitle: Text('${DateFormatter.formatShort(e.expenseDate.toIso8601String())} | ${categoryObj.toReadableString()}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '-${CurrencyFormatter.format(CurrencyFormatter.toRupiahDouble(e.amount))}',
                      style: const TextStyle(color: AppTheme.dangerColor, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
                      onPressed: () => _confirmDeleteExpense(e.id, e.name),
                    ),
                  ],
                ),
              );
            },
          ),
        const SizedBox(height: 16),

        // 3. Maintenance Repair List
        _buildSectionHeader('Biaya Perbaikan Selesai (${_maintenanceInMonth.length})', Icons.build, AppTheme.dangerColor),
        if (_maintenanceInMonth.isEmpty)
          _buildEmptyDetailText('Tidak ada biaya perbaikan terdaftar pada bulan ini.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _maintenanceInMonth.length,
            itemBuilder: (context, index) {
              final MaintenanceTicket t = _maintenanceInMonth[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.handyman, color: AppTheme.dangerColor),
                title: Text(t.title),
                subtitle: Text('${DateFormatter.formatShort(t.createdAt.toIso8601String())} | ${t.description}'),
                trailing: Text(
                  '-${CurrencyFormatter.format(CurrencyFormatter.toRupiahDouble(t.cost ?? 0))}',
                  style: const TextStyle(color: AppTheme.dangerColor, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    bool spanColumn = false,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDetailText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade400, fontStyle: FontStyle.italic),
      ),
    );
  }

  void _showAddExpenseDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    String category = 'electricity';
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('TAMBAH BIAYA RUTIN'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<String>(
                        value: category,
                        decoration: const InputDecoration(labelText: 'Kategori Biaya'),
                        items: const [
                          DropdownMenuItem(value: 'electricity', child: Text('Listrik (PLN)')),
                          DropdownMenuItem(value: 'wifi', child: Text('Wifi / Internet')),
                          DropdownMenuItem(value: 'water', child: Text('Air (PAM/Sanyo)')),
                          DropdownMenuItem(value: 'other', child: Text('Lain-Lain')),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setStateDialog(() => category = val);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Pengeluaran',
                          hintText: 'Contoh: Tagihan Wifi Juni 2026',
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Nama pengeluaran wajib diisi' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Nominal (Rp)',
                          hintText: 'Masukkan nominal rupiah...',
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Nominal wajib diisi';
                          if (double.tryParse(v) == null) return 'Masukkan angka yang valid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Tanggal Pengeluaran: ${DateFormatter.formatShort(selectedDate.toIso8601String())}'),
                        trailing: const Icon(Icons.calendar_today, size: 18),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            setStateDialog(() => selectedDate = picked);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final expense = PropertyExpenseEntity(
                        id: const Uuid().v4(),
                        propertyId: _selectedProperty!.id,
                        name: nameController.text.trim(),
                        category: PropertyExpenseCategory.fromString(category),
                        amount: double.parse(amountController.text.trim()),
                        expenseDate: selectedDate,
                        createdAt: DateTime.now(),
                      );
                      
                      final cents = CurrencyFormatter.toCents(expense.amount);
                      
                      await _db.into(_db.propertyExpenses).insert(
                        PropertyExpensesCompanion.insert(
                          id: expense.id,
                          propertyId: expense.propertyId,
                          name: expense.name,
                          category: expense.category.toDbValue(),
                          amount: cents,
                          expenseDate: expense.expenseDate,
                          createdAt: drift.Value(expense.createdAt),
                        ),
                      );
                      
                      Navigator.pop(dialogCtx);
                      _calculateProfitSharing();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Biaya rutin berhasil ditambahkan.')),
                      );
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDeleteExpense(String id, String name) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Hapus Pengeluaran?'),
          content: Text('Apakah Anda yakin ingin menghapus catatan "$name"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
              onPressed: () async {
                final query = _db.delete(_db.propertyExpenses)..where((t) => t.id.equals(id));
                await query.go();
                Navigator.pop(dialogCtx);
                _calculateProfitSharing();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Catatan pengeluaran berhasil dihapus.')),
                );
              },
              child: const Text('Ya, Hapus'),
            ),
          ],
        );
      },
    );
  }
}
