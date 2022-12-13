import 'dart:convert';

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));

String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
  Plan({
    this.name,
    this.duration,
    this.routines,
  });

  String? name;
  int? duration;
  List<Routine>? routines;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    name: json["name"],
    duration: json["duration"],
    routines: List<Routine>.from(json["routines"].map((x) => Routine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "duration": duration,
    "routines": List<dynamic>.from(routines!.map((x) => x.toJson())),
  };
}

class Routine {
  Routine({
    this.name,
    this.training,
  });

  String? name;
  String? training;

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
    name: json["name"],
    training: json["training"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "training": training,
  };
}
