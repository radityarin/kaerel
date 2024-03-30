class Station {
  final String id;
  final String name;
  final int daop;
  final int fgEnable;
  final bool haveSchedule;
  final DateTime updatedAt;
  bool isSelected = false;

  Station({
    required this.id,
    required this.name,
    required this.daop,
    required this.fgEnable,
    required this.haveSchedule,
    required this.updatedAt,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      name: json['name'],
      daop: json['daop'],
      fgEnable: json['fgEnable'],
      haveSchedule: json['haveSchedule'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static Station placeholder() {
    return Station(
      id: '',
      name: '',
      daop: 0,
      fgEnable: 0,
      haveSchedule: false,
      updatedAt: DateTime.now(),
    );
  }

}