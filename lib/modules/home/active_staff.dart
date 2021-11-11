import 'package:blord/helpers/database_helper.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/modules/home/chat.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ActiveStaff extends StatefulWidget {
  const ActiveStaff({Key? key}) : super(key: key);

  @override
  _ActiveStaffState createState() => _ActiveStaffState();
}

class _ActiveStaffState extends State<ActiveStaff> {
  String? myName, myProfilePic, myUserName, myEmail;
  TextEditingController _searchController = TextEditingController();
  CollectionReference _firebaseFireStore = FirebaseFirestore.instance.collection("users");
  bool isSearching = false;

  getChatRoomIdByUserNames(String a, String b){
    if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
      return "$b\_$b";
    } else{
      return "$a\_$b";
    }
  }

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    //setState(() {});
  }


  @override
  void initState() {
    getMyInfoFromSharedPreference();
    super.initState();
  }

  onSearch(String value) async {
    isSearching = true;
    setState(() {});
  }

  Widget searchUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseFireStore.snapshots().asBroadcastStream(),
        builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){
          if  (snapshot.hasData){
            final length = snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element["username"].toString().contains(_searchController.text)).length;
            return Expanded(
              child: ListView(
                children: [
                  Row(children: [
                    Text("$length Staff Available", style: styleText(),),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.sort)), IconButton(onPressed: () {}, icon: Icon(Icons.swap_horiz)),]),
                  ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element["username"].toString().contains(_searchController.text)).map((QueryDocumentSnapshot<Object?> data){
                    final String username = data["username"];final String image = data["photoUrl"];final String name = data["name"];
                    return GestureDetector(
                      onTap: (){
                        print(myUserName);
                        print(myName);
                        var chatRoomId = getChatRoomIdByUserNames(myUserName!, myName!);
                        Map<String, dynamic> chatRoomInfoMap ={"users": [myUserName!, myName!]};
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat(image: image, displayName: name,)));
                        DataBaseHelper().createChatRoom(chatRoomId, chatRoomInfoMap);
                      },
                      child: ListTile(
                        title: Text(username, style: TextStyle(fontSize: 17, fontFamily: ConstanceData.dmSansFont, fontWeight: FontWeight.w100, ),),
                        leading: CircleAvatar(backgroundImage: NetworkImage(image),),),
                    );})
                ],),);
          } else {
            return Center(child: CupertinoActivityIndicator(radius: 20,),);
          }
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.accentColor, elevation: 0,
          iconTheme: IconThemeData(color: theme.backgroundColor,),
          title: Text("Active Staff", style: TextStyle(color: theme.backgroundColor),),
          actions: [
            IconButton(
                onPressed: () {}, icon: RotatedBox(quarterTurns: 1,
                  child: Icon(Icons.more_horiz,),
                ))
          ]),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
          child: Column(
            children: [
              searchBar(),
              SizedBox(height: 25.h),
              SizedBox(height: 20.h),
              searchUserList(),
            ],
          )),
    );
  }

  Widget searchBar() {
    return Container(
      child: Row(
        children: [
          isSearching ? Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: (){
                isSearching = false;
                _searchController.text = "";
                setState(() {});
              },
                child: Icon(Icons.arrow_back)),
          ) : Container(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              height: 50.h,
              width: 300.w,
              decoration: BoxDecoration(
                  color: HexColor("#F5F8FC"),
                  borderRadius: BorderRadius.circular(10.sp)),
              alignment: Alignment.center,
              child: TextField(
                onSubmitted: (value){
                  onSearch(_searchController.text);
                },
                cursorHeight: 23,
                controller: _searchController,
                style: txtStyle(),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: (){
                        if(_searchController.text != ""){
                          onSearch(_searchController.text.trim());
                          setState(() {});
                        }
                      },
                        child: Icon(Icons.search_rounded)),
                    hintText: "Search by name",
                    hintStyle: txtStyle()),
              ),
            ),
          ),
        ],
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
