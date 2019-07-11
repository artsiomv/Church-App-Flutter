import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key:key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            //table would be here somewhere
            // Text('title: ${user.title}'),
            // Text('speaker: ${user.speaker}')
          ]
        ),
      ),
    );
  }
}