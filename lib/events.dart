import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'event_database_helpers.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'event_list_tile.dart';
import 'event_detail_screen.dart';
import 'dart:io';

class Events extends StatelessWidget {
  Events({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(title: Text('Events'),),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                MyEvent event = snapshot.data[index];
                return Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  child: EventListTile(
                    event: event,
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailsScreen(event: event)
                        )
                      );
                    },
                  ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<MyEvent>> _getEvents() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //call to a remote file
        final response = await http.get('https://app.lttwchurch.org/events.php');
        //decode to json
        final usersResponse = json.decode(response.body);
        //loop throught an array of data
        for (var item in usersResponse) {
          final event = MyEvent.fromJsonLocal(item);

          if (await _needToAdd(id: event.id) == true) {
            await _save(
                myId: event.id,
                title: event.title,
                description: event.description,
                imageName: event.imageName,
                startTime: event.startTime,
                startDate: event.startDate,
                endDate: event.endDate,
                address: event.address
            );
          }
        }
      }
    } on SocketException catch (_) {
      print('not connected');
    }
    
    EventDatabaseHelper helper = EventDatabaseHelper.instance;
    List<MyEvent> list = await helper.queryAllEvents();
    return list;
  }

  Future<List<MyEvent>> getLocalEvents() async {
    EventDatabaseHelper helper = EventDatabaseHelper.instance;
    List<MyEvent> list = await helper.queryAllEvents();
    return list;
  }

  _needToAdd({id: int}) async {
    EventDatabaseHelper helper = EventDatabaseHelper.instance;
    MyEvent event = await helper.queryEvent(id);
    if (event == null) {
      return true;
    } else {
      return false;
    }
  }

  _save(
      {myId: int, title: String, description: String, imageName: String, startTime: String, startDate: String, endDate: String, address: String}) async {
    MyEvent event = MyEvent();
    event.id = myId;
    event.title = title;
    event.description = description;
    event.imageName = imageName;
    event.startTime = startTime;
    event.startDate = startDate;
    event.endDate = endDate;
    event.address = address;
    EventDatabaseHelper helper = EventDatabaseHelper.instance;
    await helper.insert(event);
  }
}
