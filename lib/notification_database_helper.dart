import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// database table and column names
final String tableNotifications = 'notification';
final String columnID = 'id';
final String columnTitle = 'title';
final String columnBody = 'body';

// data model class
class MyNotification {
  int id;
  String title;
  String body;

  MyNotification({this.id, this.title, this.body});

  MyNotification.fromMap(Map<String, dynamic> map ) :
    id = map['id'],
    title = map['title'],
    body = map['body'];

  // MyNotification.fromSnapshot(DocumentSnapshot snapshot) :
  //   this.fromMap(snapshot.data);

    // return MyNotification(
    //   id: json['id'],
    //   title: json['title'],
    //   body: json['body'],
    // );
  // }

  factory MyNotification.fromJson(Map<String, dynamic> json ) {
    return MyNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  factory MyNotification.fromJsonLocal(Map<String, dynamic> json) {
    return MyNotification(
      id: int.parse(json['id']),
      title: json['title'],
      body: json['body'],
    );
  }
  // convenience method to create a Map from this Event object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnBody: body,
    };
    if (id != null) {
      map[columnID] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class NotificaionDatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "LightYouthDatabaseNotifications.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  NotificaionDatabaseHelper._privateConstructor();
  static final NotificaionDatabaseHelper instance = NotificaionDatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database 
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableNotifications (
            $columnID INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnBody TEXT NOT NULL
          )
          ''');
  }

  // Database helper methods:
  insert(MyNotification notificaion) async {
    Database db = await database;
    await db.insert(tableNotifications, notificaion.toMap());
  }

  Future<MyNotification> queryNotification(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableNotifications,
        columns: [columnID, columnTitle, columnBody],
        where: '$columnID = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return MyNotification.fromJson(maps.first);
    }
    return null;
  }

  Future<List<MyNotification>> queryAllNotifications() async {
    final db = await database;
    // get all rows
    List<Map> result = await db.query(tableNotifications, orderBy: "ID DESC");
    List<MyNotification> notificationList = [];
    if (result.length > 0) {
      for (var item in result) {
        notificationList.add(MyNotification.fromJson(item));
      }
    }
    return notificationList;
  }
}