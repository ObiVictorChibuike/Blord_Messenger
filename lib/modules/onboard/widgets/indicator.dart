import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Indicator extends StatefulWidget {
  int selectedIndex;

  Indicator({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 10.h,
      width: 70.w,
      child: Wrap(
        spacing: 7.w,
        children: List.generate(3, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 10.h,
            width: widget.selectedIndex == index ? 25.w : 10.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: widget.selectedIndex == index
                    ? theme.backgroundColor
                    : Colors.grey.withOpacity(0.3)),
          );
        }),
      ),
    );
  }
}
