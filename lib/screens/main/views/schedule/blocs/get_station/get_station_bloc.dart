import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaerel_repository/src/models/base_response.dart';
import 'package:kaerel/network/api_service.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

part 'get_station_event.dart';
part 'get_station_state.dart';

class GetStationBloc extends Bloc<GetStationEvent, GetStationState> {
  
  final ApiService apiService = ApiService();

  GetStationBloc() : super(GetStationListInitial()) {
    on<GetStation>((event, emit) async {
      emit(GetStationListLoading());
      try {
        dynamic data = await apiService.getStation();
        BaseResponse<Station> baseResponse = BaseResponse<Station>.fromJson(data, (json) => Station.fromJson(json));
        List<Station> listTrainStation = baseResponse.data;
        listTrainStation.forEach((element) {
          print(element.name);
        });
        emit(GetStationListSuccess(listTrainStation));
      } catch (e) {
        emit(GetStationListFailure());
      }
    });
  }

}
