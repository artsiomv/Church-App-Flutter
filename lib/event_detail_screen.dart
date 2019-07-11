import 'package:flutter/material.dart';
import 'event_database_helpers.dart';
import 'tiles/text_tile.dart';
import 'tiles/image_tile.dart';
import 'tiles/two_actions_tile.dart';
import 'tiles/text_button_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:line_icons/line_icons.dart';
class EventDetailsScreen extends StatelessWidget {
  final MyEvent event;
  EventDetailsScreen({Key key, @required this.event}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(title: Text(event.title),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ImageTile(imageName: event.imageName, type: 'uploadsEvent',),
            Divider(color: Colors.grey[800], height: 1,),
            TwoActionTile(
              name1: 'Save Event',
              name2: 'Directions',
              iconOne: LineIcons.calendar_check_o,
              iconTwo: LineIcons.map,
              action: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PlayVideo(video.videoURL)
                //   )
                // );
              },
              action2: () {
                openMaps();
              },
            
            ),
            Divider(color: Colors.grey[800], height: 1),
            TextTile(body: event.description, name: 'Description'),
            Divider(color: Colors.grey[800], height: 1),
            TextButtonTile(body: event.startDate, name: 'Save Event', icon: LineIcons.calendar_check_o,
              action: () {

              }
            ),
            Divider(color: Colors.grey[800], height: 1),
            TextButtonTile(body: event.address, name: 'Directions', icon: LineIcons.map,
              action: () {
                openMaps();
              }
            ),
            Divider(color: Colors.grey[800], height: 1),
          ]
        ).toList(),
      ),
    );
  }

  openMaps() async {
    //TODO: check if it works for regular address
    String myUrl = 'https://www.google.com/maps/place/${event.address}'; 
    String googleUrl = myUrl.replaceAll(new RegExp(" "), "");
    
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  saveEvent() async {
    
  }
}