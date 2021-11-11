import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/modules/home/dashboard.dart';
import 'package:blord/modules/ion/ion.dart';
import 'package:blord/modules/profile/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String? getUserEmailFromEmailPasswordLogin;
  final String? getUserUserIdFromEmailPasswordLogin;
  final String? getUserDisplayNameFromEmailPasswordLogin;
  final String? getUserPhotoUrlFromEmailPasswordLogin;
  final String? getUserUserNameFromEmailPasswordLogin;
  Home({this.getUserEmailFromEmailPasswordLogin, this.getUserUserIdFromEmailPasswordLogin, this.getUserDisplayNameFromEmailPasswordLogin, this.getUserPhotoUrlFromEmailPasswordLogin, this.getUserUserNameFromEmailPasswordLogin});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //selected index to track current page
  int selectedIndex = 0;

  //pagecontroller
  PageController _pageController = PageController();

  //list of pages
  List<Widget> pages = [Dashboard(), Ion(), Profile()];

  //naviagators
  void _onChanged(index) {
    setState(() {
      selectedIndex = index;
    });
  }


  // @override
  // void initState() {
  //   SharedPreferenceHelper().saveUserEmail(widget.getUserEmailFromEmailPasswordLogin!);
  //   SharedPreferenceHelper().saveUserId(widget.getUserUserIdFromEmailPasswordLogin!);
  //   SharedPreferenceHelper().saveUserName(widget.getUserUserNameFromEmailPasswordLogin!);
  //   SharedPreferenceHelper().saveDisplayName(widget.getUserDisplayNameFromEmailPasswordLogin!);
  //   SharedPreferenceHelper().saveUserProfileUrl(widget.getUserPhotoUrlFromEmailPasswordLogin!);
  //   super.initState();
  // }

  onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: pages,
          controller: _pageController,
          onPageChanged: _onChanged,
        ),
        bottomNavigationBar: Container(
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.black,
            unselectedItemColor: theme.accentColor.withOpacity(0.3),
            selectedItemColor: theme.primaryColor,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_rounded), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_sharp), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "")
            ],
          ),
        ));
  }
}
