import 'package:mongo_dart/mongo_dart.dart';

class TestModel {

  String firstName;
  String lastName;
  String address;

  TestModel({
    required this.firstName,
    required this.lastName,
    required this.address});

  factory TestModel.fromJson(Map<String, dynamic>json)=>
      TestModel(

          firstName: json["firstName"],
          lastName: json["lastName"],
          address: json["address"]
      );

  Map<String,dynamic> toJson()=>{
    "firstName": firstName,
    "lastName": lastName,
    "address": address
  };
}