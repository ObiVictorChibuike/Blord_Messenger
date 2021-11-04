import 'package:blord/models/active_model.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chat extends StatefulWidget {
  final Active recent;

  const Chat({Key? key, required this.recent}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages = [
    "Hello there",
  ];

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: HexColor("#0C122B"),
        elevation: 0,
        title: Text(
          "Conversation",
        ),
        actions: [
          RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              onPressed: () {
                //more
              },
              icon: Icon(Icons.more_horiz),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            headerWiget(theme),
            SizedBox(height: 50.h),
            Flexible(
              child: Container(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, index) {
                      var left = 2 * messages[index].length;
                      var height = messages[index].length * 0.25;
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 260 - left.w, right: 24.w, bottom: 15.h),
                        child: Container(
                          height: 40 + height + height,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: theme.backgroundColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.h),
                          child: Expanded(
                            child: Text(
                              messages[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: ConstanceData.dmSansFont,
                                fontSize: 14.sp,
                                color: theme.accentColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                height: 50.h,
                width: 350.w,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 15.w),
                          decoration: BoxDecoration(
                              color: HexColor("#EBECEF"),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                              )),
                          child: TextField(
                            style: txtStyle(),
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type your mail",
                              border: InputBorder.none,
                              hintStyle: txtStyle(),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_controller.text.isEmpty) {
                          setState(() {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Message cannot be empty")));
                          });
                        } else {
                          setState(() {
                            messages.add(_controller.text.toString());
                            _controller.clear();
                          });
                        }
                      },
                      child: Container(
                        width: 45.w,
                        decoration: BoxDecoration(
                            color: HexColor("#5D5FEF"),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.sp),
                              bottomRight: Radius.circular(10.sp),
                            )),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.send_sharp,
                          color: theme.accentColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container headerWiget(ThemeData theme) {
    return Container(
      height: 220.h,
      width: double.infinity,
      color: HexColor("#0C122B"),
      padding: EdgeInsets.only(left: 24.w, bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                height: 55.h,
                width: 55.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor(widget.recent.color),
                  image: DecorationImage(
                    image: AssetImage(widget.recent.image),
                  ),
                ),
              ),
              SizedBox(width: 17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recent.username,
                    style: TextStyle(
                      fontFamily: ConstanceData.dmSansFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.accentColor,
                    ),
                  ),
                  Text(
                    "2 Min",
                    style: TextStyle(
                      fontFamily: ConstanceData.dmSansFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            "This Is Private Message, Between You And Budddy.\nThis Chat Is End to End Encrypted...",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              fontFamily: ConstanceData.dmSansFont,
              color: theme.accentColor,
            ),
          )
        ],
      ),
    );
  }

  TextStyle txtStyle() {
    return TextStyle(
      fontFamily: ConstanceData.dmSansFont,
      fontSize: 14.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    );
  }
}
