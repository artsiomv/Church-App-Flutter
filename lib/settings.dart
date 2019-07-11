import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'settings_login.dart';

class Settings extends StatelessWidget {
  Settings({Key key}) : super(key:key);

  Widget build(BuildContext context) {
    return _myListView(context);
  }
  Widget _myListView(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[900],
        appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              LineIcons.user,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SettingsLogIn()));
            },
          ),
        ],
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Send Feedback'),
              trailing: Icon(Icons.chevron_right, color: Colors.white70,),
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Privacy Policy'),
              trailing: Icon(Icons.chevron_right, color: Colors.white70,),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('About'),
              trailing: Icon(Icons.chevron_right, color: Colors.white70,),
            ),
          ]
        ).toList(),
      ),
    );
  }
}