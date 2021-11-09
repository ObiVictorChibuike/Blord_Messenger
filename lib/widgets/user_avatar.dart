import 'package:blord/modules/profile/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {

  //Global variables
  String? _userName;
  String? _email;
  String? _image;
  String? _displayName;
  String? _phoneNumber;

  final userCollection = FirebaseFirestore.instance.collection("users");
  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future _getUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser)!.uid)
        .get()
        .then((value) {
      setState(() {
        _userName = value.data()!['username'];
        _email = value.data()!['email'];
        _image = value.data()!['photoUrl'];
        _displayName = value.data()!['name'];
        _phoneNumber = value.data()!['phoneNumber'];
      });
      setState(() {});
    }).catchError((error){
      print(error);
    });
  }

  @override
  void initState() {
    _getUserData();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditProfile(username: _userName, email: _email, image: _image, displayName: _displayName, phoneNumber: _phoneNumber,)));
      },
      child: ClipRRect(borderRadius: BorderRadius.circular(60),
        child: Container(decoration: BoxDecoration(shape: BoxShape.circle,),
            child: Image.network(_image ?? "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png"),
        ),
      ),
    );
  }
}
