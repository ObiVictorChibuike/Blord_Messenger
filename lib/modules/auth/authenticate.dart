import 'package:blord/helpers/progress_dialog_helper.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/modules/email_auth/email_login.dart';
import 'package:blord/modules/home/home.dart';
import 'package:blord/services/auth_services.dart';
import 'package:blord/helpers/database_helper.dart';
import 'package:blord/utils/theme.dart';
import 'package:blord/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                CustomProgressDialog().showCustomAlertDialog(context, "Please wait...");
                AuthClass().signWithGoogle().then((UserCredential? value) {
                  CustomProgressDialog().popCustomProgressDialogDialog(context);
                  if (value != null){
                    final result = value.user;
                    SharedPreferenceHelper().saveUserEmail(result!.email!);
                    SharedPreferenceHelper().saveUserId(result.uid);
                    SharedPreferenceHelper().saveUserName(result.email!.replaceAll("@gmail.com", ""));
                    SharedPreferenceHelper().saveDisplayName(result.displayName!);
                    SharedPreferenceHelper().saveUserProfileUrl(result.photoURL!);
                    Map <String, dynamic> userInfoMap = {
                    "userId": value.user!.uid,
                      "email": result.email!,
                      "username": result.email!.replaceAll("@gmail.com", ""),
                      "name": result.displayName!,
                      "photoUrl": result.photoURL!,
                      "phoneNumber": result.phoneNumber,
                    };
                    DataBaseHelper().addUserInfoToDB(result.uid, userInfoMap).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                    });
                  }
                  final displayName = value!.user!.displayName;
                  print(displayName);
                });
              },
              btnImage: Image.asset(ConstanceData.google),
              btnText: "Continue with Google",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
              },
              btnImage: Image.asset(ConstanceData.facebook),
              btnText: "Continue with Facebook",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
                Navigator.push(context, MaterialPageRoute(builder: (_) => EmailLogin()));
              },
              btnImage: Image.asset(ConstanceData.email),
              btnText: "Continue with Email",
              color: HexColor("#005CEE"),
            )
          ],
        ),
      ),
    );
  }
}
