// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:light_youth/about_us.dart';
import 'videos.dart';
import 'events.dart';
import 'get_involved.dart';
import 'settings.dart';
import 'images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'tiles/notification_tile.dart';
import 'notification_database_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:random_string/random_string.dart';
import 'id_database_helper.dart';
import 'who_we_are.dart';
import 'event_database_helpers.dart';
import 'event_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'event_detail_screen.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'carousel_slider.dart';
import 'tiles/video_list_tile.dart';
import 'video_database_helpers.dart';
import 'package:carousel/carousel.dart';

// Video vid = VideoDatabaseHelper.instance.queryAllVideos().then((value) {
//   return value[0];
// });
//new Video(dateSpoken: 'date', id: 1, title: 'Title', imageName: 'imageNmae', speaker: 'speaker', type: 'type');
// Video vid2 = new Video(dateSpoken: 'date', id: 1, title: 'Title2', imageName: 'imageNmae', speaker: 'speaker2', type: 'type');

// final List<String> imgList = [
//   // vid,
//   // vid2,
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

void main() => runApp(MyApp());

// final CarouselSlider autoPlayDemo = CarouselSlider(
//   height: 280,
//   viewportFraction: 0.9,
//   aspectRatio: 2.0,
//   autoPlay: true,
//   enlargeCenterPage: true,
//   items: imgList.map(
//     (url) {
//       return Container(
//         margin: EdgeInsets.all(5.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//           // child: Text(url.title),
//           child: Image.network(
//             url,
//             fit: BoxFit.cover,
//             width: 1000.0,
//           ),
//         ),
//       );
//     },
//   ).toList(),
// );

// final List child = map<Widget>(
//   imgList,
//   (index, i) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         child: Stack(children: <Widget>[
//           Image.network(i, fit: BoxFit.cover, width: 1000.0),
//           // Positioned(
//             // bottom: 0.0,
//             // left: 0.0,
//             // right: 0.0,
//             Container(
//               child: Text('No. $index image'),
//             ),
//           // ),
//         ]),
//       ),
//     );
//   },
// ).toList();

// List<T> map<T>(List list, Function handler) {
//   List<T> result = [];
//   for (var i = 0; i < list.length; i++) {
//     result.add(handler(i, list[i]));
//   }

//   return result;
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H|S MINISTRY',
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: MyHomePage(title: 'H|S MINISTRY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'Home and this is how we roll these awesome days yo', icon: Icons.home),
  CustomPopupMenu(title: 'Bookmarks', icon: Icons.bookmark),
  CustomPopupMenu(title: 'Settings', icon: Icons.settings),
];

class _MyHomePageState extends State<MyHomePage> {
  // final _notificationsReference = Firestore.instance.collection('notifications');
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // ScrollController _scrollController;

  @override
  void initState() {
    // _scrollController = new ScrollController(                         
    //   initialScrollOffset: 0.0,                                       
    //   keepScrollOffset: true,                                        
    // );
    super.initState();
    FirebaseCloudMessaging_Listeners();
    
    
  }

  // void _toEnd() {                                                 
  //   _scrollController.animateTo(                                   
  //     _scrollController.position.maxScrollExtent,                   
  //     duration: const Duration(milliseconds: 500),                    
  //     curve: Curves.ease,                                              
  //   );                                                                
  // }   

