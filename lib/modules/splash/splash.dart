import 'package:blord/modules/onboard/onboard.dart';
import 'package:blord/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return Onboarding();
      }), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    var theme = Theme.of(context);
    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Container(
              child: Center(child: Text("Oops! Something went wrong, please restart", style: TextStyle(fontWeight: FontWeight.w500, fontFamily: ConstanceData.robotoFont, fontSize: 18, color: AppTheme.grey),)),);
          }
          if (snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              backgroundColor: theme.backgroundColor,
              body: Container(
                child: Column(children: [
                  Container(
                    height: 183.h,
                    width: 375.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ConstanceData.firstVector),
                        )),
                  ),
                  SizedBox(height: 54.h),
                  Center(
                    child: Container(
                      height: 276.h,
                      width: 276.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ConstanceData.appImage),
                          )),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 183.h,
                    width: 375.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ConstanceData.secondVector),
                        )),
                  ),
                ]),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
