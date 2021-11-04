import 'package:blord/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTile extends StatefulWidget {
  final String btnText;
  final VoidCallback onSwitch;

  const SettingTile({Key? key, required this.btnText, required this.onSwitch})
      : super(key: key);

  @override
  _SettingTileState createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 65.h,
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          widget.btnText,
          style: TextStyle(
            fontFamily: ConstanceData.nunitoFont,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: theme.accentColor,
          ),
        ),
        CupertinoSwitch(
            value: true,
            activeColor: theme.primaryColor,
            onChanged: (value) {
              setState(() {
                value = !value;
              });
            }),
      ]),
    );
  }
}
