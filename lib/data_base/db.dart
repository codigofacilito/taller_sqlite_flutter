import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:taller_sqlite_flutter/data_base/tables.dart';
class Db{
  String name = "DiaryApp";
  int version = 1;

  Future<Database> open()async{
    String path = join(await getDatabasesPath(),name);
    return openDatabase(path,
    version: version,
     onConfigure:  onConfigure,
      onCreate: onCreate
    );
  }

  onCreate(Database db,int version)async{
    for(var scrip in tables){
      await db.execute(scrip);
    }
  }

  onConfigure(Database db)async{
   await db.execute("PRAGMA foreign_keys = ON");
  }

}