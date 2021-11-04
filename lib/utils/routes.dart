import 'package:blord/modules/auth/authenticate.dart';
import 'package:blord/modules/home/active_staff.dart';
import 'package:blord/modules/home/dashboard.dart';
import 'package:blord/modules/home/home.dart';
import 'package:blord/modules/ion/ion.dart';
import 'package:blord/modules/notifcation/notification.dart';
import 'package:blord/modules/onboard/onboard.dart';
import 'package:blord/modules/profile/profile.dart';
import 'package:blord/modules/splash/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/onboard':
        return MaterialPageRoute(builder: (_) => Onboarding());
      case '/login':
        return MaterialPageRoute(builder: (_) => Authenticate());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/active':
        return MaterialPageRoute(builder: (_) => ActiveStaff());
      case '/notification':
        return MaterialPageRoute(builder: (_) => Notifications());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/ion':
        return MaterialPageRoute(builder: (_) => Ion());
      // case '/finish':
      //   return MaterialPageRoute(builder: (_) => CreatPin());
    }
  }
}
