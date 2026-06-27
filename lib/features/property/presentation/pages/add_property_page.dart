import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';
import 'package:kms/features/property/presentation/pages/map_picker_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class AddPropertyPage extends StatefulWidget {
  final String organizationId;

  const AddPropertyPage({super.key, required this.organizationId});

  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedType = 'kos';

  double? _latitude;
  double? _longitude;

  late PropertyCubit _propertyCubit;

  @override
  void initState() {
    super.initState();
    _propertyCubit = sl<PropertyCubit>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _propertyCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TAMBAH PROPERTI'),
        ),
        body: BlocConsumer<PropertyCubit, PropertyState>(
          listener: (context, state) {
            if (state is PropertyActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true); // Return true to refresh list
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
                  const Text(
                    'Informasi Utama Properti',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Properti',
                      hintText: 'Contoh: Kos Mawar Indah',
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Nama properti tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Lengkap',
                      hintText: 'Masukkan alamat lengkap properti...',
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Tipe Properti',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'kos', child: Text('Kos-Kosan')),
                      DropdownMenuItem(value: 'kontrakan', child: Text('Kontrakan')),
                      DropdownMenuItem(value: 'apartment', child: Text('Apartemen Skala Kecil')),
                      DropdownMenuItem(value: 'guesthouse', child: Text('Guest House')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedType = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Titik Koordinat Properti (Opsional)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  _buildLocationSelector(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: state is PropertyLoading ? null : _submit,
                    child: state is PropertyLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Simpan Properti'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLocationSelector() {
    final hasLocation = _latitude != null && _longitude != null;

    return InkWell(
      onTap: _openMapPicker,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hasLocation ? AppTheme.secondaryColor.withOpacity(0.08) : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasLocation ? AppTheme.secondaryColor : const Color(0xFF334155),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              hasLocation ? Icons.location_on : Icons.map_outlined,
              color: hasLocation ? AppTheme.secondaryColor : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasLocation ? 'Lokasi Peta Terpilih' : 'Tandai Lokasi di Peta',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hasLocation ? AppTheme.secondaryColor : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasLocation
                        ? '${_latitude!.toStringAsFixed(6)}, ${_longitude!.toStringAsFixed(6)}'
                        : 'Geser pin untuk menentukan koordinat presisi.',
                    style: TextStyle(
                      color: hasLocation ? Colors.grey.shade300 : Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (hasLocation)
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _latitude = null;
                    _longitude = null;
                  });
                },
              )
            else
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _openMapPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPickerPage(
          initialLatitude: _latitude,
          initialLongitude: _longitude,
        ),
      ),
    );

    if (result is LatLng) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final property = PropertyEntity(
        id: const Uuid().v4(),
        organizationId: widget.organizationId,
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        type: _selectedType,
        latitude: _latitude,
        longitude: _longitude,
        createdAt: DateTime.now(),
      );

      _propertyCubit.addProperty(property);
    }
  }
}
