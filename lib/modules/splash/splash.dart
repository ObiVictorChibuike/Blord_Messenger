import 'dart:async';
import 'package:blord/modules/home/home.dart';
import 'package:blord/modules/onboard/onboard.dart';
import 'package:blord/utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    startTime();
    super.initState();
  }
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));

    // if (auth.currentUser == null) {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
    // } else {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(children: [
          Container(height: 183.h, width: 375.w,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ConstanceData.firstVector),)),),
          SizedBox(height: 54.h),
          Center(
            child: Container(height: 276.h, width: 276.w,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ConstanceData.appImage),)),),
          ),
          Spacer(),
          Container(height: 183.h, width: 375.w,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ConstanceData.secondVector),)),
          ),
        ]),
      ),
    );
  }
}
