import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:vimigo_assessment/model/attendance.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class MyUserHive extends HiveObject {
  @HiveField(0)
  String themeModeString; // light, dark, system
  @HiveField(1)
  List<Attendance> attendances;
  @HiveField(2)
  bool isTimeAgo;
  @HiveField(3)
  bool isNewUser;
  
  MyUserHive({
    required this.themeModeString,
    required this.attendances,
    required this.isTimeAgo,
    required this.isNewUser,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'themeModeString': themeModeString});
    result.addAll({'attendances': attendances.map((x) => x.toMap()).toList()});
    result.addAll({'isTimeAgo': isTimeAgo});
    result.addAll({'isNewUser': isNewUser});
  
    return result;
  }

  factory MyUserHive.fromMap(Map<String, dynamic> map) {
    return MyUserHive(
      themeModeString: map['themeModeString'] ?? '',
      attendances: List<Attendance>.from(map['attendances']?.map((x) => Attendance.fromMap(x))),
      isTimeAgo: map['isTimeAgo'] ?? false,
      isNewUser: map['isNewUser'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUserHive.fromJson(String source) => MyUserHive.fromMap(json.decode(source));
}
