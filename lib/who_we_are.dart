import 'package:flutter/material.dart';
import 'package:light_youth/hs_ministry.dart';
import 'light_youth.dart';
import 'hs_ministry.dart';

class WhoWeAre extends StatelessWidget {
  WhoWeAre({Key key}) : super(key:key);

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HSMinistry()));
            },
            child: Container(
              height: 160,
              child: Center(child: Text('HS MINISTRY', style: style)),
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black,
                      offset: new Offset(0.0, 5.0),
                      blurRadius: 40.0,
                      spreadRadius: 40.0)
                ],
                image: DecorationImage(
                  image: AssetImage('assets/images/pic2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LightYouth()));
            },
            child: Container(
              height: 160,
              child: Center(child: Text('LIGHT YOUTH', style: style)),
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                      color: Colors.black,
                      offset: new Offset(0.0, 5.0),
                      blurRadius: 40.0,
                      spreadRadius: 40.0)
                ],
                image: DecorationImage(
                  image: AssetImage('assets/images/pic1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Events()));
            },
            child: Container(
              height: 160,
              child: Center(child: Text('LTTW CHURCH', style: style)),
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