import 'package:habit_tracker/model/users.dart';
import 'package:hive/hive.dart';

class UsersHiveDb{
  UsersHiveDb._users();//named constructor
  static UsersHiveDb user_instance = UsersHiveDb._users();//Object creation

 //facory constructor
 factory UsersHiveDb(){
   return user_instance;
 }

  Future<void>addUser(Users user) async{
   final db = await Hive.openBox<Users>('userBox');
   db.put(user.id, user); //add email, name and password to the hive
  }

  Future<List<Users>>getUsers() async{
   final db = await Hive.openBox<Users>('userBox');
   return db.values.toList();
  }
}