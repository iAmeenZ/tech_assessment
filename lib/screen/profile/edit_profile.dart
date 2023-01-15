import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vimigo_assessment/constants/custom_icon_icons.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class EditProfile extends StatefulWidget {
  final Attendance attendance;
  final Function(Attendance) callback;
  const EditProfile({super.key, required this.attendance, required this.callback});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  late Attendance newAttendance = Attendance(user: widget.attendance.user, phone: widget.attendance.phone, checkIn: widget.attendance.checkIn);

  @override
  void dispose() {
    super.dispose();
    widget.callback(newAttendance);
  }
  
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

            SizedBox(height: 48),
            
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Get.theme.primaryColor,
                    width: 5,
                  ),
                ),
                child: Icon(Icons.account_circle, size: 100),
              ),
            ),

            SizedBox(height: 15),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('User', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  TextFormField(
                    initialValue: newAttendance.user,
                    onChanged: (val) {
                      newAttendance.user = val;
                    },
                  ),

                  SizedBox(height: 20),

                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('Phone', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  TextFormField(
                    initialValue: newAttendance.phone,
                    onChanged: (val) {
                      newAttendance.phone = val;
                    },
                  ),

                  SizedBox(height: 20),

                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('Check-In', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                  Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Row(
                    children: [
                      Text(DateFormat('dd MMM yyyy, h:mm a').format(newAttendance.checkIn), style: TextStyle(fontWeight: FontWeight.bold)),
                      CustomButton(
                        color: Colors.grey.shade700,
                        isShadow: false,
                        borderRadius: 5,
                        onTap: () {
                          setState(() {
                            newAttendance.checkIn = DateTime.now();
                          });
                        },
                        child: Text('Check-In', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                      )
                    ],
                  )),

                  SizedBox(height: 30),

                  CustomButton(
                    color: Get.theme.primaryColor,
                    borderRadius: 30,
                    isShadow: false,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.zero,
                    onTap: () {
                      MyController.to.editProfile(attendance: newAttendance);
                      Get.close(1);
                    },
                    child: Text('SAVE CHANGES', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  )
                ]
              )
            ),

            

          ],
        ),
      ),
    );
  }

}