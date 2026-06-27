import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';
import 'package:kms/features/property/presentation/pages/add_property_page.dart';
import 'package:kms/features/property/presentation/pages/property_detail_page.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  late PropertyCubit _propertyCubit;

  @override
  void initState() {
    super.initState();
    _propertyCubit = sl<PropertyCubit>();
    _loadProperties();
  }

  void _loadProperties() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _propertyCubit.fetchProperties(authState.user.organizationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _propertyCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _loadProperties();
          }
        },
        child: Scaffold(
          body: BlocBuilder<PropertyCubit, PropertyState>(
            builder: (context, state) {
              if (state is PropertyLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PropertiesLoaded) {
                final authState = context.read<AuthCubit>().state;
                List<PropertyEntity> filteredProperties = state.properties;

                if (authState is AuthSuccess) {
                  final user = authState.user;
                  // Scoping: Manager hanya boleh melihat properti yang ditugaskan kepadanya
                  if (user.isManager) {
                    filteredProperties = state.properties
                        .where((p) => authState.assignedPropertyIds.contains(p.id))
                        .toList();
                  }
                }

                if (filteredProperties.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.home_work_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Belum Ada Properti Terdaftar',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Daftarkan properti pertama Anda untuk mulai mengelola.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final prop = filteredProperties[index];
                    return _buildPropertyCard(prop);
                  },
                );
              }

              if (state is PropertyError) {
                return Center(
                  child: Text(
                    'Gagal memuat properti: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is AuthSuccess && authState.user.isOwner) {
                return FloatingActionButton(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPropertyPage(
                          organizationId: authState.user.organizationId,
                        ),
                      ),
                    );
                    if (result == true) {
                      _loadProperties();
                    }
                  },
                  child: const Icon(Icons.add),
                );
              }
              return const SizedBox(); // Manager tidak boleh menambah properti baru
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(PropertyEntity property) {
    String typeLabel = property.type.toUpperCase();
    IconData typeIcon = Icons.home;
    if (property.type == 'apartment') {
      typeIcon = Icons.apartment;
    } else if (property.type == 'guesthouse') {
      typeIcon = Icons.domain;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailPage(property: property),
            ),
          ).then((_) => _loadProperties());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(typeIcon, color: AppTheme.primaryColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          typeLabel,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (property.latitude != null && property.longitude != null) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.explore, size: 10, color: AppTheme.secondaryColor),
                          const SizedBox(width: 2),
                          const Text(
                            'MAP',
                            style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      property.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property.address,
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
