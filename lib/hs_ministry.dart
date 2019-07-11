import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'get_involved.dart';


class HSMinistry extends StatelessWidget {
  HSMinistry({Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    TextStyle style;
    style = _setStyle();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Who We Are'),),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
         
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GetInvolved()));
              },
              child: Container(
                height: 200,
                child: Center(child: Text('GET INVOLVED', style: style)),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(0.0, 5.0),
                        blurRadius: 40.0,
                        spreadRadius: 40.0)
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/pic3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          
        ]
      ),
    );
  }

  openBrowser(String url) async{
    // const url = url;//'https://pushpay.com/fsp/lighttotheworldchurch?t=8ac91fb4-aca3-0766-9aeb-02027b672f3e';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  TextStyle _setStyle() {
    return TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    );
  }
}