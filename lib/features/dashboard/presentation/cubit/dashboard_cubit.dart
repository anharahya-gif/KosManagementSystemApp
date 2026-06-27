import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms/features/contract/domain/repositories/contract_repository.dart';
import 'package:kms/features/dashboard/presentation/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final ContractRepository _repository;

  DashboardCubit(this._repository) : super(DashboardInitial());

  Future<void> loadDashboardMetrics(String organizationId, {String? propertyId}) async {
    emit(DashboardLoading());
    final result = await _repository.getDashboardMetrics(organizationId, propertyId: propertyId);
    if (result.isSuccess) {
      final data = result.dataOrNull!;
      emit(DashboardLoaded(
        occupancyRate: data['occupancy_rate'] ?? 0.0,
        totalRevenue: data['total_revenue'] ?? 0.0,
        totalReceivable: data['total_receivable'] ?? 0.0,
        vacantRooms: (data['vacant_rooms'] ?? 0.0).toInt(),
      ));
    } else {
      emit(DashboardError(result.failureOrNull!.message));
    }
  }
}
