

import 'package:kaerel_repository/kaerel_repository.dart';

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
}

List<StationSchedule> groupSchedulesByDestination(List<Schedule> schedules) {
  Map<String, List<Schedule>> scheduleMap = {};
  for (Schedule schedule in schedules) {
    if (!scheduleMap.containsKey(schedule.destination)) {
      scheduleMap[schedule.destination] = [];
    }
    scheduleMap[schedule.destination]!.add(schedule);
  }

  List<StationSchedule> stationSchedules = [];
  scheduleMap.forEach((destination, listSchedule) {
    stationSchedules.add(StationSchedule(
      destination: destination,
      route: listSchedule[0].route,
      line: listSchedule[0].line,
      color: listSchedule[0].color,
      listSchedule: listSchedule,
    ));
  });

  stationSchedules.sort((a, b) => a.getUpcomingScheduleTimeRemaining().compareTo(b.getUpcomingScheduleTimeRemaining()));

  return stationSchedules;
}

String getRemainingTimeUntilString(String targetTime) {
  if (targetTime.isEmpty) {
    return 'belum ada estimasi';
  } else {
    int? remainingMinutes = getRemainingTimeUntil(targetTime);
    return 'dalam $remainingMinutes menit';
  }
}

int getRemainingTimeUntil(String targetTime) {
  if (targetTime.isEmpty) {
    return -100;
  } else {
    DateTime currentTime = DateTime.now();
    List<String> timeParts = targetTime.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    int seconds = int.parse(timeParts[2]);
    DateTime targetDateTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      hours,
      minutes,
      seconds,
    );
    int remainingMinutes = targetDateTime.difference(currentTime).inMinutes + 1;
    return remainingMinutes;
  }
}

List<Schedule> sortToNextUpcomingSchedules(List<Schedule> schedules) {
  DateTime now = DateTime.now();
  DateTime currentDate = DateTime(now.year, now.month, now.day);

  List<Schedule> upcomingSchedules = schedules.where((schedule) {
    List<String> parts = schedule.timeEstimated.split(':');
    DateTime estimatedTime = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );

    return estimatedTime.isAfter(now);
  }).toList();

  upcomingSchedules.sort((a, b) {
    List<String> partsA = a.timeEstimated.split(':');
    List<String> partsB = b.timeEstimated.split(':');
    DateTime timeA = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(partsA[0]),
      int.parse(partsA[1]),
      int.parse(partsA[2]),
    );
    DateTime timeB = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      int.parse(partsB[0]),
      int.parse(partsB[1]),
      int.parse(partsB[2]),
    );

    return timeA.compareTo(timeB);
  });

  return upcomingSchedules;
}

String extractTime(String timeString) {
  List<String> parts = timeString.split(':');
  if (parts.length >= 2) {
    return '${parts[0]}:${parts[1]}';
  } else {
    // Handle invalid input
    return '-';
  }
}

List<Schedule> sortSchedules(List<Schedule> schedules) {
  schedules.sort((a, b) {
    List<String> partsA = a.timeEstimated.split(':');
    List<String> partsB = b.timeEstimated.split(':');
    DateTime timeA =
        DateTime(2000, 1, 1, int.parse(partsA[0]), int.parse(partsA[1]));
    DateTime timeB =
        DateTime(2000, 1, 1, int.parse(partsB[0]), int.parse(partsB[1]));

    return timeA.compareTo(timeB);
  });

  return schedules;
}

List<Schedule> filterPassedSchedules(List<Schedule> schedules) {
  // Get the current time
  DateTime currentTime = DateTime.now();

  // Filter schedules where timeEstimated has not passed the current time
  List<Schedule> filteredSchedules = schedules.where((schedule) {
    // Parse timeEstimated to DateTime object
    DateTime estimatedTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      int.parse(schedule.timeEstimated.split(':')[0]), // Hour
      int.parse(schedule.timeEstimated.split(':')[1]), // Minute
      int.parse(schedule.timeEstimated.split(':')[2]), // Second
    );

    // Compare estimatedTime with current time
    return estimatedTime.isAfter(currentTime);
  }).toList();

  return filteredSchedules;
}
