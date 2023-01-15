import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vimigo_assessment/constants/custom_icon_icons.dart';
import 'package:vimigo_assessment/model/attendance.dart';
import 'package:vimigo_assessment/screen/profile/edit_profile.dart';
import 'package:vimigo_assessment/screen/profile/profile.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class AttendanceList extends StatelessWidget {
  final List<Attendance> attendances;
  final bool isTimeAgo;
  const AttendanceList({super.key, required this.attendances, required this.isTimeAgo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (attendances.isEmpty)...[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
            child: Column(
              children: [
                Icon(Icons.self_improvement, color: Colors.grey, size: 130),
                Text('No result', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey))
              ],
            ),
          ),
        ] else...[
          Column(
            children: attendances.map((e) => Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    icon: CustomIcons.pencil_1,
                    foregroundColor: Colors.white,
                    backgroundColor: Get.theme.primaryColorLight,
                    onPressed: (context) {
                      Get.to(() => EditProfile(attendance: e, callback: (_) {}));
                    }
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: 2,
                    color: Get.theme.primaryColorLight,
                    child: Container(
                      color: Get.theme.primaryColorDark.withOpacity(0.2),
                    ),
                  ),
                  SlidableAction(
                    icon: CustomIcons.trash,
                    foregroundColor: Colors.white,
                    backgroundColor: Get.theme.primaryColorLight,
                    onPressed: (context) {
                      Get.dialog(Dialog(
                        child: SizedBox(
                          height: 130,
                          child: Column(
                            children: [
                              Container(padding: EdgeInsets.fromLTRB(40, 25, 40, 15), child: Text('Are you sure you want to delete this attendance?', textAlign: TextAlign.center, style: GoogleFonts.inter())),
                              Divider(height: 0, color: Colors.grey),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        height: double.infinity,
                                        borderRadius: 0,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        isShadow: false,
                                        color: Colors.transparent,
                                        onTap: () {
                                          MyController.to.deleteAttendance(attendance: e);
                                        },
                                        child: Center(child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.red)))
                                      ),
                                    ),
                                    VerticalDivider(color: Colors.grey, width: 0),
                                    Expanded(
                                      child: CustomButton(
                                        height: double.infinity,
                                        borderRadius: 0,
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        isShadow: false,
                                        color: Colors.transparent,
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Center(child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.ubuntu(color: Colors.green)))
                                      ),
                                    )
                                  ]
                                ),
                              )
                            ]
                          )
                        )
                      ));
                    }
                  )
                ]
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                leading: Icon(Icons.account_circle, size: 40),
                title: Row(
                  children: [
                    Flexible(child: Text(e.user, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold))),
                    // if (e.isFavorite)...[
                    //   SizedBox(width: 5),
                    //   Icon(Icons.star, color: Colors.yellow.shade700, size: 20)
                    // ]
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.phone, style: TextStyle(color: Colors.grey.shade700)),
                    SizedBox(height: 7),
                    Text(isTimeAgo ? timeago.format(e.checkIn) : DateFormat('dd MMM yyyy, h:mm a').format(e.checkIn), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(CustomIcons.paper_plane_empty, color: Get.theme.primaryColor),
                  onPressed: () {
                    Share.share('Phone: ${e.phone}', subject: e.user);
                  },
                ),
                focusColor: Get.theme.primaryColorLight,
                splashColor: Get.theme.primaryColorLight,
                onTap: () {
                  Get.to(() => Profile(attendance: e));
                }
              ),
            )).toList()
          ),
          SizedBox(height: 20),
          Icon(Icons.check_circle, color: Colors.grey),
          SizedBox(height: 5),
          Text('You have reached the end of the list', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          SizedBox(height: 50),
        ]
      ],
    );
  }
}