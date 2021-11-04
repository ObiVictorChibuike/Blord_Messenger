import 'package:blord/models/onboard_model.dart';
import 'package:blord/modules/auth/authenticate.dart';
import 'package:blord/modules/onboard/widgets/indicator.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int selectedIndex = 0;
  PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.accentColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20.w, left: 20.w),
        child: Column(
          children: [
            Container(
              height: 106.h,
              width: 219.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(ConstanceData.appIcon),
              )),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 360.h,
              width: 364.w,
              child: PageView.builder(
                  itemCount: allOnboard.length,
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Column(children: [
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(allOnboard[index].image),
                        )),
                      ),
                      SizedBox(height: 15.h),
                      Text(allOnboard[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: ConstanceData.dmSansFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ))
                    ]);
                  }),
            ),
            SizedBox(height: 20.h),
            Indicator(selectedIndex: selectedIndex),
            SizedBox(height: 100.h),
            actionButton(theme)
          ],
        ),
      ),
    );
  }

  Widget actionButton(ThemeData theme) {
    return GestureDetector(
      onTap: () {
        selectedIndex < 2
            ? _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.bounceInOut)
            : Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
                return Authenticate();
              }), (route) => false);
      },
      child: Container(
          height: 50.h,
          width: 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: HexColor("#02091D"),
          ),
          alignment: Alignment.center,
          child: Text(selectedIndex < 2 ? "NEXT" : "GET STARTED",
              style: TextStyle(
                fontFamily: ConstanceData.nunitoFont,
                fontSize: 18.sp,
                color: theme.accentColor,
              ))),
    );
  }
}
