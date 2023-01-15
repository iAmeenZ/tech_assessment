import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vimigo_assessment/constants/constants.dart';
import 'package:vimigo_assessment/constants/custom_icon_icons.dart';
import 'package:vimigo_assessment/constants/theme_mode.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/screen/home/add_attendance.dart';
import 'package:vimigo_assessment/screen/home/attendance_list.dart';
import 'package:vimigo_assessment/screen/home/dialog_theme.dart';
import 'package:vimigo_assessment/screen/intro_screen/intro.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  void showIntroScreen() async {
    await Future.delayed(Duration.zero);
    if (MyController.to.myUserHive.value.isNewUser) {
      Get.to(() => IntroScreen());
    }
  }

  @override
  void initState() {
    showIntroScreen();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isHome = true;
  String? search;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('My Attendances'),
        actions: [
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: IconButton(
              onPressed: () {
                animateRotationIcon();
                MyController.to.syncAttendance();
              },
              tooltip: 'Sync Attendance',
              icon: Icon(Icons.sync)
            )
          )
        ],
      ),
      floatingActionButton: isHome ? FloatingActionButton(
        onPressed: () {
          Get.to(() => AddAttendance());
        },
        child: Icon(Icons.add),
      ) : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    borderRadius: 5,
                    shadowRadius: 1,
                    color: isHome ? Get.theme.primaryColor : Get.theme.scaffoldBackgroundColor,
                    onTap: () {
                      setState(() {
                        isHome = true;
                      });
                    },
                    child: Text('Home', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isHome ? Colors.white : Colors.grey.shade600))
                  ),
                  CustomButton(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    shadowRadius: 1,
                    borderRadius: 5,
                    color: isHome ? Get.theme.scaffoldBackgroundColor : Get.theme.primaryColor,
                    onTap: () {
                      setState(() {
                        isHome = false;
                      });
                    },
                    child: Text('Settings', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: isHome ? Colors.grey.shade600 : Colors.white))
                  ),
                ],
              ),
              SizedBox(height: 10),

              if (isHome)...[
                Center(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Get.theme.colorScheme.background,
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                        hintText: 'Search Attendance',
                        hintStyle: TextStyle(fontSize: 15, color: Get.isDarkMode ? Colors.white : Colors.grey),
                        suffixIcon: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(CustomIcons.search_1, color: Colors.grey.shade400, size: 18)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 2,
                            color: Get.theme.primaryColor,
                            style: BorderStyle.solid,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 2,
                            color: Get.theme.primaryColor,
                            style: BorderStyle.solid,
                          )
                        )
                      ),
                      onChanged: (val) {
                        if (val.isEmpty) {
                          search = null;
                        } else {
                          search = val;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                GetBuilder<MyController>(
                  id: GetConst.syncAttendancesBuilder,
                  builder: (myController) {
                    List<Attendance> attendances = myController.myUserHive.value.attendances.toList();
                    if (search != null) {
                      List<Attendance> newList = [];
                      for (var e in attendances) {
                        String combined = '${e.user.toLowerCase()} ${e.phone.toLowerCase()}';
                        if (combined.contains(search!.toLowerCase())) {
                          newList.add(e);
                        }
                      }
                      attendances = newList.toList();
                    }
                    attendances.sort((a, b) => b.checkIn.compareTo(a.checkIn));
                    return AttendanceList(
                      attendances: attendances,
                      isTimeAgo: myController.myUserHive.value.isTimeAgo,
                    );
                  }
                )
              ] else...[
                GetBuilder<MyController>(
                  id: GetConst.switchTimeFormat,
                  builder: (myController) {
                    return ListTile(
                      onTap: () {
                        MyController.to.switchTimeFormat();
                      },
                      leading: Icon(Icons.timelapse, size: 40),
                      title: Text('Time Format'),
                      subtitle: Text(myController.myUserHive.value.isTimeAgo ? 'Time Ago' : 'dd MMM yyyy, h:mm a'),
                      trailing: Switch.adaptive(
                        value: myController.myUserHive.value.isTimeAgo,
                        activeColor: Get.theme.primaryColor,
                        onChanged: (newValue) {
                          MyController.to.switchTimeFormat();
                        }
                      )
                    );
                  }
                ),
                GetBuilder<MyController>(
                  id: GetConst.changeThemeMode,
                  builder: (myController) {
                    return ListTile(
                      onTap: () {
                        Get.dialog(DialogThemeSetting());
                      },
                      leading: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode, size: 40),
                      title: Text('Theme Mode'),
                      subtitle: Text(themeModeString()),
                      trailing: Icon(Icons.arrow_forward_ios)
                    );
                  }
                ),
              ]
      
            ]
          )
        ),
      )
    );
  }

  void animateRotationIcon() async {
    _controller.forward();
    await Future.delayed(Duration(seconds: 1));
    _controller.reset();
  }

}