import 'package:blord/helpers/progress_dialog_helper.dart';
import 'package:blord/modules/email_auth/email_sign_in.dart';
import 'package:blord/modules/email_auth/reset_password.dart';
import 'package:blord/modules/home/home.dart';
import 'package:blord/utils/theme.dart';
import 'package:blord/widgets/custom_formfield.dart';
import 'package:blord/helpers/flush_bar_helper.dart';
import 'package:blord/widgets/primary_button.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blord/utils/constant.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  //Initializing firebaseAuth as _auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Form Validator
  final _passwordValidator = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final _emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //Keys
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //FormField Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Login
  void _login(BuildContext context,{required String email, required String password}){
    CustomProgressDialog().showCustomAlertDialog(context, "Please wait...");
    _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      CustomProgressDialog().popCustomProgressDialogDialog(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Home()));
    }).catchError((error){
      if (error.code == "wrong-password") {
        CustomProgressDialog().popCustomProgressDialogDialog(context);
        alertBar(context, "Wrong password", AppTheme.red);
      } else if (error.code == "user-not-found") {
        CustomProgressDialog().popCustomProgressDialogDialog(context);
        alertBar(context, "User not found", AppTheme.red);
      }
    });
  }

  //Check network connection before login
  void checkLoginConnectivity(BuildContext context,{required String email, required String password}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.none)) {
      FocusScope.of(context).unfocus();
      _login(context, email: email, password: password);
    }else{alertBar(context, "No network connection", AppTheme.red);}}


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
                  }, hintText: 'Email', focusedBorderColor: AppTheme.white, enabledBorderColor: AppTheme.white,
                ),
                SizedBox(height: 20.h),
                CustomPasswordFormField(
                  keyboardType: TextInputType.visiblePassword,
                  height: 50,
                  controller: _passwordController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Email form cannot be empty';
                    } else if (!_passwordValidator.hasMatch(value)){
                      return 'Please, provide a valid email';
                    } else {
                      return null;
                    }
                  }, hintText: 'Password', focusedBorderColor: AppTheme.white, enabledBorderColor: AppTheme.white,
                ),
                SizedBox(height: 10.h),
                Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ResetPassword()));
                    },
                      child: Text("Forgot password?", style: TextStyle(fontSize: 14, fontFamily: ConstanceData.robotoFont, color: AppTheme.white, fontWeight: FontWeight.w200),)),
                ],),
                SizedBox(height: 20.h),
                PrimaryButton(
                  onPressed: () {
                    //Login
                    checkLoginConnectivity(context, email: _emailController.text.trim(), password: _passwordController.text.trim());
                  },
                  btnText: "Login",
                  color: HexColor("#005CEE"),
                ),
                SizedBox(height: 20.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EmailSignUp()));
                    },
                      child: Text("Already have an account? Sign up", style: TextStyle(fontSize: 14, fontFamily: ConstanceData.robotoFont, color: AppTheme.white, fontWeight: FontWeight.w200),)),
                ],),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
