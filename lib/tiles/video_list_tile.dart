import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:light_youth/video_database_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoListTile extends StatelessWidget {

  final Video video;
  final Function action;

  VideoListTile({this.video, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        height: 70,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Colors.black),
          color: Colors.black
        ),
        child: Center(
          child: ListTile (
            contentPadding: EdgeInsets.only(left: 5.0),
            leading: Container(
              padding: EdgeInsets.all(0.0),
              width:90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/uploadsVideo/${video.imageName}'),
                  fit: BoxFit.cover,
                ),
              )
            ),
            title: Text(video.title),
            subtitle: _getType(video.type),
            trailing: Icon(Icons.chevron_right, color: Colors.white70,),
          ),
        ),
      ),
    );
  }

  Widget _getType(String type) {

    if(type == 'LTTW') {
      return Text(type, style: TextStyle(color: Colors.yellow.shade800),);
    } else if (type == 'Light Youth') {
      return Text(type, style: TextStyle(color: Colors.blue[700]),);
    } else {
      return Text(type, style: TextStyle(color: Colors.red[900]),);
    }
  }
}
