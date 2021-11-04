import 'package:blord/models/recent_model.dart';
import 'package:blord/modules/home/active_staff.dart';
import 'package:blord/modules/notifcation/notification.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(ConstanceData.appImage),
        backgroundColor: theme.backgroundColor,
        elevation: 0,
        brightness: Brightness.dark,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Notifications();
                }));
              },
              icon: Icon(Icons.notifications)),
          UserAvatar(),
          SizedBox(width: 20.w),
        ],
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 40.h, left: 8.w, right: 8.w),
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              height: 90.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allRecent.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: statusWidget(index, theme),
                    );
                  })),
          SizedBox(height: 10.h),
          Text(
            "Recent Chats", style: TextStyle(fontFamily: ConstanceData.dmSansFont, fontSize: 24.sp, color: theme.accentColor, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 15.h),
          Flexible(
              child: ListView.builder(
                  itemCount: allRecent.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: ListTile(
                        leading: Image.asset(allRecent[index].image),
                        title: Text(allRecent[index].username,
                            style: TextStyle(
                              fontFamily: ConstanceData.nunitoFont,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                        subtitle: Text(
                          allRecent[index].lastMsg,
                          style: txtStyle(),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              allRecent[index].time,
                              style: TextStyle(color: theme.primaryColor),
                            ),
                            SizedBox(height: 10.h),
                            circleAvatar(
                              color: theme.primaryColor,
                              text: index.toString(),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          //
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ActiveStaff();
          }));
        },
        child: Icon(
          Icons.add,
          color: theme.accentColor,
        ),
      ),
    );
  }

  Widget circleAvatar({color, text}) {
    return CircleAvatar(
      radius: 10.sp,
      backgroundColor: color,
      child: Center(
        child: Text(
          text,
          style: txtStyle(),
        ),
      ),
    );
  }

  Column statusWidget(int index, theme) {
    return Column(children: [
      Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
            border: Border.all(color: theme.primaryColor, width: 2.0.w),
            borderRadius: BorderRadius.circular(8.sp),
            image: DecorationImage(
              image: AssetImage(allRecent[index].image),
            )),
      ),
      SizedBox(height: 10.h),
      Text(
        allRecent[index].username,
        style: txtStyle(),
      ),
    ]);
  }

  TextStyle txtStyle() {
    return TextStyle(
      fontSize: 12.sp,
      fontFamily: ConstanceData.nunitoFont,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }
}
