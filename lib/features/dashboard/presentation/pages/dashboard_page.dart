import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/di/injection_container.dart';
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/core/utils/currency_formatter.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';
import 'package:kms/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:kms/features/dashboard/presentation/cubit/dashboard_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardCubit _dashboardCubit;

  @override
  void initState() {
    super.initState();
    _dashboardCubit = sl<DashboardCubit>();
    _loadMetrics();
  }

  void _loadMetrics() {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      final user = authState.user;
      if (user.isOwner) {
        _dashboardCubit.loadDashboardMetrics(user.organizationId);
      } else {
        // Manager: filter by assigned properties if available
        final propertyId = authState.assignedPropertyIds.isNotEmpty
            ? authState.assignedPropertyIds.first // Ambil properti pertama untuk simulasi dashboard terfilter
            : null;
        _dashboardCubit.loadDashboardMetrics(
          user.organizationId,
          propertyId: propertyId,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _loadMetrics();
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _loadMetrics();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 24),
                BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is DashboardLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGridMetrics(state),
                          const SizedBox(height: 24),
                          _buildQuickActions(),
                          const SizedBox(height: 24),
                          _buildRecentOccupancySection(state),
                        ],
                      );
                    }

                    if (state is DashboardError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text(
                            'Gagal memuat dashboard: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    final authState = context.read<AuthCubit>().state;
    String name = "";
    String roleName = "";
    if (authState is AuthSuccess) {
      name = authState.user.fullName;
      roleName = authState.user.role.name.toUpperCase();
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang,',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  roleName,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 26,
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            name.isNotEmpty ? name[0] : 'U',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridMetrics(DashboardLoaded state) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildMetricCard(
          title: 'Pendapatan Aktif',
          value: CurrencyFormatter.format(state.totalRevenue),
          icon: Icons.payments,
          gradient: AppTheme.secondaryGradient,
        ),
        _buildMetricCard(
          title: 'Piutang Outstanding',
          value: CurrencyFormatter.format(state.totalReceivable),
          icon: Icons.account_balance_wallet,
          gradient: state.totalReceivable > 0
              ? const LinearGradient(colors: [AppTheme.dangerColor, Color(0xFFC0392B)])
              : AppTheme.primaryGradient,
        ),
        _buildMetricCard(
          title: 'Tingkat Hunian',
          value: '${state.occupancyRate.toStringAsFixed(1)}%',
          icon: Icons.pie_chart,
          gradient: AppTheme.primaryGradient,
        ),
        _buildMetricCard(
          title: 'Kamar Kosong',
          value: '${state.vacantRooms} Kamar',
          icon: Icons.meeting_room,
          gradient: AppTheme.accentGradient,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: Colors.white, size: 20),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final authState = context.read<AuthCubit>().state;
    bool isOwner = false;
    if (authState is AuthSuccess) {
      isOwner = authState.user.isOwner;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu Pintar',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (isOwner)
              _buildActionButton(
                label: 'Properti',
                icon: Icons.add_business,
                color: AppTheme.primaryColor,
                onTap: () {
                  // TODO: Navigate to add property
                },
              ),
            _buildActionButton(
              label: 'Penghuni',
              icon: Icons.person_add,
              color: AppTheme.secondaryColor,
              onTap: () {
                // TODO: Navigate to add resident
              },
            ),
            _buildActionButton(
              label: 'Buat Kontrak',
              icon: Icons.border_color,
              color: AppTheme.warningColor,
              onTap: () {
                // TODO: Navigate to create contract
              },
            ),
            _buildActionButton(
              label: 'Bayar Sewa',
              icon: Icons.add_card,
              color: AppTheme.accentColor,
              onTap: () {
                // TODO: Navigate to record payment
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.3), width: 1.5),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRecentOccupancySection(DashboardLoaded state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kesehatan Okupansi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Icon(Icons.insights, color: AppTheme.primaryColor, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: state.occupancyRate / 100,
            backgroundColor: const Color(0xFF334155),
            color: AppTheme.secondaryColor,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Terisi: ${(state.occupancyRate).toStringAsFixed(0)}%',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Text(
                'Kosong: ${state.vacantRooms} Kamar',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
