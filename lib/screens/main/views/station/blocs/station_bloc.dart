import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaerel/commons/base_response.dart';
import 'package:kaerel/network/api_service.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  
  final ApiService apiService = ApiService();

  StationBloc() : super(GetStationListInitial()) {
    on<GetStation>((event, emit) async {
      emit(GetStationListLoading());
      try {
        dynamic data = await apiService.getStation();
        BaseResponse<TrainStation> baseResponse = BaseResponse<TrainStation>.fromJson(data, (json) => TrainStation.fromJson(json));
        List<TrainStation> listTrainStation = baseResponse.data;
        emit(GetStationListSuccess(listTrainStation));
      } catch (e) {
        emit(GetStationListFailure());
      }
    });
  }

}
