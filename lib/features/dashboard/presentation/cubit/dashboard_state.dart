import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final double occupancyRate;
  final double totalRevenue;
  final double totalReceivable;
  final int vacantRooms;

  const DashboardLoaded({
    required this.occupancyRate,
    required this.totalRevenue,
    required this.totalReceivable,
    required this.vacantRooms,
  });

  @override
  List<Object?> get props => [occupancyRate, totalRevenue, totalReceivable, vacantRooms];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
