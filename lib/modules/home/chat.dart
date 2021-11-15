import 'package:blord/api/firebase_api.dart';
import 'package:blord/models/message.dart';
import 'package:blord/models/user.dart';
import 'package:blord/utils/constant.dart';
import 'package:blord/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chat extends StatefulWidget {
  final AuthUser receiver, sender;
  const Chat({Key? key, required this.receiver, required this.sender, }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String message = _controller.text.trim();
      FocusScope.of(context).unfocus();
      await FirebaseApi.uploadMessage(widget.receiver.idUser, widget.sender, message).whenComplete(() {
        _controller.clear();
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment: sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              bottomRight: sendByMe ? Radius.circular(0) : Radius.circular(15.sp),
              topRight: Radius.circular(15.sp),
              bottomLeft: sendByMe ? Radius.circular(15.sp) : Radius.circular(0),
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Text(message, style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: ConstanceData.dmSansFont,
                fontSize: 14.sp,
                color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }

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
          RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          headerWiget(theme),
          SizedBox(height: 50.h),
          Expanded(child: StreamBuilder<QuerySnapshot<Message>>(
            stream: FirebaseApi.getMessages(widget.receiver.idUser),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  } else {
                    final messages = snapshot.requireData;
                    return messages.docs.isEmpty
                        ? Center(child: Text('No messages yet, Start a conversation'))
                        : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      itemCount: messages.size,
                      itemBuilder: (context, index) {
                        Message message = messages.docs[index].data();
                        return chatMessageTile(message.message, firebaseUser!.uid == message.idUser);
                      },
                    );
                  }
              }
            },
          )),
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
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
                  onTap: ()=> sendMessage(),
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
          )
        ],
      )
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
                  child: Image.network("${widget.receiver.urlAvatar}", fit: BoxFit.cover,),
                ),
              ),
              SizedBox(width: 17.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.receiver.username}",
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
            "This Is Private Message, Between You And ${widget.receiver.username}.\nThis Chat Is End to End Encrypted...",
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
