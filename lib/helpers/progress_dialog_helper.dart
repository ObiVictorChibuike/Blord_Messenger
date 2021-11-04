import 'package:blord/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CustomProgressDialog{

  showCustomAlertDialog(BuildContext context, String message) async {
    await NDialog(
      dialogStyle: DialogStyle(titleDivider: true, contentTextStyle: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, fontSize: 18, color: AppTheme.dark_blue),),
      title: Container(),
      content: Row(
        children: [
          CupertinoActivityIndicator(radius: 15,),
          SizedBox(width: 50,),
          Text(message),
        ],
      ),
    ).show(context);
  }

  popCustomProgressDialogDialog(BuildContext context){
    Navigator.of(context).pop();
  }
}