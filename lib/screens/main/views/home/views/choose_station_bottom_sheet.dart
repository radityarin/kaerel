import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kaerel/utils/utils.dart';
import 'package:kaerel_repository/kaerel_repository.dart';

import '../../../../../components/components.dart';
import '../../../../../resources/colors/colors.dart';

class BottomSheetWidget extends StatefulWidget {
  final List<TrainStation> stationList;
  final Function(TrainStation) onSelect;

  BottomSheetWidget({required this.stationList, required this.onSelect});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();

  void resetSelectedStationList() {
    for (var trainStation in stationList) {
      trainStation.isSelected = false;
    }
  }
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  ScrollController _controller = ScrollController();
  double _listViewHeight = 400;
  bool isStationSelected = false;
  TrainStation selectedTrainStation = TrainStation.placeholder();

  @override
  void initState() {
    widget.resetSelectedStationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          textAlign: TextAlign.start,
          'Mau berangkat dari stasiun apa?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      Container(
        height: 92,
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Ketik stasiunmu disini..',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
      customDivider(8),
      AnimatedContainer(
        height: _listViewHeight,
        duration: const Duration(milliseconds: 150),
        child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: widget.stationList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.resetSelectedStationList();
                    widget.stationList[index].isSelected = true;
                    selectedTrainStation = widget.stationList[index];
                    isStationSelected = true;
                    // _listViewHeight = 300;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.stationList[index].isSelected
                              ? KaerelColor.greenBorder
                              : KaerelColor.greyBorder),
                      color: widget.stationList[index].isSelected
                          ? KaerelColor.green4
                          : Colors.white,
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
                                      widget.stationList[index].name),
                                  style: TextStyle(
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
                                    widget.stationList[index].id,
                                    style: TextStyle(
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
                                  widget.stationList[index].haveSchedule
                                      ? 'Schedule\nAvailable'
                                      : 'Schedule\nNot Available',
                                  style: TextStyle(
                                      color:
                                          widget.stationList[index].haveSchedule
                                              ? KaerelColor.green1
                                              : Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                SizedBox(width: 8),
                                Image.asset(
                                  widget.stationList[index].haveSchedule
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
      ),
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
    for (var trainStation in widget.stationList) {
      isStationSelected = trainStation.isSelected;
    }
  }
}
