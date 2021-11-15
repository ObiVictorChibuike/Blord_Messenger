import 'package:blord/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CustomProgressDialog{
  late NAlertDialog dialog;

  showDialog(BuildContext context, String message) {
    dialog = NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: Text("Please wait"),
      content: Row(
        children: [
          CupertinoActivityIndicator(radius: 20,),
          SizedBox(width: 10,),
          Text(message),
        ],
      ),
      blur: 2,
      dismissable: false,
    );
    dialog.show(context, transitionType: DialogTransitionType.Shrink);
  }

  hideDialog(BuildContext context){
    Navigator.pop(context);
  }
}