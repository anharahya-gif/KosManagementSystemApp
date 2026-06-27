import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final prop = PropertyEntity(
        id: const Uuid().v4(),
        organizationId: widget.organizationId,
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        type: _selectedType,
        createdAt: DateTime.now(),
      );
      _propertyCubit.addProperty(prop);
    }
  }
}
