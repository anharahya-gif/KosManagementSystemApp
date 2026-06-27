import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/dashboard/presentation/cubit/recycle_bin_cubit.dart';
import 'package:kms/features/dashboard/presentation/cubit/recycle_bin_state.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/resident/domain/entities/resident_entity.dart';

class RecycleBinPage extends StatefulWidget {
  const RecycleBinPage({super.key});

  @override
  State<RecycleBinPage> createState() => _RecycleBinPageState();
}

class _RecycleBinPageState extends State<RecycleBinPage> with SingleTickerProviderStateMixin {
  late RecycleBinCubit _recycleBinCubit;
  late TabController _tabController;
  String? _orgId;

  @override
  void initState() {
    super.initState();
    _recycleBinCubit = sl<RecycleBinCubit>();
    _tabController = TabController(length: 3, vsync: this);
    _loadTrash();
  }

  void _loadTrash() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      _orgId = authState.user.organizationId;
      _recycleBinCubit.fetchDeletedItems(_orgId!);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _recycleBinCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('KOTAK SAMPAH'),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Properti'),
              Tab(text: 'Kamar'),
              Tab(text: 'Penghuni'),
            ],
          ),
        ),
        body: BlocConsumer<RecycleBinCubit, RecycleBinState>(
          listener: (context, state) {
            if (state is RecycleBinActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is RecycleBinError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (state is RecycleBinLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RecycleBinLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  _buildPropertiesList(state.deletedProperties),
                  _buildRoomsList(state.deletedRooms),
                  _buildResidentsList(state.deletedResidents),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyTrash(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.delete_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'Kotak Sampah $title Kosong',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Tidak ada data terhapus di kategori ini.',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesList(List<PropertyEntity> items) {
    if (items.isEmpty) return _buildEmptyTrash('Properti');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final prop = items[index];
        final deletedDateStr = prop.deletedAt != null
            ? DateFormatter.formatDateTimeReadable(prop.deletedAt!)
            : 'N/A';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.home, color: AppTheme.primaryColor),
            ),
            title: Text(prop.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prop.address, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Text(
                  'Dihapus: $deletedDateStr',
                  style: const TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: _buildActionsRow('property', prop.id, prop.name),
          ),
        );
      },
    );
  }

  Widget _buildRoomsList(List<RoomEntity> items) {
    if (items.isEmpty) return _buildEmptyTrash('Kamar');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final room = items[index];
        final deletedDateStr = room.deletedAt != null
            ? DateFormatter.formatDateTimeReadable(room.deletedAt!)
            : 'N/A';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
              child: const Icon(Icons.meeting_room, color: AppTheme.secondaryColor),
            ),
            title: Text('Kamar ${room.roomNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sewa: ${CurrencyFormatter.format(room.pricePerMonth)}/bulan',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  'Dihapus: $deletedDateStr',
                  style: const TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: _buildActionsRow('room', room.id, 'Kamar ${room.roomNumber}'),
          ),
        );
      },
    );
  }

  Widget _buildResidentsList(List<ResidentEntity> items) {
    if (items.isEmpty) return _buildEmptyTrash('Penghuni');

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final res = items[index];
        final deletedDateStr = res.deletedAt != null
            ? DateFormatter.formatDateTimeReadable(res.deletedAt!)
            : 'N/A';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppTheme.accentColor.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppTheme.accentColor),
            ),
            title: Text(res.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WA: ${res.phoneNumber}', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Text(
                  'Dihapus: $deletedDateStr',
                  style: const TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            trailing: _buildActionsRow('resident', res.id, res.fullName),
          ),
        );
      },
    );
  }

  Widget _buildActionsRow(String type, String id, String itemName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.restore, color: AppTheme.secondaryColor),
          tooltip: 'Pulihkan',
          onPressed: () {
            if (_orgId != null) {
              _recycleBinCubit.restoreItem(type, id, _orgId!);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete_forever, color: AppTheme.dangerColor),
          tooltip: 'Hapus Permanen',
          onPressed: () => _confirmHardDelete(type, id, itemName),
        ),
      ],
    );
  }

  void _confirmHardDelete(String type, String id, String itemName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Permanen?'),
          content: Text(
            'Apakah Anda yakin ingin menghapus "$itemName" secara permanen?\n\nTindakan ini TIDAK dapat dibatalkan.',
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
                if (_orgId != null) {
                  _recycleBinCubit.hardDeleteItem(type, id, _orgId!);
                }
              },
              child: const Text('Hapus Permanen'),
            ),
          ],
        );
      },
    );
  }
}
