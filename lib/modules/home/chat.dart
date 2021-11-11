import 'package:blord/helpers/database_helper.dart';
import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_string/random_string.dart';

class Chat extends StatefulWidget {
  final String image;
  final String displayName;

  const Chat({Key? key, required this.image, required this.displayName}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}
class _ChatState extends State<Chat> {
   Stream? streamMessages;
   String? chatRoomId;
   String? messageId = "";
   String? myName, myProfilePic, myUserName, myEmail;
   late Map<String, dynamic> lastMessageInfoMap;

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    chatRoomId = getChatRoomIdByUserNames(widget.displayName, myUserName!);
  }

  getChatRoomIdByUserNames(String a, String b){
    if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
      return "$b\_$b";
    } else{
      return "$a\_$b";
    }
  }
  addMessages(bool sendClicked) {
    if(_controller.text != ""){
      String message = _controller.text;
      var lastMessageTime = DateTime.now();
      Map <String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "timeStamp": lastMessageTime,
        "photoUrl": myProfilePic,
      };
      if(messageId == ""){messageId = randomAlphaNumeric(12);}
      DataBaseHelper().addMessage(chatRoomId!, messageId!, messageInfoMap).then((value){
        lastMessageInfoMap = {
          "lastMessage" : message,
          "lastMessageSentTime": lastMessageTime,
          "lastMessageSendBy": myUserName,
        };
        setState(() {
          _controller.text = "";
          messageId = "";
        });
      });
    } else if (sendClicked) {
      DataBaseHelper().updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
      _controller.text = "";
      messageId = "";
    }
  }


  getAndSetMessages() async {
    streamMessages = await DataBaseHelper().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch()async{
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }


  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  Widget chatMessageTile(String message, bool sendByMe){
    return Row(
      mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(15.sp),
              topRight: Radius.circular(15.sp),
              bottomLeft: sendByMe ? Radius.circular(15.sp) : Radius.circular(0),
            ),),
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Text(message,  style: TextStyle(fontWeight: FontWeight.w500, fontFamily: ConstanceData.dmSansFont, fontSize: 14.sp, color: Theme.of(context).accentColor),),
        ),
      ],
    );
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: HexColor("#0C122B"),
        elevation: 0,
        title: Text("Conversation"),
        actions: [
          RotatedBox(quarterTurns: 1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),),)
        ],
      ),
      body: Container(
        child: Column(
          children: [
            headerWiget(theme),
            SizedBox(height: 50.h),
            Expanded(
              child: StreamBuilder<dynamic>(
                stream: streamMessages,
                builder: (context, snapshot){
                  return snapshot.hasData ?
                  ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: (context, index){
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return chatMessageTile(ds["message"], myUserName == ds["sendBy"]);},
                  ) : Center(child: CupertinoActivityIndicator(),);
              },)),
            Padding(padding: EdgeInsets.only(bottom: 10.h),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 50.h, width: 350.w,
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
                            textCapitalization: TextCapitalization.sentences,
                            // onChanged: (value){
                            //   addMessages(false);},
                            cursorHeight: 24,
                            style: txtStyle(),
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              border: InputBorder.none,
                              hintStyle: txtStyle(),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                          FocusScope.of(context).unfocus();
                          addMessages(true);
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
              ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Container(
                  height: 55.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor("#0C122B"),
                  ),
                   child: Image.network(widget.image),
                ),
              ),
              SizedBox(width: 17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.displayName,
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
            "This Is Private Message, Between You And ${widget.displayName}.\nThis Chat Is End to End Encrypted...",
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
