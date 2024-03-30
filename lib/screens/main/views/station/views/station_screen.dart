import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/components/components.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel/screens/main/views/station/blocs/station_bloc.dart';

class StationScreen extends StatefulWidget {
  @override
  _StationScreenState createState() => _StationScreenState();
}
class _StationScreenState extends State<StationScreen> {

  final StationBloc _stationBloc = StationBloc();

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
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari stasiun..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(36)
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          BlocBuilder<StationBloc, StationState>(
                  builder: (blocContext, state) {
                return stationListView(state);
          })
        ],
      ),
    );
  }

  Widget stationListView(StationState state) {
    if (state is GetStationListSuccess) {
      return SizedBox(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.trainStation.length,
            itemBuilder: (context, int i) {
              return Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0, left: 16.0, right: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: KaerelColor.green3,
                                      shape: BoxShape.circle),
                                ),
                                Icon(FontAwesomeIcons.train)
                              ],
                            ),
                            const SizedBox(width: 12),
                            Text(
                              state.trainStation[i].name,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.trainStation[i].id,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'DAOP : ${state.trainStation[i].daop}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.outline,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    } else {
      return const Center(
              child: CircularProgressIndicator(),
            );
    }
  }

  Widget createBannerFindStation() {
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Tentukan stasiun keberangkatanmu!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("Click cari stasiun");
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
}
