import 'package:blord/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final void Function(String?)? onSaved;
  final String? errorText;

  const EditWidget({Key? key, required this.title, required this.controller, this.hintText, this.onSaved, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 70.h,
        width: 327.w,
        decoration: BoxDecoration(
            color: theme.accentColor,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: theme.backgroundColor, width: 0.2.w)),
        padding: EdgeInsets.only(left: 17.w, top: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: ConstanceData.nunitoFont,
                fontSize: 12.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextFormField(
              onSaved: onSaved,
              controller: controller,
              style: TextStyle(
                fontFamily: ConstanceData.nunitoFont,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: theme.backgroundColor,
              ),
              decoration: InputDecoration(
                errorText: errorText,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: ConstanceData.nunitoFont,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.grey.withOpacity(0.5),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
