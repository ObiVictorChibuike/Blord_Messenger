import 'package:blord/models/message.dart';
import 'package:blord/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {

  static Stream<QuerySnapshot<AuthUser>> getUsers() {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter<AuthUser>(
      fromFirestore: (snapshots, _) => AuthUser.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

    return userRef.snapshots();
  }

  static Stream<QuerySnapshot<AuthUser>> getChats() {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter<AuthUser>(
      fromFirestore: (snapshots, _) => AuthUser.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

    return userRef.orderBy(UserField.lastMessageTime, descending: true).snapshots();
  }

  static Future uploadMessage(String idUser, AuthUser user, String message) async {
    final refMessages = FirebaseFirestore.instance.collection('chats/$idUser/messages');

    final newMessage = Message(
      idUser: user.idUser,
      urlAvatar: user.urlAvatar,
      username: user.username,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');

    await refUsers.doc(idUser).update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<QuerySnapshot<Message>> getMessages(String idUser){
    final messagesRef = FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        .withConverter<Message>(
      fromFirestore: (snapshots, _) => Message.fromJson(snapshots.data()!),
      toFirestore: (message, _) => message.toJson(),
    );

    return messagesRef.orderBy(MessageField.createdAt, descending: true).snapshots();

  }

  static Future addUser(AuthUser user) async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .withConverter<AuthUser>(
      fromFirestore: (snapshots, _) => AuthUser.fromJson(snapshots.data()!),
      toFirestore: (user, _) => user.toJson(),
    );

    await userRef.doc(user.idUser).set(
      user,
      SetOptions(merge: true),
    );
  }
}
