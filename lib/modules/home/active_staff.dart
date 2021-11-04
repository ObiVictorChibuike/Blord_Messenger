import 'package:blord/models/active_model.dart';
import 'package:blord/models/recent_model.dart';
import 'package:blord/modules/home/chat.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveStaff extends StatefulWidget {
  const ActiveStaff({Key? key}) : super(key: key);

  @override
  _ActiveStaffState createState() => _ActiveStaffState();
}

class _ActiveStaffState extends State<ActiveStaff> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.accentColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: theme.backgroundColor,
          ),
          title: Text(
            "Active Staff",
            style: TextStyle(color: theme.backgroundColor),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  //more
                },
                icon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.more_horiz,
                  ),
                ))
          ]),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
          child: Column(
            children: [
              searchBar(),
              SizedBox(height: 25.h),
              Row(children: [
                Text(
                  "8 Staff Available",
                  style: styleText(),
                ),
                SizedBox(width: 130.w),
                IconButton(
                    onPressed: () {
                      //reorder
                    },
                    icon: Icon(Icons.sort)),
                IconButton(
                    onPressed: () {
                      //reorder
                    },
                    icon: Icon(Icons.swap_horiz)),
              ]),
              SizedBox(height: 20.h),
              Flexible(
                child: ListView.builder(
                  itemCount: allActive.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return Chat(
                              recent: allActive[index],
                            );
                          }),
                        );
                      },
                      child: Container(
                        height: 84.h,
                        width: 342.w,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35.sp,
                              backgroundColor: HexColor(allActive[index].color),
                              child: Image.asset(
                                allActive[index].image,
                                height: 40.h,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    allActive[index].username,
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: ConstanceData.dmSansFont,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    allActive[index].gmail,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: ConstanceData.dmSansFont,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }

  Container searchBar() {
    return Container(
      height: 50.h,
      width: 342.w,
      decoration: BoxDecoration(
          color: HexColor("#F5F8FC"),
          borderRadius: BorderRadius.circular(10.sp)),
      alignment: Alignment.center,
      child: TextField(
        style: txtStyle(),
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search_rounded),
            hintText: "Search by name",
            hintStyle: txtStyle()),
      ),
    );
  }

  TextStyle txtStyle() {
    return TextStyle(
      fontFamily: ConstanceData.dmSansFont,
      fontSize: 15.sp,
    );
  }

  TextStyle styleText() {
    return TextStyle(
      fontFamily: ConstanceData.dmSansFont,
      fontSize: 15.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );
  }
}
