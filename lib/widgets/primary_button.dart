import 'package:blord/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnText;
  final Color color;
  final Widget? btnImage;

  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.btnText,
      required this.color,
        this.btnImage,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 50.h,
          width: 329.w,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10.sp)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              btnImage ?? Container(),
              SizedBox(width: 5),
              Text (btnText, style: txtStyle(),),
            ],
          )),
    );
  }

  TextStyle txtStyle() {
    return TextStyle(
      fontSize: 20.sp,
      fontFamily: ConstanceData.robotoFont,
      fontWeight: FontWeight.w100,
      color: Colors.white,
    );
  }
}
