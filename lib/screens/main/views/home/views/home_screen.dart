import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/components/components.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel/screens/main/views/station/blocs/station_bloc.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

import 'choose_station_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StationBloc _stationBloc = StationBloc();
  List<TrainStation> stationList = List.empty(growable: true);

  String test = 'Tentukan stasiun keberangkatanmu!';

  @override
  void initState() {
    _stationBloc.add(const GetStation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          customDivider(8),
          BlocBuilder<StationBloc, StationState>(builder: (blocContext, state) {
            return createBannerFindStation(context, state);
          }),
          customDivider(8)
        ],
      ),
    );
  }

  Widget createBannerFindStation(BuildContext context, StationState state) {
    if (state is GetStationListSuccess) {
      stationList.addAll(state.trainStation);
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16,
          ),
          color: KaerelColor.blue1,
        ),
        height: 105,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
               Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    test,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  showChooseStationBottomDialog(
                      context, stationList, (onChooseTrainStation) {});
                },
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: KaerelColor.green3),
                    child: Center(
                      child: Text(
                        'Cari Stasiun',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: KaerelColor.green1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showChooseStationBottomDialog(
      BuildContext context,
      List<TrainStation> stationList,
      void Function(TrainStation) onChooseCallback) {
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
            return BottomSheetWidget(stationList: stationList, onSelect: (TrainStation trainStation) {
              setState(() {
                test = trainStation.name;
              });
            });
          });
    }
  }

}
