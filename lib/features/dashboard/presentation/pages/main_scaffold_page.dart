import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/contract/presentation/pages/contracts_page.dart';
import 'package:kms/features/contract/presentation/pages/invoices_page.dart';
import 'package:kms/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:kms/features/dashboard/presentation/pages/backup_restore_page.dart';
import 'package:kms/features/dashboard/presentation/pages/recycle_bin_page.dart';
import 'package:kms/features/property/presentation/pages/properties_page.dart';
import 'package:kms/features/resident/presentation/pages/residents_page.dart';

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({super.key});

  @override
  State<MainScaffoldPage> createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const PropertiesPage(),
    const ResidentsPage(),
    const ContractsPage(),
    const InvoicesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AuthSuccess) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                _currentIndex == 0
                    ? 'DASHBOARD'
                    : _currentIndex == 1
                        ? 'PROPERTI'
                        : _currentIndex == 2
                            ? 'PENGHUNI'
                            : _currentIndex == 3
                                ? 'KONTRAK SEWA'
                                : 'TAGIHAN & PIUTANG',
              ),
              actions: [
                // Switch Profile Dev Button
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.supervised_user_circle, size: 28),
                      tooltip: 'Dev Switch Profile',
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    );
                  },
                ),
              ],
            ),
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_currentIndex],
            ),
            drawer: _buildNavigationDrawer(context, user.fullName, user.role.name),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined),
                  activeIcon: Icon(Icons.home_work),
                  label: 'Properti',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_alt_outlined),
                  activeIcon: Icon(Icons.people_alt),
                  label: 'Penghuni',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description_outlined),
                  activeIcon: Icon(Icons.description),
                  label: 'Kontrak',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: Icon(Icons.account_balance_wallet),
                  label: 'Keuangan',
                ),
              ],
            ),
            endDrawer: _buildDevDrawer(context, user.id),
          );
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Gagal Memuat Sesi Pengguna'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<AuthCubit>().loadDefaultProfile(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDevDrawer(BuildContext context, String currentUserId) {
    return Drawer(
      child: SafeArea(
        child: FutureBuilder<List<UserProfile>>(
          future: context.read<AuthCubit>().getAllAvailableProfiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final profiles = snapshot.data ?? [];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).colorScheme.primary,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KMS Dev Sandbox',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pilih profil simulasi di bawah untuk menguji multi-role',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'DAFTAR PENGGUNA LOKAL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: profiles.length,
                    itemBuilder: (context, index) {
                      final profile = profiles[index];
                      final isCurrent = profile.id == currentUserId;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: profile.role == 'owner'
                              ? Colors.indigo.shade200
                              : Colors.teal.shade200,
                          child: Icon(
                            profile.role == 'owner'
                                ? Icons.admin_panel_settings
                                : Icons.assignment_ind,
                            color: Colors.black87,
                          ),
                        ),
                        title: Text(
                          profile.fullName,
                          style: TextStyle(
                            fontWeight:
                                isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          'Role: ${profile.role.toUpperCase()} | ${profile.email}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        trailing: isCurrent
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                        selected: isCurrent,
                        onTap: () {
                          Navigator.of(context).pop(); // Close drawer
                          context.read<AuthCubit>().switchProfile(profile.id);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Batal'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context, String userName, String userRole) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            accountName: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: Text(
              'Role: ${userRole.toUpperCase()}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white, size: 36),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.home_work_outlined),
            title: const Text('Properti'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text('Penghuni'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Kontrak Sewa'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 3;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Keuangan & Tagihan'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 4;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.delete_sweep_outlined, color: AppTheme.warningColor),
            title: const Text('Kotak Sampah / Recycle Bin'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecycleBinPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Pengaturan (Mock)'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur Pengaturan tersedia di Fase 2.')),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.backup_outlined, color: AppTheme.secondaryColor),
            title: const Text('Backup & Restore'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BackupRestorePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
