import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// database table and column names
final String tableID = 'deviceID';
final String columnID = 'id';

// data model class
class MyId {
  String myId;

  MyId({this.myId});

  // MyId.fromMap(Map<String, dynamic> map ) :
  //   id = map['id'];

  factory MyId.fromJson(Map<String, dynamic> json ) {
    return MyId(
      myId: json['id'],
    );
  }

  factory MyId.fromJsonLocal(Map<String, dynamic> json) {
    return MyId(
      myId: json['id'],
      // title: json['title'],
      // body: json['body'],
    );
  }
  // convenience method to create a Map from this Event object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnID: myId,
      // columnBody: body,
    };
    // if (id != null) {
    //   map[columnID] = id;
    // }
    return map;
  }
}

// singleton class to manage the database
class IDDatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "LightYouthDatabaseID.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  IDDatabaseHelper._privateConstructor();
  static final IDDatabaseHelper instance = IDDatabaseHelper._privateConstructor();

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
          CREATE TABLE $tableID (
            $columnID TEXT NOT NULL
          )
          ''');
  }

  // Database helper methods:
  insert(MyId id) async {
    Database db = await database;
    await db.insert(tableID, id.toMap());
  }

  Future<MyId> queryID() async {
    Database db = await database;
    List<Map> maps = await db.query(tableID,
        columns: [columnID]);
    if (maps.length > 0) {
      return MyId.fromJson(maps.first);
    }
    return null;
  }

  Future<bool> doesExist() async {
    Database db = await database;
    List<Map> maps = await db.query(tableID,
        columns: [columnID]);
    if (maps.length > 0) {
      return true;
    }
    return false;
  }
  // Future<List<MyId>> queryAllNotifications() async {
  //   final db = await database;
  //   // get all rows
  //   List<Map> result = await db.query(tableID);
  //   List<MyId> notificationList = [];
  //   if (result.length > 0) {
  //     for (var item in result) {
  //       notificationList.add(MyId.fromJson(item));
  //     }
  //   }
  //   return notificationList;
  // }
}