import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/users.dart';
import 'package:habit_tracker/view/pages/home_page.dart';
import 'package:habit_tracker/view/pages/splash_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //open the hive box for storing user information
  // await Hive.openBox<Users>('userBox');
  // Hive.registerAdapter(UsersAdapter());

  //open the hivw box for storing habits
  await Hive.openBox('taskBox');

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

