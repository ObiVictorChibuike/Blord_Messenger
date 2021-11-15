import 'package:blord/api/firebase_api.dart';
import 'package:blord/models/user.dart';
import 'package:blord/modules/home/chat.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveStaff extends StatefulWidget {
  const ActiveStaff({Key? key}) : super(key: key);

  @override
  _ActiveStaffState createState() => _ActiveStaffState();
}

class _ActiveStaffState extends State<ActiveStaff> {
  TextEditingController _searchController = TextEditingController();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  Widget searchUserList() {
    return StreamBuilder<QuerySnapshot<AuthUser>>(
        stream: FirebaseApi.getUsers().asBroadcastStream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              } else {
                final users = snapshot.requireData;
                if (users.docs.isEmpty) {
                  return Center(child: Text('No user available, Invite friends'));
                }  else{
                  final length = snapshot.data!.docs.where((QueryDocumentSnapshot<AuthUser> element) =>
                      element.data().username.contains(_searchController.text)).length - 1;
                  return Expanded(
                    child: ListView(
                      children: [
                        Row(children: [
                          Text("${length < 0 ? 0 : length == 0 ? 1 : length} Staff Available", style: styleText(),),
                          Spacer(),
                          IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.swap_horiz)),
                        ]),
                        ...snapshot.data!.docs.where((QueryDocumentSnapshot<AuthUser> element) =>
                            element.data().username.contains(_searchController.text)).map((QueryDocumentSnapshot<AuthUser> data) {
                          if (data.data().idUser != firebaseUser!.uid ) {
                            final senderData = data.data();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(
                                  sender: senderData,
                                  receiver: data.data(),
                                )));
                              },
                              child: ListTile(title: Text(data.data().username, style: TextStyle(
                                fontSize: 17, fontFamily: ConstanceData.dmSansFont, fontWeight: FontWeight.w100,),),
                                leading: CircleAvatar(backgroundImage: NetworkImage(data.data().urlAvatar),),
                              ),
                            );
                          }
                          else return SizedBox();
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
          }
        });
  }

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
                onPressed: () {},
                icon: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.more_horiz,
                  ),
                ))
          ]),
      body: Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
          child: Column(
            children: [
              searchBar(),
              SizedBox(height: 45.h),
              searchUserList(),
            ],
          )),
    );
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      height: 50.h,
      width: 300.w,
      decoration: BoxDecoration(
          color: HexColor("#F5F8FC"),
          borderRadius: BorderRadius.circular(10.sp)),
      alignment: Alignment.center,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          setState(() {});
        },
        onChanged: (String value) {
          setState(() {});
        },
        cursorHeight: 23,
        controller: _searchController,
        style: txtStyle(),
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search_rounded),
            contentPadding: EdgeInsets.only(top: 13),
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
