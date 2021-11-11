import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseHelper{
  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).set(
        userInfoMap
    );
  }
  Future addMessage(String chatRoomId, String messageId, Map <String, dynamic> messageInfoMap) async{
    return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).collection("chats").doc(messageId).set(messageInfoMap);
  }
  updateLastMessageSend(String chatRoomId,Map <String, dynamic> lastMessageInfoMap){
    return FirebaseFirestore.instance.doc(chatRoomId).update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> userInfoMap) async{
    final snapshot = await FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).get();

    if(snapshot.exists){
      return true;
    }else{
      return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).set(userInfoMap);
    }
  }
  Future <Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId)async {
    return FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomId).collection("chats").orderBy("timeStamp", descending: true).snapshots();
  }
  Future <Stream<QuerySnapshot>> getRecentChatList()async{
    String?  myUserName = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance.collection("chatrooms").orderBy("lastMessageSentTime", descending:  true).where("user", arrayContains: myUserName).snapshots();
  }

  Future <QuerySnapshot>? getUserInfo (String? username){
    FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
  }
}