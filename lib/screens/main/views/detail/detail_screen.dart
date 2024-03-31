import 'package:flutter/material.dart';
import 'package:kaerel/components/components.dart';
import 'package:kaerel/resources/colors/colors.dart';
import 'package:kaerel_repository/src/models/station_schedule.dart';

class DetailScreen extends StatelessWidget {

  final StationSchedule stationSchedule;

  DetailScreen({required this.stationSchedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KaerelColor.green2,
        title: Text('Detail Page'),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.close), // Close button
          onPressed: () {
            Navigator.pop(context); // Pop the current route off the navigation stack
          },
        ),
      ),
      body: Center(
        child: Text('Detail for Item ${stationSchedule.destination}'),
      ),
    );
  }
}
