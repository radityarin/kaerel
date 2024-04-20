import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/components/components.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel/screens/main/views/detail/detail_screen.dart';
import 'package:kaerel/screens/main/views/schedule/blocs/get_schedule/get_schedule_bloc.dart';
import 'package:kaerel/screens/main/views/schedule/blocs/get_station/get_station_bloc.dart';
import 'package:kaerel/screens/main/views/schedule/views/loading.dart';

import 'package:kaerel_repository/kaerel_repository.dart';
import 'package:kaerel_utils/kaerel_utils.dart';

import 'choose_station_bottom_sheet.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final GetStationBloc _getStationBloc = GetStationBloc();
  final GetScheduleBloc _getScheduleBloc = GetScheduleBloc();

  List<Station> stationList = List.empty(growable: true);
  List<StationSchedule> scheduleList = List.empty(growable: true);

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
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _getStationBloc),
          BlocProvider.value(value: _getScheduleBloc),
        ],
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            children: [
              customDivider(16),
              chooseStation(context),
              customDivider(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 0.5, color: KaerelColor.greyBorder),
              ),
              showScheduleList()
            ],
          )),
        ));
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
                  SizedBox(height: 64),
                  Icon(FontAwesomeIcons.trash),
                  Text('Gagal mendapatkan data stasiun')
                ],
              ),
            );
          });
    } else {
      if (isOrigin) {
        showModalBottomSheet(
            showDragHandle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return BottomSheetWidget(
                      stationList: stationList,
                      scheduleList: List.empty(growable: true),
                      isOrigin: isOrigin)
                  .setOnStationSelect((Station trainStation) {
                _getScheduleBloc.add(GetSchedule(trainStation.id));
                setState(() {
                  originStation = trainStation;
                  originStationName = trainStation.name;
                });
              });
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
                      scheduleList: scheduleList,
                      isOrigin: isOrigin)
                  .setOnStationScheduleSelect(
                      (StationSchedule selectedStationSchedule) {
                destinationStationName = selectedStationSchedule.destination;
                filterScheduleList();
                setState(() {
                  destinationStationName = selectedStationSchedule.destination;
                  filterScheduleList();
                });
              });
            });
      }
    }
  }

  Widget chooseStation(BuildContext context) {
    return BlocBuilder<GetStationBloc, GetStationState>(
        builder: (blocContext, state) {
      if (state is GetStationListSuccess) {
        stationList.clear();
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

  void filterScheduleList() {
    scheduleList = scheduleList
        .where((stationSchedule) => stationSchedule.destination
            .toLowerCase()
            .contains(destinationStationName.toLowerCase()))
        .toList();
  }

  Widget showScheduleList() {
    return BlocBuilder<GetScheduleBloc, GetScheduleState>(
        builder: (blocContext, state) {
      if (state is GetScheduleListSuccess) {
        scheduleList.clear();
        scheduleList.addAll(state.listStationSchedule);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: scheduleList.isNotEmpty,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.start,
                  'Keberangkatan selanjutnya',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: scheduleList.length,
                itemBuilder: (context, int i) {
                  StationSchedule stationSchedule = scheduleList[i];
                  String destination = stationSchedule.destination;
                  String colorCode = stationSchedule.color;
                  String route = stationSchedule.route;
                  String upcomingTimeEstimated = stationSchedule.getUpcomingScheduleTimeEstimated();
                  String upcomingRemainingTime = stationSchedule.getUpcomingScheduleTimeRemainingString();
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteFromBottom(
                          page:
                              DetailScreen(stationSchedule: stationSchedule)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 16.0, right: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: KaerelColor.greyBorder),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Kereta tujuan',
                              style: TextStyle(fontWeight: FontWeight.w200),
                            ),
                            customDivider(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(int.parse(
                                                    colorCode.substring(1, 7),
                                                    radix: 16) +
                                                0xFF000000),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          capitalizeFirstLetter(destination),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          upcomingTimeEstimated,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          upcomingRemainingTime,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                customDivider(8),
                                Text(
                                  route,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        );
      } else if (state is GetScheduleListLoading) {
        return loadingScreen();
      } else {
        return initialPlaceholderScreen();
      }
    });
  }
}
