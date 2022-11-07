import 'package:taller_sqlite_flutter/data_base/crud.dart';
import 'package:taller_sqlite_flutter/data_base/tables.dart';

class Diary extends Crud{
  int id;
  String type;
  String enterCode;

  Diary({this.id=0,this.type="",this.enterCode=""}):super(diaryTable);

  @override
  String toString() {
    // TODO: implement toString
    return "\n Id: $id tipo: $type \n";
  }

  Diary toObject(Map<dynamic,dynamic>data){
    return Diary(
      id: data["id"],
      type: data["type"],
      enterCode: data["enterCode"]
    );
  }

  Map<String, dynamic>toMap(){
    print("id $id");
    return {
      "id": id>0?id:null,
      "type": type,
      "enterCode": enterCode
    };
  }

  save()async{
    return (id>0)?await update(toMap()):await create(toMap());
  }

  remove()async{
    await delete(id);
  }

  Future<List<Diary>>getDiaries()async{
    var result = await query("SELECT * FROM $diaryTable");
    return _getListObject(result);
  }

  List<Diary> _getListObject(parsed){
    return (parsed as List).map((map) => toObject(map)).toList();
  }

 Future<Diary> checkEnterCode()async{
    var result = await query("SELECT * FROM $diaryTable WHERE id=? AND enterCode=?",
    arguments: [id,enterCode]);
    return toObject(result[0]);
  }
}