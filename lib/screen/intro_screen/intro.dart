import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vimigo_assessment/services/controller/controller.dart';
import 'package:vimigo_assessment/widget/custom_button.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Get.theme.primaryColor
        ),
        body: SafeArea(
          child: IntroductionScreen(
            key: _introKey,
            pages: [
              PageViewModel(
                decoration: PageDecoration(bodyFlex: 4, imageFlex: 1, footerFlex: 2, titlePadding: EdgeInsets.zero, imagePadding: EdgeInsets.zero, imageAlignment: Alignment.topCenter),
                image: ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    color: Get.theme.primaryColor,
                    height: 100,
                    child: Container(),
                  ),
                ),
                titleWidget: Icon(Icons.adf_scanner, size: 130, color: Get.theme.primaryColor),
                bodyWidget: Column(
                  children: [
                    Text('Attendance at your fingertips!', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Punch cards are replaced by just tapping on the screen.')
                  ],
                ),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        _introKey.currentState!.next();
                      },
                      child: Text('NEXT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () {
                        _introKey.currentState!.skipToEnd();
                      },
                      child: Text('Skip')
                    )
                  ],
                )
              ),
              PageViewModel(
                decoration: PageDecoration(bodyFlex: 4, imageFlex: 1, footerFlex: 2, titlePadding: EdgeInsets.zero, imagePadding: EdgeInsets.zero, imageAlignment: Alignment.topCenter),
                image: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    color: Get.theme.primaryColor,
                    height: 100,
                    child: Container(),
                  ),
                ),
                titleWidget: Icon(Icons.diversity_3, size: 130, color: Get.theme.primaryColor),
                bodyWidget: Column(
                  children: [
                    Text('Sync all attendees!', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Monitor the movements of your colleagues.')
                  ],
                ),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        _introKey.currentState!.next();
                      },
                      child: Text('NEXT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () {
                        _introKey.currentState!.skipToEnd();
                      },
                      child: Text('Skip')
                    )
                  ],
                )
              ),
              PageViewModel(
                decoration: PageDecoration(bodyFlex: 4, imageFlex: 1, footerFlex: 2, titlePadding: EdgeInsets.zero, imagePadding: EdgeInsets.zero, imageAlignment: Alignment.topCenter),
                image: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    color: Get.theme.primaryColor,
                    height: 100,
                    child: Container(),
                  ),
                ),
                titleWidget: Icon(Icons.send_and_archive, size: 130, color: Get.theme.primaryColor),
                bodyWidget: Column(
                  children: [
                    Text('Share attendance information!', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Fast sharing on all platforms.')
                  ],
                ),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        _introKey.currentState!.next();
                      },
                      child: Text('NEXT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () {
                        _introKey.currentState!.skipToEnd();
                      },
                      child: Text('Skip')
                    )
                  ],
                )
              ),
              PageViewModel(
                decoration: PageDecoration(bodyFlex: 4, imageFlex: 1, footerFlex: 2, titlePadding: EdgeInsets.zero, imagePadding: EdgeInsets.zero, imageAlignment: Alignment.topCenter),
                image: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    color: Get.theme.primaryColor,
                    height: 100,
                    child: Container(),
                  ),
                ),
                titleWidget: Icon(Icons.settings_suggest, size: 130, color: Get.theme.primaryColor),
                bodyWidget: Column(
                  children: [
                    Text('Settings according to your needs!', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Settings that fulfill your wishes.')
                  ],
                ),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        _introKey.currentState!.next();
                      },
                      child: Text('NEXT', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                    TextButton(
                      onPressed: () {
                        _introKey.currentState!.skipToEnd();
                      },
                      child: Text('Skip')
                    )
                  ],
                )
              ),
              PageViewModel(
                decoration: PageDecoration(bodyFlex: 1, imageFlex: 5, footerFlex: 2, titlePadding: EdgeInsets.zero, imagePadding: EdgeInsets.zero, imageAlignment: Alignment.topCenter),
                image: ClipPath(
                  clipper: WaveClipperTwo(flip: true),
                  child: Container(
                    color: Get.theme.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 40),
                        Icon(Icons.rocket_launch, size: 130, color: Colors.white),
                        SizedBox(height: 15),
                        Text('Start the journey!', textAlign: TextAlign.center, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
                      ],
                    ),
                  ),
                ),
                titleWidget: Container(),
                bodyWidget: Container(),
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomButton(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onTap: () {
                        MyController.to.switchNewToOldUser();
                        Get.close(1);
                      },
                      child: Text('LET\'S GO!', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    )
                  ],
                )
              ),
            ],
            showNextButton: false,
            showDoneButton: false,
          ),
        ),
      ),
    );
  }
}