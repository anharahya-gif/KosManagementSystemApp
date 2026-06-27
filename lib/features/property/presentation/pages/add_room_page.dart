import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';
import 'package:uuid/uuid.dart';

class AddRoomPage extends StatefulWidget {
  final String propertyId;
  final RoomEntity? roomToEdit; // Jika ada, maka mode Edit. Jika null, maka mode Tambah.

  const AddRoomPage({super.key, required this.propertyId, this.roomToEdit});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _roomNumberController = TextEditingController();
  final _priceController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();

  late PropertyCubit _propertyCubit;
  bool get _isEditMode => widget.roomToEdit != null;

  @override
  void initState() {
    super.initState();
    _propertyCubit = sl<PropertyCubit>();
    
    if (_isEditMode) {
      final room = widget.roomToEdit!;
      _roomNumberController.text = room.roomNumber;
      _priceController.text = room.pricePerMonth.toStringAsFixed(0);
      _buildingController.text = room.buildingName ?? '';
      _floorController.text = room.floorName ?? '';
    }
  }

  @override
  void dispose() {
    _roomNumberController.dispose();
    _priceController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _propertyCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? 'EDIT KAMAR' : 'TAMBAH KAMAR'),
        ),
        body: BlocConsumer<PropertyCubit, PropertyState>(
          listener: (context, state) {
            if (state is PropertyActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true); // Pop and refresh
            }

            if (state is PropertyError) {
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
                  Text(
                    _isEditMode ? 'Edit Informasi Kamar' : 'Informasi Kamar Baru',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _roomNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Kamar / Nama Unit',
                      hintText: 'Contoh: Room 101, Paviliun A',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nomor kamar tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Harga Sewa Per Bulan (Rp)',
                      hintText: 'Contoh: 1500000',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Harga sewa tidak boleh kosong';
                      }
                      final price = double.tryParse(val);
                      if (price == null || price <= 0) {
                        return 'Masukkan harga sewa yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _buildingController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Gedung / Blok (Opsional)',
                      hintText: 'Contoh: Gedung Utara, Blok C',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _floorController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lantai (Opsional)',
                      hintText: 'Contoh: Lantai 2, Lantai Mezanin',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: state is PropertyLoading ? null : _submit,
                    child: state is PropertyLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(_isEditMode ? 'Simpan Perubahan' : 'Tambahkan Kamar'),
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
      final room = RoomEntity(
        id: _isEditMode ? widget.roomToEdit!.id : const Uuid().v4(),
        propertyId: widget.propertyId,
        roomNumber: _roomNumberController.text.trim(),
        buildingName: _buildingController.text.trim().isEmpty
            ? null
            : _buildingController.text.trim(),
        floorName: _floorController.text.trim().isEmpty
            ? null
            : _floorController.text.trim(),
        pricePerMonth: double.parse(_priceController.text.trim()),
        status: _isEditMode ? widget.roomToEdit!.status : RoomStatus.vacant,
        createdAt: _isEditMode ? widget.roomToEdit!.createdAt : DateTime.now(),
      );

      if (_isEditMode) {
        _propertyCubit.editRoom(room);
      } else {
        _propertyCubit.addRoom(room);
      }
    }
  }
}
