import 'package:blord/modules/email_auth/email_login.dart';
import 'package:blord/modules/home/home.dart';
import 'package:blord/utils/theme.dart';
import 'package:blord/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blord/utils/constant.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 200.h, left: 22.w, right: 22.w),
        child: Column(
          children: [
            Image.asset(
              ConstanceData.appImage,
              height: 250.h,
              width: 276.w,
            ),
            SizedBox(height: 120.h),
            PrimaryButton(
              onPressed: () {
                //google signing
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {return Home();
                }), (route) => false);
              },
              btnText: "Continue with Google",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
              },
              btnText: "Continue with Facebook",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) {return EmailLogin();
                }), (route) => false);
              },
              btnText: "Continue with Email",
              color: HexColor("#005CEE"),
            )
          ],
        ),
      ),
    );
  }
}
