part of 'supervisor_cubit.dart';

sealed class SupervisorState extends Equatable {
  const SupervisorState();

  @override
  List<Object> get props => [];
}

final class SupervisorInitial extends SupervisorState {}

class SupervisorLoading extends SupervisorState {}

class SupervisorRevisedExcusesLoaded extends SupervisorState {
  final List<GetExcuseInfoModel> excuses;
  const SupervisorRevisedExcusesLoaded(this.excuses);
  @override
  List<Object> get props => [excuses];
}

class SupervisorPendingExcusesLoaded extends SupervisorState {
  final List<GetExcuseInfoModel> excuses;
  const SupervisorPendingExcusesLoaded(this.excuses);
  @override
  List<Object> get props => [excuses];
}

class SupervisorExcuseStatusUpdated extends SupervisorState {
  final String message;
  const SupervisorExcuseStatusUpdated(this.message);
  @override
  List<Object> get props => [message];
}

class SupervisorError extends SupervisorState {
  final Failure failure;
  const SupervisorError(this.failure);
  @override
  List<Object> get props => [failure];
}
