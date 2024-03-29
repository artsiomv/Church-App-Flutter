import 'dart:io';
import 'package:flutter/material.dart';
import 'tiles/text_tile.dart';
import 'tiles/two_actions_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:line_icons/line_icons.dart';


class GetInvolved extends StatelessWidget {
  GetInvolved({Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(title: Text('Get Involved'),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pic3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TwoActionTile(
              name1: 'Instagram',
              name2: 'Facebook',
              iconOne: LineIcons.instagram,//LineIcons.instagram,
              iconTwo: LineIcons.facebook,
              action: () {
                openInstagram();
              },
              action2: () {
                openFacebook();
              },
            
            ),
            Divider(color: Colors.grey[800], height: 1),
            TextTile(body: 'Wednesday:\n7:00 PM - Home Groups\n\nThursday:\n7:15 PM - Youth Service\n\nFriday:\n10:00 PM - Prayer', name: 'Schedule'),
            Divider(color: Colors.grey[800], height: 1),
          ]
        ).toList(),
      ),
    );
  }

  openInstagram() async {
    String inProtocolUrl;
    String fallbackUrl = "https://www.instagram.com/lightyouthbellevue/";

    if (Platform.isIOS) {
      inProtocolUrl = "instagram://user?username=lightyouthbellevue";
    } else {
      inProtocolUrl = "instagram://user?username=lightyouthbellevue"; //TODO: check instagram link on Android
    }

    try {
      bool launched = await launch(inProtocolUrl, forceSafariVC: false);
      
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }


    // String myUrl = 'instagram://username=lightyouthbellevue'; 
    // await FlutterLaunch.
    // String googleUrl = myUrl.replaceAll(new RegExp(" "), "");
    
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open link.';
    // }
  }

  openFacebook() async {
    String fbProtocolUrl;
    String fallbackUrl = "https://www.facebook.com/767256073455942";
    if (Platform.isIOS) {
      fbProtocolUrl = "fb://profile/767256073455942";
    } else {
        fbProtocolUrl = "fb://page/767256073455942";
    }

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }
}