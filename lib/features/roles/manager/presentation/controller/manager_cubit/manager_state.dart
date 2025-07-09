part of 'manager_cubit.dart';


sealed class ManagerState extends Equatable {
  const ManagerState();

  @override
  List<Object> get props => [];
}

final class ManagerInitial extends ManagerState {}

class ManagerLoading extends ManagerState {}

class ManagerRevisedExcusesLoaded extends ManagerState {
  final List<GetExcuseInfoModel> excuses;
  const ManagerRevisedExcusesLoaded(this.excuses);
  @override
  List<Object> get props => [excuses];
}

class ManagerPendingExcusesLoaded extends ManagerState {
  final List<GetExcuseInfoModel> excuses;
  const ManagerPendingExcusesLoaded(this.excuses);
  @override
  List<Object> get props => [excuses];
}

class ManagerExcuseStatusUpdated extends ManagerState {
  final String message;
  const ManagerExcuseStatusUpdated(this.message);
  @override
  List<Object> get props => [message];
}

class ManagerError extends ManagerState {
  final Failure failure;
  const ManagerError(this.failure);
  @override
  List<Object> get props => [failure];
}
