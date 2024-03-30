class Schedule {
  final String id;
  final String stationId;
  final String trainId;
  final String line;
  final String route;
  final String color;
  final String destination;
  final String timeEstimated;
  final String destinationTime;
  final String updatedAt;

  Schedule({
    required this.id,
    required this.stationId,
    required this.trainId,
    required this.line,
    required this.route,
    required this.color,
    required this.destination,
    required this.timeEstimated,
    required this.destinationTime,
    required this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? '',
      stationId: json['stationId'] ?? '',
      trainId: json['trainId'] ?? '',
      line: json['line'] ?? '',
      route: json['route'] ?? '',
      color: json['color'] ?? '',
      destination: json['destination'] ?? '',
      timeEstimated: json['timeEstimated'] ?? '',
      destinationTime: json['destinationTime'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  factory Schedule.empty() {
    return Schedule(
      id: '',
      stationId: '',
      trainId: '',
      line: '',
      route: '',
      color: '',
      destination: '',
      timeEstimated: '',
      destinationTime: '',
      updatedAt: ''
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Schedule && other.destination == destination;
  }

  @override
  int get hashCode => destination.hashCode;
}
