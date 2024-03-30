part of 'get_station_bloc.dart';

sealed class GetStationEvent extends Equatable {
  const GetStationEvent();

  @override
  List<Object> get props => [];
}

class GetStation extends GetStationEvent {

  const GetStation();
  
}