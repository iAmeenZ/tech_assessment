import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/screen/profile/edit_profile.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class Profile extends StatefulWidget {
  final Attendance attendance;
  const Profile({super.key, required this.attendance});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late Attendance newAttendance = widget.attendance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          constraints: BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => EditProfile(
                      attendance: newAttendance,
                      callback: (e) {
                        WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                          newAttendance = e;
                        }));
                      },
                    ));
                  },
                  child: Text('Edit', style: TextStyle(color: Get.theme.primaryColor))
                ),
                SizedBox(width: 10)
              ]
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Get.theme.primaryColor,
                        width: 5,
                      ),
                    ),
                    child: Icon(
                      Icons.account_circle,
                      size: 100
                    )
                  )
                ]
              )
            ),

            SizedBox(height: 15),

            Text(newAttendance.user, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 15),
            
            Container(
              color: Get.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, size: 30),
                  SizedBox(width: 10),
                  Text(newAttendance.phone, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ]
              )
            ),

            SizedBox(height: 15),

            CustomButton(
              color: Get.theme.primaryColor,
              borderRadius: 30,
              isShadow: false,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              onTap: () {
                Share.share('Phone: ${newAttendance.phone}', subject: newAttendance.user);
              },
              child: Text('Share Contact', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            )

          ],
        ),
      ),
    );
  }
}