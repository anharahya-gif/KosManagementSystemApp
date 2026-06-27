import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';
import 'package:kms/features/contract/presentation/cubit/contract_cubit.dart';
import 'package:kms/features/contract/presentation/cubit/contract_state.dart';
import 'package:kms/features/contract/presentation/pages/add_contract_page.dart';
import 'package:uuid/uuid.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({super.key});

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  late ContractCubit _contractCubit;
  final AppDatabase _db = sl<AppDatabase>();

  // Caching mappings untuk id -> nama di UI lokal
  Map<String, String> _residentNames = {};
  Map<String, String> _roomNumbers = {};

  @override
  void initState() {
    super.initState();
    _contractCubit = sl<ContractCubit>();
    _loadData();
  }

  void _loadData() async {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      final orgId = authState.user.organizationId;
      _contractCubit.fetchContracts(orgId);
      _loadMappings();
    }
  }

  void _loadMappings() async {
    final resList = await _db.select(_db.residents).get();
    final roomList = await _db.select(_db.rooms).get();
    
    setState(() {
      _residentNames = {for (var r in resList) r.id: r.fullName};
      _roomNumbers = {for (var r in roomList) r.id: r.roomNumber};
    });
  }

  Color _getStatusColor(ContractStatus status) {
    switch (status) {
      case ContractStatus.active:
        return AppTheme.secondaryColor;
      case ContractStatus.completed:
        return Colors.blue;
      case ContractStatus.terminated:
      default:
        return AppTheme.dangerColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _contractCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _loadData();
          }
        },
        child: Scaffold(
          body: BlocConsumer<ContractCubit, ContractState>(
            listener: (context, state) {
              if (state is ContractActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                _loadData();
              }

              if (state is ContractError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                );
              }
            },
            builder: (context, state) {
              if (state is ContractLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ContractsLoaded) {
                final contracts = state.contracts;
                if (contracts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Kontrak Aktif',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Buat kontrak baru untuk menugaskan kamar ke penghuni.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: contracts.length,
                  itemBuilder: (context, index) {
                    final contract = contracts[index];
                    return _buildContractCard(contract);
                  },
                );
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is AuthSuccess) {
                return FloatingActionButton(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddContractPage(
                          organizationId: authState.user.organizationId,
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadData();
                    }
                  },
                  child: const Icon(Icons.border_color),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContractCard(ContractEntity contract) {
    final statusColor = _getStatusColor(contract.status);
    final residentName = _residentNames[contract.residentId] ?? (_residentNames.isEmpty ? 'Memuat...' : 'Tanpa Penghuni');
    final roomNumber = _roomNumbers[contract.roomId] ?? (_roomNumbers.isEmpty ? 'Memuat...' : 'N/A');

    final startDateStr = DateFormatter.toIsoDateString(contract.startDate);
    final endDateStr = DateFormatter.toIsoDateString(contract.endDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showContractActionSheet(context, contract, residentName, roomNumber),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      roomNumber,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      contract.status.name.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                residentName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${DateFormatter.formatShort(startDateStr)} s/d ${DateFormatter.formatShort(endDateStr)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Harga Sewa',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        '${CurrencyFormatter.format(contract.pricePerCycle)} / Bulan',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  if (contract.depositAmount > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Uang Deposit',
                          style: TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                        Text(
                          CurrencyFormatter.format(contract.depositAmount),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContractActionSheet(
    BuildContext context,
    ContractEntity contract,
    String residentName,
    String roomNumber,
  ) {
    if (contract.status != ContractStatus.active) {
      return; // Hanya kontrak aktif yang bisa dikelola (pindah kamar/terminasi)
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Kelola Kontrak $residentName ($roomNumber)',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.compare_arrows, color: Colors.blue),
                title: const Text('Pindah Kamar (Change Room)'),
                onTap: () {
                  Navigator.pop(context);
                  _showChangeRoomDialog(context, contract);
                },
              ),
              ListTile(
                leading: const Icon(Icons.autorenew, color: AppTheme.secondaryColor),
                title: const Text('Perpanjang Kontrak (Renew)'),
                onTap: () {
                  Navigator.pop(context);
                  _showRenewContractDialog(context, contract);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: AppTheme.dangerColor),
                title: const Text('Hentikan Kontrak (Terminate)'),
                onTap: () {
                  Navigator.pop(context);
                  _showTerminateConfirmation(context, contract);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showChangeRoomDialog(BuildContext context, ContractEntity contract) async {
    // Ambal kamar vacant
    final vacantRooms = await (_db.select(_db.rooms)..where((t) => t.status.equals('vacant'))).get();
    
    if (vacantRooms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada kamar kosong yang tersedia saat ini.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    String? selectedRoomId;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Pindah Kamar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Pilih kamar kosong baru untuk dihuni:', style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedRoomId,
                    hint: const Text('Pilih Kamar'),
                    items: vacantRooms.map((r) {
                      return DropdownMenuItem(
                        value: r.id,
                        child: Text('${r.roomNumber} - ${CurrencyFormatter.formatFromCents(r.pricePerMonth)}/bln'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setStateDialog(() {
                        selectedRoomId = val;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: selectedRoomId == null
                      ? null
                      : () {
                          Navigator.pop(context);
                          _contractCubit.moveRoom(
                            contract.id,
                            contract.organizationId,
                            selectedRoomId!,
                            DateTime.now(),
                          );
                        },
                  child: const Text('Konfirmasi Pindah'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showRenewContractDialog(BuildContext context, ContractEntity contract) {
    final currentEndDate = contract.endDate;
    DateTime newEndDate = currentEndDate.add(const Duration(days: 30)); // 1 bulan default
    int? selectedMonths = 1;
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            Widget buildDurationChip(String label, int months) {
              final isSelected = selectedMonths == months;
              return ChoiceChip(
                avatar: isSelected
                    ? const Icon(Icons.check_circle, size: 16, color: Colors.white)
                    : null,
                label: Text(label),
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
                selected: isSelected,
                selectedColor: AppTheme.primaryColor,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isSelected ? AppTheme.primaryColor : Colors.grey.shade400,
                  ),
                ),
                onSelected: (selected) {
                  if (selected) {
                    setStateDialog(() {
                      selectedMonths = months;
                      newEndDate = DateTime(
                        currentEndDate.year,
                        currentEndDate.month + months,
                        currentEndDate.day,
                      );
                    });
                  }
                },
              );
            }

            return AlertDialog(
              title: const Text('Perpanjang Kontrak'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Tanggal berakhir saat ini:\n${DateFormatter.formatDateTimeReadable(currentEndDate)}',
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(height: 16),
                  const Text('Perpanjang Masa Sewa:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      buildDurationChip('+1 Bln', 1),
                      buildDurationChip('+3 Bln', 3),
                      buildDurationChip('+6 Bln', 6),
                      buildDurationChip('+1 Thn', 12),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Pilih Tanggal Berakhir Kustom:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: newEndDate,
                        firstDate: currentEndDate.add(const Duration(days: 1)),
                        lastDate: currentEndDate.add(const Duration(days: 3650)), // 10 tahun max
                      );
                      if (picked != null) {
                        setStateDialog(() {
                          newEndDate = picked;
                          selectedMonths = null; // Custom date resets preset chips
                        });
                      }
                    },
                    child: Text(DateFormatter.formatDateTimeReadable(newEndDate)),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Buat kontrak baru
                    final renewedContract = ContractEntity(
                      id: const Uuid().v4(),
                      organizationId: contract.organizationId,
                      residentId: contract.residentId,
                      roomId: contract.roomId,
                      startDate: contract.endDate, // Mulai dari selesainya kontrak lama
                      endDate: newEndDate,
                      billingCycle: contract.billingCycle,
                      pricePerCycle: contract.pricePerCycle,
                      depositAmount: 0.0, // Deposit diasumsikan berlanjut dari sebelumnya (0 di kontrak baru)
                      status: ContractStatus.active,
                      createdAt: DateTime.now(),
                    );
                    _contractCubit.extendContract(
                      contract.id,
                      contract.organizationId,
                      renewedContract,
                    );
                  },
                  child: const Text('Perpanjang'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showTerminateConfirmation(BuildContext context, ContractEntity contract) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Terminasi'),
          content: const Text(
            'Apakah Anda yakin ingin menghentikan kontrak sewa ini?\n\nKamar akan otomatis diset menjadi KOSONG dan status penghuni akan diset menjadi CHECKED OUT.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
              onPressed: () {
                Navigator.pop(context);
                _contractCubit.stopContract(
                  contract.id,
                  contract.organizationId,
                  DateTime.now(),
                );
              },
              child: const Text('Ya, Hentikan'),
            ),
          ],
        );
      },
    );
  }
}
