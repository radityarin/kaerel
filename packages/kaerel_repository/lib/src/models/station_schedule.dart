import 'package:kaerel_repository/src/models/schedule.dart';
import 'package:kaerel_utils/kaerel_utils.dart';


class StationSchedule {
  final String destination;
  final String route;
  final String line;
  final String color;
  final List<Schedule> listSchedule;
  bool isSelected = false;

  StationSchedule({
    required this.destination,
    required this.route,
    required this.line,
    required this.color,
    required this.listSchedule,
  });

  List<Schedule> getNextUpcomingSchedules() {
    return sortToNextUpcomingSchedules(listSchedule);
  }

  Schedule getUpcomingSchedule() {
    return listSchedule.isNotEmpty ? getNextUpcomingSchedules()[0] : Schedule.empty();
  }

  String getUpcomingScheduleTimeEstimated() {
    return extractTime(getUpcomingSchedule().timeEstimated);
  }

  String getUpcomingScheduleTimeRemainingString() {
    return getRemainingTimeUntilString(getUpcomingSchedule().timeEstimated);
  }

  int getUpcomingScheduleTimeRemaining() {
    return getRemainingTimeUntil(getUpcomingSchedule().timeEstimated);
  }

  static StationSchedule placeholder() {
    return StationSchedule(
      destination: '',
      route: '',
      line: '',
      color: '',
      listSchedule: List.empty(growable: true)
    );
  }
  
}