part of 'station_bloc.dart';

sealed class StationState extends Equatable {
  const StationState();

  @override
  List<Object> get props => [];
}

final class GetStationListInitial extends StationState {}
final class GetStationListLoading extends StationState {}
final class GetStationListFailure extends StationState {}
final class GetStationListSuccess extends StationState {
  final List<TrainStation> trainStation;

  const GetStationListSuccess(this.trainStation);

  @override
  List<Object> get props => [];
}
