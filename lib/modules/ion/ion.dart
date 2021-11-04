import 'package:flutter/material.dart';

class Ion extends StatefulWidget {
  const Ion({Key? key}) : super(key: key);

  @override
  _IonState createState() => _IonState();
}

class _IonState extends State<Ion> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
