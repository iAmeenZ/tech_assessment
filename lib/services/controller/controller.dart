import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vimigo_assessment/constants/constants.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/model/response.dart';
import 'package:vimigo_assessment/model/user.dart';
import 'package:vimigo_assessment/services/http/request.dart';
import 'package:vimigo_assessment/widget/dialog/dialog_error.dart';

class MyController extends GetxController {

  static MyController get to => Get.find();

  late Rx<MyUserHive> myUserHive = Hive.box<MyUserHive>('user').get(0)!.obs; // initialize in initHive()

  // INIT AT VOID MAIN FOR LOCAL STORAGE
  Future<bool> initHiveAndGetX() async {
    try {
      Get.put(MyController());
      
      Hive
        ..registerAdapter(MyUserHiveAdapter())
        ..registerAdapter(AttendanceAdapter());

      Box<MyUserHive> box = await Hive.openBox<MyUserHive>('user');
      // FIRST INSTALL
      if (box.get(0) == null) {
        myUserHive = MyUserHive(
          themeModeString: 'light',
          attendances: [],
          isTimeAgo: true,
          isNewUser: true
        ).obs;
        await box.put(0,  myUserHive.value);
        return true;
      } else {
        myUserHive = Hive.box<MyUserHive>('user').get(0)!.obs;
        return false;
      }
    } catch (e) {
      debugPrint('ERROR initHiveAndGetX() : $e');
      return true;
    }
  }

  void switchNewToOldUser() {
    try {
      myUserHive.value
        ..isNewUser = false
        ..save();
    } catch (_) {}
  }

  void switchTimeFormat() {
    try {
      myUserHive.value
        ..isTimeAgo = !myUserHive.value.isTimeAgo
        ..save();
    } catch (_) {}
    update([GetConst.switchTimeFormat]);
  }

  void deleteAttendance({
    required Attendance attendance,
  }) {
    try {
      myUserHive.value
        ..attendances.removeWhere((e) => e.phone == attendance.phone)
        ..save();
      Get
        ..back()
        ..closeAllSnackbars()
        ..snackbar(attendance.user, 'has been deleted!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
    } catch (_) {}
    update([GetConst.syncAttendancesBuilder]);
  }

  void addAttendance({
    required Attendance newAttendance,
  }) {
    try {
      myUserHive.value
        ..attendances.add(newAttendance)
        ..save();
      Get
        ..closeAllSnackbars()
        ..snackbar(newAttendance.user, 'has been added!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
    } catch (_) {}
    update([GetConst.syncAttendancesBuilder]);
  }

  void editProfile({
    required Attendance attendance,
  }) {
    try {
      int index = myUserHive.value.attendances.indexWhere((e) => e.phone == attendance.phone);
      if (index != -1) {
        myUserHive.value
          ..attendances[index] = attendance
          ..save();
        Get
          ..closeAllSnackbars()
          ..snackbar(attendance.user, 'has been updated!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
      }
    } catch (_) {}
    update([GetConst.syncAttendancesBuilder]);
  }

  Future<void> syncAttendance() async {
    try {
      ResponseOrError response = await HttpRequest.getResponse();
      if (response.response != null) {
        myUserHive.value
          ..attendances = response.response!.data!.toList()
          ..save();
        Get
          ..closeAllSnackbars()
          ..snackbar('Attendances', 'Synced!', snackPosition: SnackPosition.BOTTOM, icon: Icon(Icons.check_circle, color: Colors.green));
        update([GetConst.syncAttendancesBuilder]);
      } else {
        Get.dialog(ErrorDialog(icon: Icons.warning, text1: 'Unable to sync attendances', text2: response.anyError!));
      }
    } catch (e) {
      debugPrint('ERROR syncAttendance() : $e');
      Get.dialog(ErrorDialog(icon: Icons.warning, text1: 'Unable to sync attendances', text2: e.toString()));
    }
  }

  void changeThemeMode({
    required ThemeMode themeMode
  }) {
    Get.changeThemeMode(themeMode);
    myUserHive.value
      ..themeModeString = themeMode.name
      ..save();
    update([GetConst.changeThemeMode]);
  }
}