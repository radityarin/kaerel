import 'package:kaerel_repository/src/models/schedule.dart';

class StationSchedule {
  final String destination;
  final String route;
  final String line;
  final String color;
  final Schedule upcomingSchedules;
  final List<Schedule> listSchedule;

  StationSchedule({
    required this.destination,
    required this.route,
    required this.line,
    required this.color,
    required this.upcomingSchedules,
    required this.listSchedule,
  });

  static StationSchedule placeholder() {
    return StationSchedule(
      destination: '',
      route: '',
      line: '',
      color: '',
      upcomingSchedules: Schedule.empty(),
      listSchedule: List.empty(growable: true)
    );
  }
  
}