import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:light_youth/event_database_helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventListTile extends StatelessWidget {

  final MyEvent event;
  final Function action;


  EventListTile({this.event, this.action, Key key}) : super(key: key);

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
                  image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/uploadsEvent/${event.imageName}'),
                  fit: BoxFit.cover,
                ),
              )
            ),
            title: Text(event.title),
            trailing: Icon(Icons.chevron_right, color: Colors.white70,),
          ),
        ),
      ),
    );
  }
}
