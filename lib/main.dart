import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/core/database/db_seeder.dart';
import 'package:kms/core/di/injection_container.dart' as di;
import 'package:kms/core/theme/app_theme.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/dashboard/presentation/pages/main_scaffold_page.dart';

void main() async {
  // 1. Memastikan bindings Flutter diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi format tanggal bahasa Indonesia
  await initializeDateFormatting('id_ID', null);

  // 3. Inisialisasi Service Locator (GetIt)
  await di.init();

  // 4. Seed database dengan data simulasi awal jika kosong
  final db = di.sl<AppDatabase>();
  await DbSeeder.seed(db);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => di.sl<AuthCubit>()..loadDefaultProfile(),
        ),
      ],
      child: MaterialApp(
        title: 'Kos Management System',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark, // Default menggunakan Dark Mode agar wownya terlihat
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const MainScaffoldPage(),
      ),
    );
  }
}
