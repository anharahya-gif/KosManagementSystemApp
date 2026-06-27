import 'package:flutter/material.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/date_formatter.dart';
import 'package:kms/features/property/domain/entities/room_entity.dart';
import 'package:kms/features/property/domain/entities/room_facility_entity.dart';
import 'package:kms/features/property/domain/repositories/property_repository.dart';
import 'package:uuid/uuid.dart';

class RoomFacilitiesPage extends StatefulWidget {
  final RoomEntity room;

  const RoomFacilitiesPage({super.key, required this.room});

  @override
  State<RoomFacilitiesPage> createState() => _RoomFacilitiesPageState();
}

class _RoomFacilitiesPageState extends State<RoomFacilitiesPage> {
  final PropertyRepository _repository = sl<PropertyRepository>();
  List<RoomFacilityEntity> _facilities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFacilities();
  }

  Future<void> _loadFacilities() async {
    setState(() => _isLoading = true);
    final result = await _repository.getRoomFacilities(widget.room.id);
    if (result.isSuccess) {
      setState(() {
        _facilities = result.dataOrNull ?? [];
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat fasilitas: ${result.failureOrNull?.message}')),
        );
      }
    }
  }

  Color _getConditionColor(RoomFacilityCondition condition) {
    switch (condition) {
      case RoomFacilityCondition.good:
        return AppTheme.secondaryColor;
      case RoomFacilityCondition.needsRepair:
        return AppTheme.warningColor;
      case RoomFacilityCondition.broken:
      default:
        return AppTheme.dangerColor;
    }
  }

  IconData _getConditionIcon(RoomFacilityCondition condition) {
    switch (condition) {
      case RoomFacilityCondition.good:
        return Icons.check_circle_outline;
      case RoomFacilityCondition.needsRepair:
        return Icons.build_circle_outlined;
      case RoomFacilityCondition.broken:
      default:
        return Icons.cancel_outlined;
    }
  }

  void _showFacilityFormDialog({RoomFacilityEntity? facilityToEdit}) {
    final nameController = TextEditingController(text: facilityToEdit?.name ?? '');
    final descController = TextEditingController(text: facilityToEdit?.description ?? '');
    RoomFacilityCondition condition = facilityToEdit?.condition ?? RoomFacilityCondition.good;

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return AlertDialog(
              title: Text(facilityToEdit == null ? 'Tambah Fasilitas' : 'Edit Fasilitas'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Fasilitas / Aset',
                        hintText: 'Contoh: AC LG 1PK, Kasur Springbed',
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<RoomFacilityCondition>(
                      value: condition,
                      decoration: const InputDecoration(labelText: 'Kondisi Fasilitas'),
                      items: RoomFacilityCondition.values.map((cond) {
                        return DropdownMenuItem(
                          value: cond,
                          child: Text(cond.toReadableString()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateDialog(() {
                            condition = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi / Catatan (Opsional)',
                        hintText: 'Contoh: Remote hilang, dingin normal',
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(content: Text('Nama fasilitas tidak boleh kosong')),
                      );
                      return;
                    }

                    Navigator.pop(dialogCtx);
                    setState(() => _isLoading = true);

                    if (facilityToEdit == null) {
                      // Create new
                      final newFacility = RoomFacilityEntity(
                        id: const Uuid().v4(),
                        roomId: widget.room.id,
                        name: name,
                        condition: condition,
                        description: descController.text.trim().isEmpty ? null : descController.text.trim(),
                        createdAt: DateTime.now(),
                      );
                      await _repository.addRoomFacility(newFacility);
                    } else {
                      // Update existing
                      final updated = RoomFacilityEntity(
                        id: facilityToEdit.id,
                        roomId: facilityToEdit.roomId,
                        name: name,
                        condition: condition,
                        description: descController.text.trim().isEmpty ? null : descController.text.trim(),
                        createdAt: facilityToEdit.createdAt,
                      );
                      await _repository.updateRoomFacility(updated);
                    }

                    _loadFacilities();
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDeleteFacility(RoomFacilityEntity facility) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          title: const Text('Hapus Fasilitas?'),
          content: Text('Apakah Anda yakin ingin menghapus "${facility.name}" dari kamar ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
              onPressed: () async {
                Navigator.pop(dialogCtx);
                setState(() => _isLoading = true);
                await _repository.deleteRoomFacility(facility.id);
                _loadFacilities();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FASILITAS - ${widget.room.roomNumber.toUpperCase()}'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _facilities.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.build_circle_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text(
                        'Belum Ada Fasilitas Terdaftar',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Daftarkan inventaris/fasilitas di kamar ini\nuntuk memantau kondisinya.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _facilities.length,
                  itemBuilder: (context, index) {
                    final facility = _facilities[index];
                    final color = _getConditionColor(facility.condition);
                    final icon = _getConditionIcon(facility.condition);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(icon, color: color, size: 32),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    facility.name,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      facility.condition.toReadableString(),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (facility.description != null && facility.description!.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      facility.description!,
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                    ),
                                  ],
                                  const SizedBox(height: 8),
                                  Text(
                                    'Dibuat: ${DateFormatter.formatShort(DateFormatter.toIsoDateString(facility.createdAt))}',
                                    style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.blue),
                                  onPressed: () => _showFacilityFormDialog(facilityToEdit: facility),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 20, color: AppTheme.dangerColor),
                                  onPressed: () => _confirmDeleteFacility(facility),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () => _showFacilityFormDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
