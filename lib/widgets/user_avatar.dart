import 'package:blord/helpers/sharedpref_helper.dart';
import 'package:blord/models/user.dart';
import 'package:blord/modules/profile/edit_profile.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  final AuthUser user;
  const UserAvatar({Key? key, required this.user}) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
            EditProfile(user: widget.user,)));
      },
      child: Container(height: 40, width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(widget.user.urlAvatar),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}
