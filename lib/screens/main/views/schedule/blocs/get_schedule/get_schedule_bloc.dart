import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kaerel_repository/src/models/base_response.dart';
import 'package:kaerel/network/api_service.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

part 'get_schedule_event.dart';
part 'get_schedule_state.dart';

class GetScheduleBloc extends Bloc<GetScheduleEvent, GetScheduleState> {
  
  final ApiService apiService = ApiService();

  GetScheduleBloc() : super(GetScheduleListInitial()) {

    on<GetSchedule>((event, emit) async {
      emit(GetScheduleListLoading());
      try {
        dynamic data = await apiService.getScheduleByStationId(event.stationId);
        BaseResponse<Schedule> baseResponse = BaseResponse<Schedule>.fromJsonA(data, (json) => Schedule.fromJson(json));
        List<Schedule> listTrainStation = baseResponse.data;
        emit(GetScheduleListSuccess(listTrainStation));
      } catch (e) {
        emit(GetScheduleListFailure());
      }
    });

  }

}
