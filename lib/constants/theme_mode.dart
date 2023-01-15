import 'package:flutter/material.dart';
import 'package:vimigo_assessment/model/user.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';

ThemeMode currentThemeMode() {
  MyUserHive myUserHive = MyController.to.myUserHive.value;
  if (myUserHive.themeModeString == 'light') {
    return ThemeMode.light;
  } else if (myUserHive.themeModeString == 'dark') {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

String themeModeString() {
  MyUserHive myUserHive = MyController.to.myUserHive.value;
  if (myUserHive.themeModeString == 'light') {
    return 'Light Mode';
  } else if (myUserHive.themeModeString == 'dark') {
    return 'Dark Mode';
  } else {
    return 'System Default';
  }
}