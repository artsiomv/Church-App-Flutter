import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageTile extends StatelessWidget {

  final String imageName;
  final String type;
  final Function action;

  ImageTile({this.imageName, this.type, this.action, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    return GestureDetector(
      onTap: action,
      child: Container(
        height: 200,
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(color: Colors.black),
          color: Colors.black
        ),
        child: ListTile (
          contentPadding: EdgeInsets.only(left: 0.0),
          title: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider('https://app.lttwchurch.org/LTTW_app_php/$type/$imageName'),
                  fit: BoxFit.cover,
              ),
            )
          ),
        ),
      ),
    );
  }
}