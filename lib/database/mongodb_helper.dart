import 'dart:developer';
import 'package:work/database/database_constants.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:work/database/models/test_model.dart';

class MongoDB{

  static var db,userCollection;

  static connect() async{
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = await db.collection(COLLECTION);
  }
  static Future<String> insert(TestModel testModel) async{
    try{
      var res = await userCollection.insertOne(testModel.toJson());
      if(res.isSuccess()){
        return "Data Inserted";
      }else{
        return "There is error while the insertion of the data";
      }
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
  static Future<List<Map<String,dynamic>>> get() async{
    var data = userCollection.find().toList();
    return data;
  }

}