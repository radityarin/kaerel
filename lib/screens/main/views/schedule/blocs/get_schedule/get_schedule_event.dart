part of 'get_schedule_bloc.dart';

sealed class GetScheduleEvent extends Equatable {
  const GetScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetSchedule extends GetScheduleEvent {

  final String stationId;

  const GetSchedule(this.stationId);
  
}