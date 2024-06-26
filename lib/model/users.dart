import 'package:hive_flutter/hive_flutter.dart';
part 'users.g.dart';
//first adapter class
@HiveType(typeId: 0)
class Users{
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? password;

  @HiveField(3)
  String? id;

  Users({this.name,required this.email,required this.password}){
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
}