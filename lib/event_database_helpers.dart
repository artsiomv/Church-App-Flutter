import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableEvents = 'events';
final String columnID = 'ID';
final String columnTitle = 'title';
final String columnDescription = 'description';
final String columnImageName = 'imageName';
final String columnStartTime = 'startTime';
final String columnStartDate = 'startDate';
final String columnEndDate = 'endDate';
final String columnAddress = 'address';

// data model class
class MyEvent {
  int id;
  String title;
  String description;
  String imageName;
  String startTime;
  String startDate;
  String endDate;
  String address;

  MyEvent({this.id, this.title, this.description, this.imageName, this.startTime, this.startDate, this.endDate, this.address});

  factory MyEvent.fromJson(Map<String, dynamic> json) {
    return MyEvent(
      id: json['ID'],
      title: json['title'],
      description: json['description'],
      imageName: json['imageName'],
      startTime: json['startTIme'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      address: json['address'],
    );
  }

  factory MyEvent.fromJsonLocal(Map<String, dynamic> json) {
    return MyEvent(
      id: int.parse(json['ID']),
      title: json['title'],
      description: json['description'],
      imageName: json['imageName'],
      startTime: json['startTIme'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      address: json['address'],
    );
  }

  // convenience method to create a Map from this Event object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDescription: description,
      columnImageName: imageName,
      columnStartTime: startTime,
      columnStartDate: startDate,
      columnEndDate: endDate,
      columnAddress: address
    };
    if (id != null) {
      map[columnID] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class EventDatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "LightYouthDatabaseEvent.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  EventDatabaseHelper._privateConstructor();
  static final EventDatabaseHelper instance = EventDatabaseHelper._privateConstructor();

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
          CREATE TABLE $tableEvents (
            $columnID INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnImageName TEXT NOT NULL,
            $columnStartTime TEXT,
            $columnStartDate TEXT,
            $columnEndDate TEXT,
            $columnAddress TEXT
          )
          ''');
  }

  insert(MyEvent event) async {
    Database db = await database;
    await db.insert(tableEvents, event.toMap());
  }

  Future<MyEvent> queryEvent(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableEvents,
        columns: [columnID, columnTitle, columnDescription, columnImageName, columnStartTime, columnStartDate, columnEndDate, columnAddress],
        where: '$columnID = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return MyEvent.fromJson(maps.first);
    }
    return null;
  }

  Future<List<MyEvent>> queryAllEvents() async {
    final db = await database;
    // get all rows
    List<Map> result = await db.query(tableEvents, orderBy: "ID DESC");
    List<MyEvent> eventList = [];
    if (result.length > 0) {
      for (var item in result) {
        eventList.add(MyEvent.fromJson(item));
      }
    }
    return eventList;
  }
}
