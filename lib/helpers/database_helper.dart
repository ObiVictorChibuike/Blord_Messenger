import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseHelper{
  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).set(
        userInfoMap
    );
  }

  Future <Stream<QuerySnapshot?>> searchUserByName(String? userName) async {
    return FirebaseFirestore.instance.collection("user").where("username", isEqualTo: userName).snapshots();
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
}