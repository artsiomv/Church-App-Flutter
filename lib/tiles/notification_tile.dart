import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NotificationTile extends StatelessWidget {

  final String title;
  final String body;

  NotificationTile({this.title, this.body, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54
        ),
        child: ListTile (
          title: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '$title\n', style: TextStyle( color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.bold), ),
                TextSpan(text: '$body', style: TextStyle(color: Colors.grey[200], fontSize: 17), ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
