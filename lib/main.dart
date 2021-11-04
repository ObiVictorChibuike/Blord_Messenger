import 'package:blord/modules/splash/splash.dart';
import 'package:blord/utils/routes.dart';
import 'package:blord/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp()));
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
          return MaterialApp(
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
