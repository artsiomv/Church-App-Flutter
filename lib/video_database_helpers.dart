import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// database table and column names
final String tableVideos = 'videos';
final String columnID = 'ID';
final String columnTitle = 'title';
final String columnVideoURL = 'videoURL';
final String columnImageName = 'imageName';
final String columnSpeaker = 'speaker';
final String columnDateSpoken = 'dateSpoken';
final String columnType = 'type';

// data model class
class Video {
  int id;
  String title;
  String videoURL;
  String imageName;
  String speaker;
  String dateSpoken;
  String type;

  Video({this.id, this.title, this.videoURL, this.imageName, this.speaker, this.dateSpoken, this.type});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['ID'],
      title: json['title'],
      videoURL: json['videoURL'],
      imageName: json['imageName'],
      speaker: json['speaker'],
      dateSpoken: json['dateSpoken'],
      type: json['type']
    );
  }

  factory Video.fromJsonLocal(Map<String, dynamic> json) {
    return Video(
      id: int.parse(json['ID']),
      title: json['title'],
      videoURL: json['videoURL'],
      imageName: json['imageName'],
      speaker: json['speaker'],
      dateSpoken: json['dateSpoken'],
      type: json['type']
    );
  }

  // convenience method to create a Map from this Video object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnVideoURL: videoURL,
      columnImageName: imageName,
      columnSpeaker: speaker,
      columnDateSpoken: dateSpoken,
      columnType: type
    };
    if (id != null) {
      map[columnID] = id;
    }
    return map;
  }
}

// singleton class to manage the database
class VideoDatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "LightYouthDatabaseVideo.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  VideoDatabaseHelper._privateConstructor();
  static final VideoDatabaseHelper instance = VideoDatabaseHelper._privateConstructor();

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
          CREATE TABLE $tableVideos (
            $columnID INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnVideoURL TEXT NOT NULL,
            $columnImageName TEXT NOT NULL,
            $columnSpeaker TEXT NOT NULL,
            $columnDateSpoken TEXT NOT NULL,
            $columnType TEXT NOT NULL
          )
          ''');
  }

  // Database helper methods:
  insert(Video video) async {
    Database db = await database;
    await db.insert(tableVideos, video.toMap());
  }

  Future<Video> queryVideo(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableVideos,
        columns: [columnID, columnTitle, columnVideoURL, columnImageName, columnSpeaker, columnDateSpoken, columnType],
        where: '$columnID = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Video.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Video>> queryAllVideos() async {
    final db = await database;
    // get all rows
    List<Map> result = await db.query(tableVideos, orderBy: "ID DESC");
    List<Video> videoList = [];
    if (result.length > 0) {
      for (var item in result) {
        videoList.add(Video.fromJson(item));
      }
    }
    return videoList;
  }

  Future<List<Video>> queryFilteredVideos(String type) async {
    final db = await database;
    // get all rows
    List<Map> result = await db.query(tableVideos, where: '$columnType = ?', whereArgs: [type], orderBy: "ID DESC");
    List<Video> videoList = [];
    if (result.length > 0) {
      for (var item in result) {
        videoList.add(Video.fromJson(item));
      }
    }
    return videoList;
  }
}