import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
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

  List<String> _selectedImagePaths = [];
  List<String> _selectedFacilities = [];

  final List<String> _availableFacilities = [
    'AC',
    'Kamar Mandi Dalam',
    'Kasur (Bed)',
    'Wifi',
    'Lemari',
    'Meja & Kursi',
    'TV',
    'Air Panas (Water Heater)',
    'Balkon',
    'Kulkas Kecil'
  ];

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
      _selectedImagePaths = List.from(room.images);
      _selectedFacilities = List.from(room.facilities);
    }
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        _selectedImagePaths.addAll(result.paths.whereType<String>());
      });
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
                  const Divider(height: 32),
                  const Text(
                    'Fasilitas Kamar',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: _availableFacilities.map((facility) {
                      final isSelected = _selectedFacilities.contains(facility);
                      return FilterChip(
                        label: Text(facility),
                        selected: isSelected,
                        selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                        checkmarkColor: AppTheme.primaryColor,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedFacilities.add(facility);
                            } else {
                              _selectedFacilities.remove(facility);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Foto Kondisi Kamar',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.add_a_photo_outlined, size: 18),
                        label: const Text('Tambah Foto', style: TextStyle(fontSize: 12)),
                        onPressed: _pickImages,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _selectedImagePaths.isEmpty
                      ? Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Center(
                            child: Text(
                              'Belum ada foto kamar ditambahkan',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImagePaths.length,
                            itemBuilder: (context, idx) {
                              final path = _selectedImagePaths[idx];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: path.startsWith('http') || !File(path).existsSync()
                                          ? Container(
                                              width: 120,
                                              height: 120,
                                              color: Colors.grey.shade300,
                                              child: const Icon(Icons.broken_image, color: Colors.grey),
                                            )
                                          : Image.file(
                                              File(path),
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedImagePaths.removeAt(idx);
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                                          child: const Icon(Icons.close, size: 14, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
        images: _selectedImagePaths,
        facilities: _selectedFacilities,
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
