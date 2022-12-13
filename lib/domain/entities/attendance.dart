// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Attendance> AttendanceFromJson(String str) => List<Attendance>.from(json.decode(str).map((x) => Attendance.fromJson(x)));

String AttendanceToJson(List<Attendance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attendance {
  Attendance({
    this.entryDate,
    this.customer,
  });

  DateTime? entryDate;
  CustomerAttendance? customer;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    entryDate: DateTime.parse(json["entryDate"]),
    customer: CustomerAttendance.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "entryDate": entryDate?.toIso8601String(),
    "customer": customer?.toJson(),
  };
}

class CustomerAttendance {
  CustomerAttendance({
    this.names = "",
    this.surnames = "",
  });

  String names;
  String surnames;

  factory CustomerAttendance.fromJson(Map<String, dynamic> json) => CustomerAttendance(
    names: json["names"],
    surnames: json["surnames"],
  );

  Map<String, dynamic> toJson() => {
    "names": names,
    "surnames": surnames,
  };
}