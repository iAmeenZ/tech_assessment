import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vimigo_assessment/constants/custom_icon_icons.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class AddAttendance extends StatefulWidget {
  const AddAttendance({super.key});

  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {

  Attendance newAttendance = Attendance(user: '', phone: '', checkIn: DateTime.now());
  final _formKey = GlobalKey<FormState>();

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
        title: Text('New Attendance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 48),
            
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
              child: Icon(Icons.account_circle, size: 100),
            ),

            SizedBox(height: 15),

            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('User', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                    TextFormField(
                      validator: (value) => value != null && value != '' ? null : 'Please insert user name',
                      decoration: InputDecoration(
                        hintText: 'User name..'
                      ),
                      onChanged: (val) {
                        newAttendance.user = val;
                      },
                    ),
            
                    SizedBox(height: 20),
            
                    Container(margin: EdgeInsets.only(left: 20, bottom: 5), child: Text('Phone', style: TextStyle(fontSize: 13, color: Get.theme.primaryColor))),
                    TextFormField(
                      validator: (value) => value != null && value != '' ? null : 'Please insert phone number',
                      decoration: InputDecoration(
                        hintText: 'Phone number..'
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        newAttendance.phone = val;
                      },
                    ),
            
                    SizedBox(height: 30),
            
                    CustomButton(
                      color: Get.theme.primaryColor,
                      borderRadius: 30,
                      isShadow: false,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.zero,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          MyController.to.addAttendance(newAttendance: newAttendance);
                          Get.close(1);
                        }
                      },
                      child: Text('SUBMIT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    )
                  ]
                )
              ),
            ),

            

          ],
        ),
      ),
    );
  }

}