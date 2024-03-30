part of 'get_station_bloc.dart';

sealed class GetStationState extends Equatable {
  const GetStationState();

  @override
  List<Object> get props => [];
}

final class GetStationListInitial extends GetStationState {}
final class GetStationListLoading extends GetStationState {}
final class GetStationListFailure extends GetStationState {}
final class GetStationListSuccess extends GetStationState {
  final List<Station> trainStation;

  const GetStationListSuccess(this.trainStation);

  @override
  List<Object> get props => [];
}
