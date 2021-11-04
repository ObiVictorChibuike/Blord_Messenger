import 'package:blord/modules/profile/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            "Security Setting",
            style: TextStyle(
              color: theme.primaryColor,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(children: [
            SettingTile(
                btnText: "Enable Fingerprint",
                onSwitch: () {
                  //enable/disable fingerprintt
                }),
            SettingTile(
                btnText: "Show status",
                onSwitch: () {
                  //enable/disable fingerprintt
                }),
            SettingTile(
                btnText: "Allow Video Call",
                onSwitch: () {
                  //enable/disable fingerprintt
                })
          ]),
        ));
  }
}
