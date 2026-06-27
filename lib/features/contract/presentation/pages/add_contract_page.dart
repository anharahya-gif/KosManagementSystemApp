import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/contract/domain/entities/contract_entity.dart';
import 'package:kms/features/contract/presentation/cubit/contract_cubit.dart';
import 'package:kms/features/contract/presentation/cubit/contract_state.dart';
import 'package:uuid/uuid.dart';

class AddContractPage extends StatefulWidget {
  final String organizationId;

  const AddContractPage({super.key, required this.organizationId});

  @override
  State<AddContractPage> createState() => _AddContractPageState();
}

class _AddContractPageState extends State<AddContractPage> {
  final _formKey = GlobalKey<FormState>();
  final AppDatabase _db = sl<AppDatabase>();
  late ContractCubit _contractCubit;

  List<Resident> _residents = [];
  List<Room> _rooms = [];

  String? _selectedResidentId;
  String? _selectedRoomId;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 180)); // 6 bulan default
  final _priceController = TextEditingController();
  final _depositController = TextEditingController();

  bool _isLoadingMappings = true;

  @override
  void initState() {
    super.initState();
    _contractCubit = sl<ContractCubit>();
    _loadSelectors();
  }

  void _loadSelectors() async {
    // 1. Ambil calon penghuni (prospective)
    final residentsList = await (_db.select(_db.residents)
          ..where((t) => t.organizationId.equals(widget.organizationId) & t.status.equals('prospective')))
        .get();

    // 2. Ambil kamar kosong (vacant)
    // Kita butuh join properti untuk mencocokkan org_id propertinya
    final properties = await (_db.select(_db.properties)
          ..where((t) => t.organizationId.equals(widget.organizationId)))
        .get();
    final propIds = properties.map((p) => p.id).toList();

    List<Room> roomsList = [];
    if (propIds.isNotEmpty) {
      roomsList = await (_db.select(_db.rooms)
            ..where((t) => t.propertyId.isIn(propIds) & t.status.equals('vacant')))
          .get();
    }

    setState(() {
      _residents = residentsList;
      _rooms = roomsList;
      _isLoadingMappings = false;
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    _depositController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _contractCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BUAT KONTRAK BARU'),
        ),
        body: BlocConsumer<ContractCubit, ContractState>(
          listener: (context, state) {
            if (state is ContractActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true); // Pop and refresh
            }

            if (state is ContractError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (_isLoadingMappings) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const Text(
                    'Pilih Aktor Hunian',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // Dropdown Penghuni
                  DropdownButtonFormField<String>(
                    value: _selectedResidentId,
                    hint: const Text('Pilih Penghuni (Calon)'),
                    items: _residents.map((r) {
                      return DropdownMenuItem(
                        value: r.id,
                        child: Text('${r.fullName} (${r.phoneNumber})'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedResidentId = val;
                      });
                    },
                    validator: (val) => val == null ? 'Pilih salah satu penghuni' : null,
                  ),
                  const SizedBox(height: 16),
                  // Dropdown Kamar Vacant
                  DropdownButtonFormField<String>(
                    value: _selectedRoomId,
                    hint: const Text('Pilih Kamar (Kosong)'),
                    items: _rooms.map((r) {
                      return DropdownMenuItem(
                        value: r.id,
                        child: Text('${r.roomNumber} - ${CurrencyFormatter.formatFromCents(r.pricePerMonth)}/bln'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedRoomId = val;
                        // Auto-fill harga sewa ketika kamar dipilih
                        final selectedRoom = _rooms.firstWhere((r) => r.id == val);
                        _priceController.text =
                            CurrencyFormatter.toRupiahDouble(selectedRoom.pricePerMonth)
                                .toStringAsFixed(0);
                      });
                    },
                    validator: (val) => val == null ? 'Pilih salah satu kamar' : null,
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Parameter & Masa Sewa',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Pickers
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mulai Sewa', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            OutlinedButton(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2040),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _startDate = picked;
                                    if (_endDate.isBefore(_startDate)) {
                                      _endDate = _startDate.add(const Duration(days: 30));
                                    }
                                  });
                                }
                              },
                              child: Text(DateFormatter.formatDateTimeReadable(_startDate)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Selesai Sewa', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            OutlinedButton(
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate,
                                  firstDate: _startDate.add(const Duration(days: 1)),
                                  lastDate: DateTime(2040),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _endDate = picked;
                                  });
                                }
                              },
                              child: Text(DateFormatter.formatDateTimeReadable(_endDate)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Harga Sewa Disepakati (Rp/Bulan)',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Harga tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _depositController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Uang Jaminan / Deposit (Rp) (Opsional)',
                      hintText: 'Contoh: 500000',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: state is ContractLoading ? null : _submit,
                    child: state is ContractLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Aktifkan Kontrak & Mulai Sewa'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final price = double.parse(_priceController.text.trim());
      final deposit = _depositController.text.trim().isEmpty
          ? 0.0
          : double.parse(_depositController.text.trim());

      final contract = ContractEntity(
        id: const Uuid().v4(),
        organizationId: widget.organizationId,
        residentId: _selectedResidentId!,
        roomId: _selectedRoomId!,
        startDate: _startDate,
        endDate: _endDate,
        billingCycle: 'monthly',
        pricePerCycle: price,
        depositAmount: deposit,
        status: ContractStatus.active,
        createdAt: DateTime.now(),
      );

      _contractCubit.addContract(contract);
    }
  }
}
