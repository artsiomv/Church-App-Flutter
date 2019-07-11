import 'package:flutter/material.dart';
import 'video_database_helpers.dart';
import 'tiles/text_tile.dart';
import 'tiles/image_tile.dart';
import 'tiles/two_actions_tile.dart';
import 'tiles/play_video.dart';
import 'package:share/share.dart';

import 'package:line_icons/line_icons.dart';

class VideoDetailsScreen extends StatelessWidget {
  final Video video;
  VideoDetailsScreen({Key key, @required this.video}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(title: Text(video.title),),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ImageTile(imageName: video.imageName, type: 'uploadsVideo',),
            Divider(color: Colors.grey[800], height: 1,),
            TwoActionTile(
              name1: 'Play Video',
              name2: 'Share',
              iconOne: LineIcons.play,
              iconTwo: LineIcons.share_square ,
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayVideo(video.videoURL)
                  )
                );
              },
              action2: () {
                Share.share('Check out our latest podcast \"${video.title}\" \n${video.videoURL}');
              },
            
            ),
            Divider(color: Colors.grey[800], height: 1,),
            TextTile(body: '${video.speaker} \n${video.dateSpoken}', name: 'Description'),
            Divider(color: Colors.grey[800], height: 1),
          ]
        ).toList(),
      ),
    );
  }
}