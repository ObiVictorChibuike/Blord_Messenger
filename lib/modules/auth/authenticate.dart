
import 'package:blord/api/firebase_api.dart';
import 'package:blord/helpers/flush_bar_helper.dart';
import 'package:blord/helpers/progress_dialog_helper.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/models/user.dart';
import 'package:blord/modules/email_auth/email_login.dart';
import 'package:blord/modules/home/home.dart';
import 'package:blord/services/auth_services.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:blord/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blord/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  String dummyImage = "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png";

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
                _signInWithGoogle();
              },
              btnImage: Image.asset(ConstanceData.google, height: 30, width: 30,),
              btnText: "Continue with Google",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
              },
              btnImage: Image.asset(ConstanceData.facebook, height: 30, width: 30,),
              btnText: "Continue with Facebook",
              color: HexColor("#005CEE"),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                //google signing
                Navigator.push(context, MaterialPageRoute(builder: (_) => EmailLogin()));
              },
              btnImage: Image.asset(ConstanceData.email, height: 30, width: 30,),
              btnText: "Continue with Email",
              color: HexColor("#005CEE"),
            )
          ],
        ),
      ),
    );
  }

  _signInWithGoogle(){
    CustomProgressDialog().showDialog(context, "Signing In...");
    AuthClass().signWithGoogle().then((UserCredential? value) async {
      if (value != null){
        final result = value.user;
        AuthUser user = AuthUser(
            idUser: result!.uid,
            email: result.email!,
            username: result.email!.replaceAll("@gmail.com", ""),
            phoneNumber: result.phoneNumber ?? null,
            name: result.displayName ?? null,
            urlAvatar: result.photoURL ?? dummyImage,
          lastMessageTime: Utils.getFormattedTimeDate(DateTime.now()),
        );
        await FirebaseApi.addUser(user).whenComplete(() {
          sharedPreferenceHelper.saveUserData(user: user).whenComplete(() {
            CustomProgressDialog().hideDialog(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
          });
        }).onError((error, stackTrace) {
          CustomProgressDialog().hideDialog(context);
          alertBar(context, "Oops! an error occurred, please try again", AppTheme.red);
        });
      }
    }).onError((error, stackTrace) {
      CustomProgressDialog().hideDialog(context);
      alertBar(context, "Oops! an error occurred, please try again", AppTheme.red);
    });
  }
}
