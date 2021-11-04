import 'package:blord/modules/profile/widgets/edit_widget.dart';
import 'package:blord/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController =
      TextEditingController(text: "Charles Emmah");
  TextEditingController emailController =
      TextEditingController(text: "opeyemicharlese@gmail.com");
  TextEditingController numberController =
      TextEditingController(text: "089812312***");
  TextEditingController usernameController =
      TextEditingController(text: "aryn");
  TextEditingController addressController = TextEditingController(
      text:
          "80 Genting Lane #01-00 Genting Block Ruby Industrial Complex,Singapore");
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        brightness: Brightness.dark,
        title: Text(
          "Edit Profile",
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100.h,
                        width: double.infinity,
                        color: theme.accentColor,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              "Change Photo Profile",
                              style: TextStyle(
                                fontFamily: ConstanceData.nunitoFont,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  //
                                },
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 80.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: theme.accentColor, width: 3),
                          image: DecorationImage(
                            image: AssetImage(ConstanceData.user1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              EditWidget(title: "Fullname", controller: nameController),
              EditWidget(title: "Email", controller: emailController),
              EditWidget(title: "Phone Number", controller: numberController),
              EditWidget(title: "Username", controller: usernameController),
              SizedBox(height: 30.h),
              Container(
                height: 55.h,
                width: 327.w,
                decoration: BoxDecoration(
                  color: theme.backgroundColor,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: theme.accentColor,
                    fontSize: 14.sp,
                    fontFamily: ConstanceData.nunitoFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
