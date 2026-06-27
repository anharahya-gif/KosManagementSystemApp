import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';
import 'package:kms/features/resident/presentation/cubit/resident_cubit.dart';
import 'package:kms/features/resident/presentation/cubit/resident_state.dart';
import 'package:uuid/uuid.dart';

class AddResidentPage extends StatefulWidget {
  final String organizationId;
  final ResidentEntity? residentToEdit;

  const AddResidentPage({super.key, required this.organizationId, this.residentToEdit});

  @override
  State<AddResidentPage> createState() => _AddResidentPageState();
}

class _AddResidentPageState extends State<AddResidentPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _ktpController = TextEditingController();

  late ResidentCubit _residentCubit;
  bool get _isEditMode => widget.residentToEdit != null;

  @override
  void initState() {
    super.initState();
    _residentCubit = sl<ResidentCubit>();

    if (_isEditMode) {
      final res = widget.residentToEdit!;
      _fullNameController.text = res.fullName;
      _phoneController.text = res.phoneNumber;
      _emailController.text = res.email ?? '';
      _ktpController.text = res.idCardNumber ?? '';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _ktpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _residentCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditMode ? 'EDIT DATA PENGHUNI' : 'TAMBAH PENGHUNI'),
          actions: _isEditMode
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    tooltip: 'Hapus Penghuni',
                    onPressed: () => _confirmDeleteResident(context),
                  ),
                ]
              : null,
        ),
        body: BlocConsumer<ResidentCubit, ResidentState>(
          listener: (context, state) {
            if (state is ResidentActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pop(context, true); // Pop and refresh list
            }

            if (state is ResidentError) {
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
                    _isEditMode ? 'Edit Profil Penghuni' : 'Data Diri Calon Penghuni',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      hintText: 'Masukkan nama sesuai KTP...',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nama lengkap tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Nomor WhatsApp',
                      hintText: 'Contoh: 081234567890',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Nomor HP tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Email (Opsional)',
                      hintText: 'Contoh: nama@domain.com',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ktpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Nomor KTP / Passport (Opsional)',
                      hintText: 'Masukkan 16 digit NIK...',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: state is ResidentLoading ? null : _submit,
                    child: state is ResidentLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(_isEditMode ? 'Simpan Perubahan' : 'Daftarkan Penghuni'),
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
      final resident = ResidentEntity(
        id: _isEditMode ? widget.residentToEdit!.id : const Uuid().v4(),
        organizationId: widget.organizationId,
        userId: _isEditMode ? widget.residentToEdit!.userId : null,
        fullName: _fullNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        idCardNumber: _ktpController.text.trim().isEmpty
            ? null
            : _ktpController.text.trim(),
        status: _isEditMode ? widget.residentToEdit!.status : ResidentStatus.prospective,
        createdAt: _isEditMode ? widget.residentToEdit!.createdAt : DateTime.now(),
      );

      if (_isEditMode) {
        _residentCubit.editResident(resident);
      } else {
        _residentCubit.addResident(resident);
      }
    }
  }

  void _confirmDeleteResident(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Hapus Penghuni?'),
          content: Text(
            'Apakah Anda yakin ingin memindahkan "${widget.residentToEdit!.fullName}" ke kotak sampah?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
              onPressed: () {
                Navigator.pop(dialogCtx); // close dialog
                _residentCubit.softDeleteResident(
                  widget.residentToEdit!.id,
                  widget.organizationId,
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
