import 'package:blord/helpers/flush_bar_helper.dart';
import 'package:blord/helpers/progress_dialog_helper.dart';
import 'package:blord/models/user.dart';
import 'package:blord/modules/profile/widgets/edit_widget.dart';
import 'package:blord/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  final AuthUser user;
  const EditProfile({Key? key, required this.user, }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    numberController.dispose();
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  
  
  bool emailValid = true;
  bool nameValid = true;
  bool usernameValid = true;
  bool numberValid = true;

  updateProfileData() {
    FocusScope.of(context).unfocus();
    setState(() {
      nameController.text.trim().length < 3 || nameController.text.trim().isEmpty ? nameValid = false : nameValid = true;
      emailController.text.trim().isEmpty ? emailValid = false : emailValid = true;
      usernameController.text.trim().length < 3 ? usernameValid = false : usernameValid = true;
      numberController.text.trim().length < 11 ? numberValid = false : numberValid = true;
    });
    if (emailValid && nameValid && usernameValid){
      CustomProgressDialog().showDialog(context, "Please wait...");
      collection.doc((FirebaseAuth.instance.currentUser)!.uid).update({
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "name": nameController.text.trim(),
        "phoneNumber": numberController.text.trim(),
      }).then((value){
        CustomProgressDialog().hideDialog(context);
        alertBar(context, "Profile updated", AppTheme.red);
        setState(() {});
      });
    }
  }

  //Controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController numberController;
  late TextEditingController usernameController;

  var collection = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor, elevation: 0,
        brightness: Brightness.dark,
        title: Text("Edit Profile",),),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 200.h, width: double.infinity,
                decoration: BoxDecoration(color: theme.backgroundColor,),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(height: 100.h, width: double.infinity, color: theme.accentColor,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20.h),
                            Text("Change Photo Profile", style: TextStyle(fontFamily: ConstanceData.nunitoFont, fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.grey,),),
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
                      child: Container(height: 80.h, width: 80.w,
                        decoration: BoxDecoration(border: Border.all(color: theme.accentColor, width: 3), shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.user.urlAvatar),
                            fit: BoxFit.cover,
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.h),

              EditWidget(title: "FullName", controller: nameController = TextEditingController(text: widget.user.name == null ? "" : widget.user.name), hintText: "Update FullName", errorText: nameValid ? null: "Name is too short",),
              EditWidget(title: "Email", controller: emailController = TextEditingController(text: widget.user.email), hintText: "Update Email", errorText: emailValid ? null : "Email cannot be empty",),
              EditWidget(title: "Phone Number", controller: numberController = TextEditingController(text: widget.user.phoneNumber == null ? "" : widget.user.phoneNumber), hintText: "Update Phone Number",),
              EditWidget(title: "Username", controller: usernameController = TextEditingController(text: widget.user.username), hintText: "Update Username", errorText: usernameValid ? null : "User name is too short",),

              SizedBox(height: 30.h),

              GestureDetector(
                onTap: (){
                  updateProfileData();
                  setState(() {});
                },
                child: Container(height: 55.h, width: 327.w,
                  decoration: BoxDecoration(color: theme.backgroundColor, borderRadius: BorderRadius.circular(10.sp),),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
