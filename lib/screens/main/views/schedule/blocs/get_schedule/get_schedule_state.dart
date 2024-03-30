part of 'get_schedule_bloc.dart';

sealed class GetScheduleState extends Equatable {
  const GetScheduleState();

  @override
  List<Object> get props => [];
}

final class GetScheduleListInitial extends GetScheduleState {}
final class GetScheduleListLoading extends GetScheduleState {}
final class GetScheduleListFailure extends GetScheduleState {}
final class GetScheduleListSuccess extends GetScheduleState {
  final List<Schedule> scheduleList;

  const GetScheduleListSuccess(this.scheduleList);

  @override
  List<Object> get props => [];
}
