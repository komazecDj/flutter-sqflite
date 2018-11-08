import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'main.db');
    Database ourDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)');
    print('table created');
  }

  //insertion
  Future<int> saveUser(User user) async {
    Database dbClient = await db;
    int res = await dbClient.insert('User', user.toMap());
    print('user saved');
    return res; 
  }

  //getAll  
  Future<List<Map>> getUsers() async {
    Database dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    print(list);
    return list;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    Database dbClient = await db;
    int res = await dbClient.delete('User');
    return res; 
  }
}