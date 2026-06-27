import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:kms/core/theme/app_theme.dart';

class MapPickerPage extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const MapPickerPage({
    super.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  late final MapController _mapController;
  late LatLng _currentCenter;

  // Koordinat Jakarta Pusat sebagai default jika tidak ada initial coordinate
  static const LatLng _jakartaDefault = LatLng(-6.2088, 106.8456);

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _currentCenter = widget.initialLatitude != null && widget.initialLongitude != null
        ? LatLng(widget.initialLatitude!, widget.initialLongitude!)
        : _jakartaDefault;
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PILIH LOKASI PROPERTI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () {
              // Arahkan kamera peta kembali ke lokasi awal / default
              final target = widget.initialLatitude != null && widget.initialLongitude != null
                  ? LatLng(widget.initialLatitude!, widget.initialLongitude!)
                  : _jakartaDefault;
              _mapController.move(target, 16);
              setState(() {
                _currentCenter = target;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Widget Peta
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 4.0,
              onPositionChanged: (position, hasGesture) {
                // Perbarui koordinat ketika peta digeser
                if (position.center != null) {
                  setState(() {
                    _currentCenter = position.center!;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.kms.app',
              ),
            ],
          ),

          // 2. Fixed Pin / Marker tepat di Tengah Layar (Glassmorphism & Drop Shadow)
          Center(
            child: Padding(
              // Sedikit penyesuaian offset agar ujung jarum pin berada tepat di tengah layar
              padding: const EdgeInsets.only(bottom: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 12,
                    color: AppTheme.primaryColor,
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Panel Keterangan & Konfirmasi Lokasi di bagian bawah (Aesthetically Premium)
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFF334155), width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.explore_outlined,
                          color: AppTheme.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Koordinat Terpilih',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCoordinateColumn('LATITUDE', _currentCenter.latitude),
                        ),
                        Container(
                          width: 1,
                          height: 32,
                          color: Colors.grey.shade700,
                        ),
                        Expanded(
                          child: _buildCoordinateColumn('LONGITUDE', _currentCenter.longitude),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // Kembalikan LatLng ke halaman form
                        Navigator.pop(context, _currentCenter);
                      },
                      child: const Text(
                        'PILIH LOKASI INI',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinateColumn(String label, double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            val.toStringAsFixed(6),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: 'Courier', // Menyamakan ukuran angka
            ),
          ),
        ],
      ),
    );
  }
}
