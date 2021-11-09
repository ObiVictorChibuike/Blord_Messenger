import 'package:blord/helpers/database_helper.dart';
import 'package:blord/helpers/progress_dialog_helper.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/modules/email_auth/email_login.dart';
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

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({Key? key}) : super(key: key);

  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {



  //FirebaseAuth Initialization
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Keys
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  //Form Validator
  final _passwordValidator = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final _emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //FormField Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Sign Up
  void _createUser(BuildContext context, {required String email, required String password}) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      CustomProgressDialog().showCustomAlertDialog(context, "Please wait...");
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
        CustomProgressDialog().popCustomProgressDialogDialog(context);
          SharedPreferenceHelper().saveUserEmail(value.user!.email!);
          SharedPreferenceHelper().saveUserEmail(value.user!.displayName!);
          SharedPreferenceHelper().saveUserId(value.user!.uid);
          SharedPreferenceHelper().saveUserProfileUrl(value.user!.photoURL!);
          SharedPreferenceHelper().saveUserName(value.user!.email!.replaceAll("@gmail.com", ""));
          Map <String, dynamic> userInfoMap = {
            "userId": value.user!.uid,
            "email": value.user!.email!,
            "username": value.user!.email!.replaceAll("@gmail.com", ""),
            "name": value.user!.displayName!,
            "photoUrl": value.user!.photoURL!,
            "phoneNumber": value.user!.phoneNumber!,
          };
        DataBaseHelper().addUserInfoToDB(value.user!.uid, userInfoMap).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        });
        }).catchError((error){
        print(error.code);
        if (error.code == "email-already-in-use"){
          alertBar(context, "Email already in use", AppTheme.red);
        }
      });
    }
  }

  //Check network connection before login
  void checkSignUpConnectivity(BuildContext context, {required String email, required String password}) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.none)) {
      FocusScope.of(context).unfocus();
      _createUser(context, email: email, password: password);
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
                CustomPasswordFormField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Password', focusedBorderColor: AppTheme.white, enabledBorderColor: AppTheme.white,
                  height: 50,
                  controller: _passwordController,
                  validator: (value){
                    if (value!.isEmpty){
                      return 'Email form cannot be empty';
                    } else if (!_passwordValidator.hasMatch(value)){
                      return 'Password is too weak. Add a special character';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  onPressed: () {
                    //Sign up
                    checkSignUpConnectivity(context, email: _emailController.text.trim(), password: _passwordController.text.trim());
                  },
                  btnText: "Sign Up",
                  color: HexColor("#005CEE"),
                ),
                SizedBox(height: 20.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => EmailLogin()));
                      },
                      child: Text("Already have an account? Login", style: TextStyle(fontSize: 14, fontFamily: ConstanceData.robotoFont, color: AppTheme.white, fontWeight: FontWeight.w200),)),
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
