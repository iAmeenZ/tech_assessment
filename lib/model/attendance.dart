import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'attendance.g.dart';

@HiveType(typeId: 1)
class Attendance {
  @HiveField(0)
  String user;
  @HiveField(1)
  String phone;
  @HiveField(2)
  DateTime checkIn;
  
  Attendance({
    required this.user,
    required this.phone,
    required this.checkIn,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'user': user});
    result.addAll({'phone': phone});
    result.addAll({'check-in': checkIn.toIso8601String()});
  
    return result;
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      user: map['user'] ?? '',
      phone: map['phone'] ?? '',
      checkIn: DateTime.parse(map['check-in']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) => Attendance.fromMap(json.decode(source));
}
