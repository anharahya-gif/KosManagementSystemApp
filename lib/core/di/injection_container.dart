import 'package:get_it/get_it.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:kms/features/property/data/repositories/property_repository_impl.dart';
import 'package:kms/features/property/domain/repositories/property_repository.dart';
import 'package:kms/features/property/presentation/cubit/property_cubit.dart';
import 'package:kms/features/resident/data/repositories/resident_repository_impl.dart';
import 'package:kms/features/resident/domain/repositories/resident_repository.dart';
import 'package:kms/features/resident/presentation/cubit/resident_cubit.dart';
import 'package:kms/features/contract/data/repositories/contract_repository_impl.dart';
import 'package:kms/features/contract/domain/repositories/contract_repository.dart';
import 'package:kms/features/contract/presentation/cubit/contract_cubit.dart';
import 'package:kms/features/contract/presentation/cubit/invoice_cubit.dart';
import 'package:kms/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:kms/features/dashboard/presentation/cubit/recycle_bin_cubit.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  // 1. Database
  final database = AppDatabase();
  sl.registerSingleton<AppDatabase>(database);

  // 2. Features - Repositories
  sl.registerLazySingleton<PropertyRepository>(() => PropertyRepositoryImpl(sl()));
  sl.registerLazySingleton<ResidentRepository>(() => ResidentRepositoryImpl(sl()));
  sl.registerLazySingleton<ContractRepository>(() => ContractRepositoryImpl(sl()));

  // 3. State Management (Cubits)
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl()));
  sl.registerFactory<PropertyCubit>(() => PropertyCubit(sl()));
  sl.registerFactory<ResidentCubit>(() => ResidentCubit(sl()));
  sl.registerFactory<ContractCubit>(() => ContractCubit(sl()));
  sl.registerFactory<InvoiceCubit>(() => InvoiceCubit(sl()));
  sl.registerFactory<DashboardCubit>(() => DashboardCubit(sl()));
  sl.registerFactory<RecycleBinCubit>(() => RecycleBinCubit(
        db: sl(),
        propertyRepository: sl(),
        residentRepository: sl(),
      ));
}
