import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/services/backup_service.dart';
import 'package:kms/core/theme/app_theme.dart';

class BackupRestorePage extends StatefulWidget {
  const BackupRestorePage({super.key});

  @override
  State<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends State<BackupRestorePage> {
  final BackupService _backupService = sl<BackupService>();
  bool _isLoading = false;
  String? _statusMessage;
  bool _isSuccess = true;

  Future<void> _exportData() async {
    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      final filePath = await _backupService.exportToJson();
      setState(() {
        _isLoading = false;
        _isSuccess = true;
        _statusMessage = 'Data berhasil diekspor ke:\n$filePath';
      });

      if (!mounted) return;

      // Tawarkan untuk share file
      final shouldShare = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ekspor Berhasil!'),
          content: Text('File backup berhasil disimpan di:\n$filePath\n\nIngin membagikan file ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Tutup'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Bagikan File'),
            ),
          ],
        ),
      );

      if (shouldShare == true) {
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(filePath)],
            text: 'KMS Database Backup',
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
        _statusMessage = 'Gagal mengekspor data: $e';
      });
    }
  }

  Future<void> _importData() async {
    // 1. Pilih file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      dialogTitle: 'Pilih File Backup KMS (.json)',
    );

    if (result == null || result.files.single.path == null) return;
    final filePath = result.files.single.path!;

    // 2. Konfirmasi restore
    if (!mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Import'),
        content: Text(
          'PERINGATAN: Seluruh data saat ini akan DIHAPUS dan diganti dengan data dari file backup.\n\nFile: ${filePath.split(Platform.pathSeparator).last}\n\nLanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Import Sekarang'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    final importResult = await _backupService.importFromJson(filePath);

    setState(() {
      _isLoading = false;
      _isSuccess = importResult.success;
      _statusMessage = importResult.message;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(importResult.message),
        backgroundColor: importResult.success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BACKUP & RESTORE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(Icons.backup, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text(
                    'Backup & Restore Data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Ekspor seluruh data ke file JSON untuk backup,\natau impor dari file backup sebelumnya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Export Button
            _buildActionCard(
              icon: Icons.upload_file,
              title: 'Ekspor Data (Backup)',
              subtitle: 'Simpan seluruh data database ke file JSON.\nFile akan tersimpan di folder dokumen perangkat.',
              buttonText: 'Ekspor Sekarang',
              buttonColor: AppTheme.secondaryColor,
              onPressed: _isLoading ? null : _exportData,
            ),
            const SizedBox(height: 16),

            // Import Button
            _buildActionCard(
              icon: Icons.download,
              title: 'Impor Data (Restore)',
              subtitle: 'Muat data dari file backup JSON.\nPERINGATAN: Data saat ini akan ditimpa seluruhnya.',
              buttonText: 'Pilih File & Impor',
              buttonColor: AppTheme.warningColor,
              onPressed: _isLoading ? null : _importData,
            ),
            const SizedBox(height: 24),

            // Loading / Status
            if (_isLoading)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Memproses...', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),

            if (_statusMessage != null && !_isLoading)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isSuccess
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isSuccess ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle : Icons.error,
                      color: _isSuccess ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _statusMessage!,
                        style: TextStyle(
                          color: _isSuccess ? Colors.green.shade800 : Colors.red.shade800,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required Color buttonColor,
    VoidCallback? onPressed,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: buttonColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: Icon(icon, size: 20),
                label: Text(buttonText),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
