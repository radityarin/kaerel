import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/utils/utils.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

import '../../../../../components/components.dart';
import '../../../../../resources/colors/colors.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<Station> stationList;
  final List<StationSchedule> scheduleList;
  final bool isOrigin;
  final Function(Station) onSelect;

  BottomSheetWidget(
      {required this.stationList,
      required this.scheduleList,
      required this.isOrigin,
      required this.onSelect});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();

  void resetSelectedStationList() {
    if (isOrigin) {
      for (var trainStation in stationList) {
        trainStation.isSelected = false;
      }
    } else {
      for (var schedule in scheduleList) {
        schedule.isSelected = false;
      }
    }
  }
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<Station> filteredStations = List.empty(growable: true);
  List<StationSchedule> filteredStationsSchedule = List.empty(growable: true);
  TextEditingController searchController = TextEditingController();
  bool isStationSelected = false;
  Station selectedTrainStation = Station.placeholder();
  StationSchedule selectedTrainStationSchedule = StationSchedule.placeholder();
  String questionPlaceholder = '';

  @override
  void initState() {
    widget.resetSelectedStationList();
    filteredStations = widget.stationList;
    filteredStationsSchedule = widget.scheduleList;
    searchController.addListener(filterStations);
    questionPlaceholder = widget.isOrigin
        ? 'Mau berangkat dari stasiun mana?'
        : 'Mau ke stasiun mana?';
    super.initState();
  }

  void filterStations() {
    String query = searchController.text.toLowerCase();
    if (widget.isOrigin) {
      setState(() {
        filteredStations = widget.stationList
            .where((station) =>
                station.name.toLowerCase().contains(query) ||
                station.id.toLowerCase().contains(query))
            .toList();
      });
    } else {
      setState(() {
        filteredStationsSchedule = widget.scheduleList
            .where((station) =>
                station.destination.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          textAlign: TextAlign.start,
          questionPlaceholder,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      Container(
        height: 80,
        padding: const EdgeInsets.all(16),
        child: TextField(
          cursorColor: Colors.black,
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: KaerelColor.greyBorder,
            focusColor: Colors.black,
            labelText: 'Ketik stasiunmu disini..',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear_rounded),
              onPressed: () {
                searchController.clear();
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding: EdgeInsets.all(4.0),
          ),
        ),
      ),
      customDivider(4),
      showStationList(),
      customDivider(8),
      Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: mainButton("Pilih aku", isStationSelected, () {
                    widget.onSelect(selectedTrainStation);
                    Navigator.pop(context);
                  })),
              customDivider(32)
            ],
          ))
    ]);
  }

  void checkIsSelected() {
    for (var trainStation in filteredStations) {
      isStationSelected = trainStation.isSelected;
    }
  }

  Widget showStationList() {
    if (widget.isOrigin) {
      return AnimatedContainer(
        height: 300,
        duration: const Duration(milliseconds: 150),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredStations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.resetSelectedStationList();
                    filteredStations[index].isSelected = true;
                    selectedTrainStation = filteredStations[index];
                    isStationSelected = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: filteredStations[index].isSelected
                              ? KaerelColor.greenBorder
                              : KaerelColor.greyBorder),
                      color: filteredStations[index].isSelected
                          ? KaerelColor.green4
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12)
                      ),
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
                                Icon(
                                  FontAwesomeIcons.train,
                                  color: KaerelColor.green2,
                                )
                              ],
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeFirstLetter(
                                      filteredStations[index].name),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: KaerelColor.greyBorder),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    filteredStations[index].id,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  filteredStations[index].haveSchedule
                                      ? 'Jadwal\nTersedia'
                                      : 'Jadwal\nTidak Tersedia',
                                  style: TextStyle(
                                      color:
                                          filteredStations[index].haveSchedule
                                              ? KaerelColor.green1
                                              : Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  filteredStations[index].haveSchedule
                                      ? 'assets/check.png'
                                      : 'assets/close.png',
                                  scale: 3,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return AnimatedContainer(
        height: 300,
        duration: const Duration(milliseconds: 150),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredStationsSchedule.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.resetSelectedStationList();
                    filteredStationsSchedule[index].isSelected = true;
                    selectedTrainStationSchedule = filteredStationsSchedule[index];
                    isStationSelected = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: filteredStationsSchedule[index].isSelected
                              ? KaerelColor.greenBorder
                              : KaerelColor.greyBorder),
                      color: filteredStationsSchedule[index].isSelected
                          ? KaerelColor.green4
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12)
                      ),
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
                                Icon(
                                  FontAwesomeIcons.train,
                                  color: KaerelColor.green2,
                                )
                              ],
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeFirstLetter(
                                      filteredStationsSchedule[index].destination),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: KaerelColor.greyBorder),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    filteredStationsSchedule[index].route,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  filteredStationsSchedule[index].listSchedule.isNotEmpty
                                      ? 'Jadwal\nTersedia'
                                      : 'Jadwal\nTidak Tersedia',
                                  style: TextStyle(
                                      color:
                                          filteredStationsSchedule[index].listSchedule.isNotEmpty
                                              ? KaerelColor.green1
                                              : Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  filteredStationsSchedule[index].listSchedule.isNotEmpty
                                      ? 'assets/check.png'
                                      : 'assets/close.png',
                                  scale: 3,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
