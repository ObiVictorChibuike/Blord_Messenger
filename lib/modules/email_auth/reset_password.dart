import 'package:blord/modules/email_auth/email_sign_up.dart';
import 'package:blord/utils/theme.dart';
import 'package:blord/widgets/custom_formfield.dart';
import 'package:blord/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blord/utils/constant.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  //Keys
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Form Validator
  final _emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //FormField Controllers
  TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 150.h, left: 22.w, right: 22.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(ConstanceData.appImage, height: 250.h, width: 276.w,),
                SizedBox(height: 80.h),
                CustomFormField(
                  keyboardType: TextInputType.text,
                  hintText: 'Email', focusedBorderColor: AppTheme.white, enabledBorderColor: AppTheme.white,
                  suffixIcon: Icon(Icons.email_outlined, color: AppTheme.grey.withOpacity(0.5),),
                  height: 50,
                  controller: _emailController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Email form cannot be empty';
                    } else if (!_emailValidator.hasMatch(value)){
                      return 'Please, provide a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  onPressed: () {
                    //google signing
                  },
                  btnText: "Reset",
                  color: HexColor("#005CEE"),
                ),
                SizedBox(height: 20.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EmailSignUp()));
                      },
                      child: Text("Don't have an account? Sign Up", style: TextStyle(fontSize: 14, fontFamily: ConstanceData.robotoFont, color: AppTheme.white, fontWeight: FontWeight.w200),)),
                ],),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
