import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/components/components.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel/screens/main/views/schedule/blocs/get_schedule/get_schedule_bloc.dart';
import 'package:kaerel/screens/main/views/schedule/blocs/get_station/get_station_bloc.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

import 'choose_station_bottom_sheet.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final GetStationBloc _getStationBloc = GetStationBloc();
  final GetScheduleBloc _getScheduleBloc = GetScheduleBloc();
  List<Station> stationList = List.empty(growable: true);
  List<Schedule> scheduleList = List.empty(growable: true);

  String originStationName = 'Pilih stasiun keberangkatanmu';
  Station originStation = Station.placeholder();
  String destinationStationName = 'Pilih stasiun tujuanmu';

  @override
  void initState() {
    _getStationBloc.add(const GetStation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          child: Column(
        children: [
          customDivider(16),
          chooseStation(context),
          customDivider(8),
          showScheduleList()
        ],
      )),
    );
  }

  void showChooseStationBottomDialog(
      BuildContext context,
      List<Station> stationList,
      bool isOrigin,
      void Function(Station) onChooseCallback) {
    if (stationList.isEmpty) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const Center(
              child: Column(
                children: [
                  Icon(FontAwesomeIcons.trash),
                  Text('Gagal mendapatkan data stasiun')
                ],
              ),
            );
          });
    } else {
      showModalBottomSheet(
          showDragHandle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return BottomSheetWidget(
                stationList: stationList,
                isOrigin: isOrigin,
                onSelect: (Station trainStation) {
                  setState(() {
                    if (isOrigin) {
                      originStation = trainStation;
                      originStationName = trainStation.name;
                      getScheduleByOrigin(trainStation);
                    } else {
                      destinationStationName = trainStation.name;
                    }
                  });
                });
          });
    }
  }

  Widget chooseStation(BuildContext context) {
    return BlocBuilder<GetStationBloc, GetStationState>(
        builder: (blocContext, state) {
      if (state is GetStationListSuccess) {
        stationList.addAll(state.trainStation);
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: KaerelColor.greyBorder),
              color: KaerelColor.grey1,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              GestureDetector(
                onTap: () {
                  showChooseStationBottomDialog(
                      context, stationList, true, (onChooseTrainStation) {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.train,
                        color: KaerelColor.green1,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(originStationName)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(
                  color: KaerelColor.greyBorder,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showChooseStationBottomDialog(
                      context, stationList, false, (onChooseTrainStation) {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.train,
                        color: KaerelColor.orange1,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(destinationStationName)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      );
    });
  }

  void getScheduleByOrigin(Station trainStation) {
    _getScheduleBloc.add(GetSchedule(trainStation.id));
  }

  Widget showScheduleList() {
    return BlocBuilder<GetScheduleBloc, GetScheduleState>(
        builder: (blocContext, state) {
      if (state is GetScheduleListSuccess) {
        scheduleList.addAll(state.scheduleList);
      }
      return Placeholder();
    });
  }
}
