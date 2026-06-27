import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/features/property/domain/entities/property_entity.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/property/presentation/cubit/property_state.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/property/presentation/pages/add_room_page.dart';

class PropertyDetailPage extends StatefulWidget {
  final PropertyEntity property;

  const PropertyDetailPage({super.key, required this.property});

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late PropertyCubit _propertyCubit;

  @override
  void initState() {
    super.initState();
    _propertyCubit = sl<PropertyCubit>();
    _loadRooms();
  }

  void _loadRooms() {
    _propertyCubit.fetchPropertyDetail(widget.property.id);
  }

  Color _getStatusColor(RoomStatus status) {
    switch (status) {
      case RoomStatus.vacant:
        return AppTheme.secondaryColor;
      case RoomStatus.occupied:
        return AppTheme.primaryColor;
      case RoomStatus.reserved:
        return AppTheme.accentColor;
      case RoomStatus.maintenance:
        return AppTheme.warningColor;
      case RoomStatus.inactive:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _propertyCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.property.name.toUpperCase()),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: 'Hapus Properti',
              onPressed: () => _confirmDeleteProperty(context),
            ),
          ],
        ),
        body: BlocConsumer<PropertyCubit, PropertyState>(
          listener: (context, state) {
            if (state is PropertyActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is PropertyLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PropertyDetailLoaded) {
              final rooms = state.rooms;
              if (rooms.isEmpty) {
                return _buildEmptyState(context);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPropertyHeaderCard(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'DAFTAR KAMAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        final room = rooms[index];
                        return _buildRoomTile(room);
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is PropertyError) {
              return Center(
                child: Text(
                  'Gagal memuat detail: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRoomPage(propertyId: widget.property.id),
              ),
            );
            if (result == true) {
              _loadRooms();
            }
          },
          child: const Icon(Icons.add_home),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        _buildPropertyHeaderCard(),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.meeting_room_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Belum Ada Kamar Terdaftar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Daftarkan kamar pertama untuk properti ini.',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyHeaderCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppTheme.darkCardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppTheme.primaryColor, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.property.address,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tipe: ${widget.property.type.toUpperCase()}',
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (widget.property.latitude != null && widget.property.longitude != null) ...[
            const Divider(color: Color(0xFF334155), height: 24),
            Row(
              children: [
                const Icon(Icons.explore, color: AppTheme.secondaryColor, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Koordinat: ${widget.property.latitude!.toStringAsFixed(6)}, ${widget.property.longitude!.toStringAsFixed(6)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('LOKASI ${widget.property.name.toUpperCase()}'),
                          ),
                          body: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(widget.property.latitude!, widget.property.longitude!),
                              initialZoom: 16.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.kms.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: LatLng(widget.property.latitude!, widget.property.longitude!),
                                    width: 80,
                                    height: 80,
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.map, size: 16, color: AppTheme.secondaryColor),
                  label: const Text(
                    'Lihat Peta',
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildRoomTile(RoomEntity room) {
    final statusColor = _getStatusColor(room.status);
    final formattedPrice = CurrencyFormatter.format(room.pricePerMonth);
    
    String locationText = "";
    if (room.buildingName != null && room.buildingName!.isNotEmpty) {
      locationText += room.buildingName!;
    }
    if (room.floorName != null && room.floorName!.isNotEmpty) {
      if (locationText.isNotEmpty) locationText += " - ";
      locationText += room.floorName!;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
          ),
          child: Text(
            room.roomNumber,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        title: Text(
          formattedPrice,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: locationText.isNotEmpty
            ? Text(
                locationText,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            room.status.name.toUpperCase(),
            style: TextStyle(
              color: statusColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () => _showRoomActionSheet(context, room),
      ),
    );
  }

  void _showRoomActionSheet(BuildContext context, RoomEntity room) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final isMaintenance = room.status == RoomStatus.maintenance;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Kelola ${room.roomNumber}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  isMaintenance ? Icons.check_circle_outline : Icons.build,
                  color: isMaintenance ? Colors.green : AppTheme.warningColor,
                ),
                title: Text(
                  isMaintenance
                      ? 'Selesaikan Pemeliharaan (Vacant)'
                      : 'Tandai Butuh Perbaikan (Maintenance)',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _propertyCubit.toggleRoomMaintenance(
                    room.id,
                    widget.property.id,
                    !isMaintenance,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Kamar'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRoomPage(
                        propertyId: widget.property.id,
                        roomToEdit: room,
                      ),
                    ),
                  );
                  if (result == true) {
                    _loadRooms();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: AppTheme.dangerColor),
                title: const Text('Hapus Kamar'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDeleteRoom(context, room);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteProperty(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Hapus Properti?'),
          content: Text(
            'Apakah Anda yakin ingin memindahkan "${widget.property.name}" ke kotak sampah?\n\nKamar-kamar di dalamnya juga akan otomatis dinonaktifkan.',
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
                final authState = context.read<AuthCubit>().state;
                if (authState is AuthSuccess) {
                  _propertyCubit.softDeleteProperty(
                    widget.property.id,
                    authState.user.organizationId,
                  );
                  Navigator.pop(context); // return to list properties
                }
              },
              child: const Text('Ya, Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteRoom(BuildContext context, RoomEntity room) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Hapus Kamar?'),
          content: Text(
            'Apakah Anda yakin ingin memindahkan "Kamar ${room.roomNumber}" ke kotak sampah?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
              onPressed: () {
                Navigator.pop(dialogCtx);
                _propertyCubit.softDeleteRoom(room.id, widget.property.id);
              },
              child: const Text('Ya, Hapus'),
            ),
          ],
        );
      },
    );
  }
}
