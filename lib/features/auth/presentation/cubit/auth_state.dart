import 'package:equatable/equatable.dart';
import 'package:kms/features/auth/domain/entities/user_profile_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserProfileEntity user;
  final List<String> assignedPropertyIds; // Properti yang ditugaskan ke manager (kosong jika owner)

  const AuthSuccess({
    required this.user,
    required this.assignedPropertyIds,
  });

  @override
  List<Object?> get props => [user, assignedPropertyIds];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
