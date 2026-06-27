import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';
import 'package:kms/features/resident/presentation/cubit/resident_cubit.dart';
import 'package:kms/features/resident/presentation/cubit/resident_state.dart';
import 'package:kms/features/resident/presentation/pages/add_resident_page.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({super.key});

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  late ResidentCubit _residentCubit;

  @override
  void initState() {
    super.initState();
    _residentCubit = sl<ResidentCubit>();
    _loadResidents();
  }

  void _loadResidents() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _residentCubit.fetchResidents(authState.user.organizationId);
    }
  }

  Color _getStatusColor(ResidentStatus status) {
    switch (status) {
      case ResidentStatus.prospective:
        return AppTheme.warningColor;
      case ResidentStatus.active:
        return AppTheme.secondaryColor;
      case ResidentStatus.moved:
        return Colors.blue;
      case ResidentStatus.checkedOut:
        return AppTheme.accentColor;
      case ResidentStatus.inactive:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _residentCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _loadResidents();
          }
        },
        child: Scaffold(
          body: BlocBuilder<ResidentCubit, ResidentState>(
            builder: (context, state) {
              if (state is ResidentLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ResidentsLoaded) {
                final residents = state.residents;
                if (residents.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.people_outline, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Penghuni',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Daftarkan data calon penghuni terlebih dahulu.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: residents.length,
                  itemBuilder: (context, index) {
                    final resident = residents[index];
                    return _buildResidentCard(resident);
                  },
                );
              }

              if (state is ResidentError) {
                return Center(
                  child: Text(
                    'Gagal memuat penghuni: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
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
                        builder: (context) => AddResidentPage(
                          organizationId: authState.user.organizationId,
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadResidents();
                    }
                  },
                  child: const Icon(Icons.person_add),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildResidentCard(ResidentEntity resident) {
    final statusColor = _getStatusColor(resident.status);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: const Icon(Icons.person, color: AppTheme.primaryColor),
        ),
        title: Text(
          resident.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.phone, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(resident.phoneNumber, style: const TextStyle(fontSize: 12)),
              ],
            ),
            if (resident.email != null && resident.email!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.email, size: 12, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(resident.email!, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ]
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            resident.status.name.toUpperCase(),
            style: TextStyle(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () async {
          final authState = context.read<AuthCubit>().state;
          if (authState is AuthSuccess) {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddResidentPage(
                  organizationId: authState.user.organizationId,
                  residentToEdit: resident,
                ),
              ),
            );
            if (result == true) {
              _loadResidents();
            }
          }
        },
      ),
    );
  }
}
