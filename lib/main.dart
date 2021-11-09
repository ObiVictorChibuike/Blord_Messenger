import 'package:blord/modules/splash/splash.dart';
import 'package:blord/utils/routes.dart';
import 'package:blord/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends AppMVC {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Phoenix(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () {
          return MaterialApp (
            title: 'Blord Messenger',
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.getTheme(),
            initialRoute: "/splash",
            onGenerateRoute: RouteGenerator.generateRoute,
            home: Splash(),
          );
        },
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Center(child: Text('Something went wrong, please reload', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),),),);}
        if (snapshot.connectionState == ConnectionState.done) {return Splash();}
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
