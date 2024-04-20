import 'package:flutter/material.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel_repository/kaerel_repository.dart';
import 'package:kaerel_repository/src/models/station_schedule.dart';
import 'package:kaerel_utils/kaerel_utils.dart';

class DetailScreen extends StatelessWidget {
  final StationSchedule stationSchedule;
  List<Schedule> listSchedule = List.empty(growable: true);

  DetailScreen({required this.stationSchedule});

  @override
  Widget build(BuildContext context) {
    listSchedule.clear();
    listSchedule.addAll(filterPassedSchedules(stationSchedule.listSchedule));
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          'Tujuan ${stationSchedule.destination}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ), // Close button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listSchedule.length,
                  itemBuilder: (context, int i) {
                    Schedule schedule = listSchedule[i];
                    String upcomingTimeEstimated =
                        extractTime(schedule.timeEstimated);
                    String upcomingRemainingTime =
                        getRemainingTimeUntilString(schedule.timeEstimated);
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16.0, left: 16.0, right: 16.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: KaerelColor.greyBorder),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  upcomingTimeEstimated,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  upcomingRemainingTime,
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/alarm.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    Text("Ingatkan!"),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