  void FirebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) IOS_Permission();

    _firebaseMessaging.getToken().then((token){
      //set up the database with the device to receive push notifications
      
      //if device ID does exist

      //send token 
      _uploadDeviceID(token);

      //set device ID to server
      // sendJson(deviceID, token);
      // if (await _needToAdd(id: notification.id) == true) {
      //   await _save(
      //       myId: notification.id,
      //       title: notification.title,
      //       body: notification.body
      //   );
      // }

      print('token: $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void IOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }

  

  Widget _buildListTile(MyNotification notification) {
    // final record = MyNotification.fromJson(notification);
    
   return Padding(
      // key: ValueKey(record.title),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child:  NotificationTile(
          body: notification.body, 
          title: notification.title
        ),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    // var hi = myVideo();
    // print(hi.speaker);
    // final
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    TextStyle style;
    style = _setStyle();
    int _current = 0;
    // Video vid = futVideo(); //new Video(dateSpoken: 'date', id: 1, title: 'Title', imageName: 'imageNmae', speaker: 'speaker', type: 'type');
    // Video vid2 = new Video(dateSpoken: 'date', id: 1, title: 'Title2', imageName: 'imageNmae', speaker: 'speaker2', type: 'type');
    // Video vid3 = new FutureBuilder(
    //   builder: ,);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title, style: TextStyle(fontSize: 35.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
        leading: new IconButton(icon: new Icon(Icons.notifications),
          onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
            child: FutureBuilder(
              future: _getNotifications(),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      MyNotification notification = snapshot.data[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
                        child: NotificationTile(body: notification.body, title: notification.title),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
        ),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [


            // autoPlayDemo,

            // CarouselSlider(
            //   items: child,
            //   autoPlay: true,
            //   enlargeCenterPage: true,
            //   aspectRatio: 2.0,
            //   onPageChanged: (index) {
            //     setState(() {
            //       _current = index;
            //     });
            //   },
            // ),






            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Videos()));
              },
              child: Container(
                height: 200,
                child: Center(child: Text('WATCH', style: style)),
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Events()));
              },
              child: Container(
                height: 200,
                child: Center(child: Text('EVENTS', style: style)),
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
            // GestureDetector(
            //   onTap: () {
            //     openBrowser('https://www.lightyouth.org');
            //   },
            //   child: Container(
            //     height: 200,
            //     child: Center(child: Text('LIGHT GROUPS', style: style)),
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         new BoxShadow(
            //             color: Colors.black,
            //             offset: new Offset(0.0, 5.0),
            //             blurRadius: 40.0,
            //             spreadRadius: 40.0)
            //       ],
            //       image: DecorationImage(
            //         image: AssetImage('assets/images/light_groups.jpg'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Images()));
            //   },
            //   child: Container(
            //     height: 200,
            //     child: Center(child: Text('PICTURES', style: style)),
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         new BoxShadow(
            //             color: Colors.black,
            //             offset: new Offset(0.0, 5.0),
            //             blurRadius: 40.0,
            //             spreadRadius: 40.0)
            //       ],
            //       image: DecorationImage(
            //         image: AssetImage('assets/images/light_groups.jpg'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
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
            GestureDetector(
              onTap: () {
                openBrowser('https://pushpay.com/fsp/lighttotheworldchurch?t=8ac91fb4-aca3-0766-9aeb-02027b672f3e');
              },
              child: Container(
                height: 200,
                child: Center(child: Text('GIVE', style: style)),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(0.0, 5.0),
                        blurRadius: 40.0,
                        spreadRadius: 40.0)
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/pic4.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              child: Container(
                height: 200,
                child: Center(child: Text('ABOUT US', style: style)),
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.black,
                        offset: new Offset(0.0, 5.0),
                        blurRadius: 40.0,
                        spreadRadius: 30.0)
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/pic6.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ).toList(),
      ),
    );
  }

  // Widget getVids() {
  //   return FutureBuilder(
  //     future: _getVideos('All'),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemCount: snapshot.data.length,
  //           itemBuilder: (context, index) {
  //           Video video = snapshot.data[index];
  //           return Card(
  //             margin:
  //                 EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
              
  //           },
  //         );
  //       } else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  Video myVideo() {
    _getVideos('All').then((value) {
      return value;
    });
  }

  Video futVideo() {
    FutureBuilder(
      future: _getVideos('All'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
            Video video = snapshot.data[index];
            return Card(
              margin:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
              child: VideoListTile(
                video: video,
                action: () {
                },
              ));
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<Video> _getVideos(String filter) async {
    List<Video> list = new List<Video>();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/messages.php');
        //decode to json
        final usersResponse = json.decode(response.body);
        //loop throught an array of data
        for (var item in usersResponse) {
          final video = Video.fromJsonLocal(item);
          list.add(video);
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    return list[0];
  }

  openBrowser(String url) async{
    // const url = url;//'https://pushpay.com/fsp/lighttotheworldchurch?t=8ac91fb4-aca3-0766-9aeb-02027b672f3e';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  //test style for the cells
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

  Future<List<MyNotification>> _getNotifications() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/getNewNotifications.php');
        //decode to json
        final usersResponse = json.decode(response.body);
        //loop throught an array of data
        for (var item in usersResponse) {
          final notification = MyNotification.fromJsonLocal(item);

          if (await _needToAdd(id: notification.id) == true) {
            await _save(
                myId: notification.id,
                title: notification.title,
                body: notification.body
            );
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    List<MyNotification> list = await helper.queryAllNotifications();
    return list;
  }

  Future<List<MyNotification>> getLocalNotifications() async {
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    List<MyNotification> list = await helper.queryAllNotifications();
    return list;
  }

  _needToAdd({id: int}) async {
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    MyNotification notification = await helper.queryNotification(id);
    if (notification == null) {
      return true;
    } else {
      return false;
    }
  }

  _save(
      {myId: int,
      title: String,
      body: String}) async {
    MyNotification notification = MyNotification();
    notification.id = myId;
    notification.title = title;
    notification.body = body;
    NotificaionDatabaseHelper helper = NotificaionDatabaseHelper.instance;
    print(notification);
    await helper.insert(notification);
  }

  _uploadDeviceID(String token) async {
    if (await _needToAddID() == true) {
      var myID = randomAlphaNumeric(100);
      await _saveID(
          id: myID,
      );
      _sendJson(myID, token);
    } else {
      IDDatabaseHelper helper = IDDatabaseHelper.instance;
      var myId = await helper.queryID();
      _sendJsonToken(myId.myId, token);
    }
  }

  Future<void> _sendJson(String myID, String token) async {
        final paramDic = {
          "ID": '$myID', 
          "token": '$token',
        };
        await http.post(
          "https://app.lttwchurch.org/setDeviceID.php",
          body: paramDic,
        );
  }

  Future<void> _sendJsonToken(String myID, String token) async {
        // print('HRHRIRHRIHR_5');
        final paramDic = {
          "ID": '$myID', 
          "token": '$token',
        };
        await http.post(
          "https://app.lttwchurch.org/updateToken.php",
          body: paramDic,
        );
  }

  _needToAddID() async {
    IDDatabaseHelper helper = IDDatabaseHelper.instance;
    bool myId = await helper.doesExist();
    if (myId == true) {
      return false;
    } else {
      return true;
    }
  }

  _saveID({id: String}) async {
    MyId myId = MyId();
    myId.myId = id;
    IDDatabaseHelper helper = IDDatabaseHelper.instance;
    print(myId);
    await helper.insert(myId);
  }

  sendJson(String token, String myID) {

  }

  Future<List<MyEvent>> _getEvents() async {
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     //call to a remote file
    //     final response = await http.get('https://app.lttwchurch.org/events.php');
    //     //decode to json
    //     final usersResponse = json.decode(response.body);
    //     //loop throught an array of data
    //     for (var item in usersResponse) {
    //       final event = MyEvent.fromJsonLocal(item);

    //       if (await _needToAdd2(id: event.id) == true) {
    //         await _save2(
    //             myId: event.id,
    //             title: event.title,
    //             description: event.description,
    //             imageName: event.imageName,
    //             startTime: event.startTime,
    //             startDate: event.startDate,
    //             endDate: event.endDate,
    //             address: event.address
    //         );
    //       }
    //     }
    //   }
    // } on SocketException catch (_) {
    //   print('not connected');
    // }
    
    EventDatabaseHelper helper = EventDatabaseHelper.instance;
    List<MyEvent> list = await helper.queryAllEvents();
    return list;
  }

  // _needToAdd2({id: int}) async {
  //   EventDatabaseHelper helper = EventDatabaseHelper.instance;
  //   MyEvent event = await helper.queryEvent(id);
  //   if (event == null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // _save2(
  //     {myId: int, title: String, description: String, imageName: String, startTime: String, startDate: String, endDate: String, address: String}) async {
  //   MyEvent event = MyEvent();
  //   event.id = myId;
  //   event.title = title;
  //   event.description = description;
  //   event.imageName = imageName;
  //   event.startTime = startTime;
  //   event.startDate = startDate;
  //   event.endDate = endDate;
  //   event.address = address;
  //   EventDatabaseHelper helper = EventDatabaseHelper.instance;
  //   await helper.insert(event);
  // }
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});
 
  String title;
  IconData icon;
}


