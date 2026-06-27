import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/core/database/app_database.dart';
import 'package:kms/features/auth/domain/entities/user_profile_entity.dart';
import 'package:kms/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppDatabase _db;

  AuthCubit(this._db) : super(AuthInitial());

  /// Memuat profil aktif pertama kali (misal: mengambil data default Owner)
  Future<void> loadDefaultProfile() async {
    emit(AuthLoading());
    try {
      // Ambil user dengan role owner pertama
      final ownerQuery = _db.select(_db.userProfiles)
        ..where((t) => t.role.equals('owner'))
        ..limit(1);
      final owners = await ownerQuery.get();

      if (owners.isNotEmpty) {
        await switchProfile(owners.first.id);
      } else {
        emit(const AuthFailure("Tidak ada profil default yang ditemukan."));
      }
    } catch (e) {
      emit(AuthFailure("Gagal memuat profil default: $e"));
    }
  }

  /// Berpindah profil pengguna secara dinamis (Owner <=> Manager)
  Future<void> switchProfile(String userId) async {
    emit(AuthLoading());
    try {
      // 1. Ambil data profil user
      final userQuery = _db.select(_db.userProfiles)..where((t) => t.id.equals(userId));
      final userRow = await userQuery.getSingle();
      
      final userEntity = UserProfileEntity(
        id: userRow.id,
        organizationId: userRow.organizationId,
        fullName: userRow.fullName,
        phoneNumber: userRow.phoneNumber,
        email: userRow.email,
        role: UserRole.fromString(userRow.role),
      );

      // 2. Jika role adalah manager, ambil daftar properti yang ditugaskan
      List<String> assignedPropertyIds = [];
      if (userEntity.isManager) {
        final pmQuery = _db.select(_db.propertyManagers)
          ..where((t) => t.userId.equals(userId));
        final pmRows = await pmQuery.get();
        assignedPropertyIds = pmRows.map((r) => r.propertyId).toList();
      }

      emit(AuthSuccess(
        user: userEntity,
        assignedPropertyIds: assignedPropertyIds,
      ));
    } catch (e) {
      emit(AuthFailure("Gagal memindahkan profil: $e"));
    }
  }

  /// Mengambil semua profil user di database untuk dropdown switcher
  Future<List<UserProfile>> getAllAvailableProfiles() async {
    try {
      return await _db.select(_db.userProfiles).get();
    } catch (_) {
      return [];
    }
  }
}
