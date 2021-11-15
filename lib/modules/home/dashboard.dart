import 'package:blord/api/firebase_api.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/models/recent_model.dart';
import 'package:blord/models/user.dart';
import 'package:blord/modules/home/active_staff.dart';
import 'package:blord/modules/notifcation/notification.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/widgets/user_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  AuthUser? authUser;

  initData() async {
    await sharedPreferenceHelper.getUserData().then((value){
      setState(() {
        authUser = value;
      });
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }


  Widget recentChatList(){
    return StreamBuilder<QuerySnapshot<AuthUser>>(
        stream: FirebaseApi.getUsers(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else {
                final users = snapshot.requireData;
                return users.docs.isEmpty
                    ? Center(child: Text('No messages yet, Start a conversation')) :
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: users.size,
                  itemBuilder: (context, index) {
                    AuthUser user = users.docs[index].data();
                    Widget widget;
                    if (user.idUser != firebaseUser!.uid) {
                      widget = RecentChatTile(onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(
                          sender: authUser!,
                          receiver: user,
                        )),);},
                        lastMessage:  user.username,
                        lastMessageTime: user.lastMessageTime,
                        profilePic: user.urlAvatar,
                        sentBy: user.username,
                      );
                    }  else widget = const SizedBox();
                    return widget;
                  },
                );
              }
          }
        }
    );
  }
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
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Notifications()));
              },
              icon: Icon(Icons.notifications)),
          authUser == null ? const SizedBox() : UserAvatar(user: authUser!,),
          SizedBox(width: 20.w),
        ],
      ),
      backgroundColor: Colors.black,
      body: authUser == null ? const SizedBox() : Container(
        padding: EdgeInsets.only(top: 40.h, left: 8.w, right: 8.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          Text("Recent Chats", style: TextStyle(fontFamily: ConstanceData.dmSansFont,
              fontSize: 24.sp, color: theme.accentColor, fontWeight: FontWeight.w700),),
          SizedBox(height: 15.h),
          Expanded(
            child: recentChatList(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ActiveStaff()));
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

class RecentChatTile extends StatefulWidget {
  VoidCallback onTap;
  String? profilePic;
  String? lastMessageTime;
  String? lastMessage;
  String? sentBy;
  RecentChatTile({Key? key, required this.onTap, required this.profilePic, required this.lastMessageTime,
    required this.lastMessage, required this.sentBy}) : super(key: key);

  @override
  _RecentChatTileState createState() => _RecentChatTileState();
}

class _RecentChatTileState extends State<RecentChatTile> {

  TextStyle txtStyle() {
    return TextStyle(
      fontSize: 12.sp,
      fontFamily: ConstanceData.nunitoFont,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> widget.onTap.call(),
      leading: Image.network(widget.profilePic!),
      title: Text(widget.sentBy!, style: TextStyle(
            fontFamily: ConstanceData.nunitoFont,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
      subtitle: Text(widget.lastMessage!, style: txtStyle(),),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.lastMessageTime!, style: TextStyle(color: Theme.of(context).primaryColor),),
          SizedBox(height: 10.h),
          // CircleAvatar(
          //   color: theme.primaryColor,
          //   child: index.toString(),
          // )
        ],
      ),
    );
  }
}

