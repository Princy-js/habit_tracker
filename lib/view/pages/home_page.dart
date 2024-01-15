import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/components/floating_action_button.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary/monthly_summary_Hmap.dart';
import 'package:habit_tracker/components/new_habit_box.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDataBase db = HabitDataBase();
  final _myhBox = Hive.box('taskBox');

  @override
  void initState() {
    //if  it is the first time to open App
    if(_myhBox.get('CURRENT_HABIT_LIST') == null){
       db.createDefaultdata();
    }
    //if there exists data, this is not the first time
    else{
       db.loadData();
    }

    //updating the database
    db.updateDataBase();
    super.initState();
  }

 //method for checkbox tapped
  void checkBoxTapped(bool? value, int index){
   setState(() {
     db.habitlist[index][1] = value;
   });
   db.updateDataBase();
  }

  //create a new habit
 final _newHabitController = TextEditingController();
 void addNewHabit(){
 showDialog(
     context: context,
     builder: (context){
     return createNewHabit_Box(
         taskController: _newHabitController,
         hint_text: 'Enter habit name',
         onsave: saveHabit,
         oncancel:cancelHabit,
          );
      }
   );
 }
 //save new habit
 void saveHabit(){
    //add new habit to tha habit list
   setState(() {
     db.habitlist.add([_newHabitController.text,false]);
   });
   //to clear value of textfield
   _newHabitController.clear();
   //to close alert box
   Get.back();
   db.updateDataBase();
 }

 //cancel new habit
 void cancelHabit(){
   _newHabitController.clear();
   Get.back();
   // db.updateDataBase();
 }

 //settings function for editing habit
 void openSettings(int index){
   showDialog(
       context: context,
       builder: (context){
        return createNewHabit_Box(
            taskController: _newHabitController,
            hint_text: db.habitlist[index][0],
            onsave: () => saveExistingHabit(index),
            oncancel: cancelHabit,
             );
       });
 }
 // save the existing habit with new name
 void saveExistingHabit(int index){
   setState(() {
     db.habitlist[index][0] = _newHabitController.text;
   });
   _newHabitController.clear();
   Get.back();
   db.updateDataBase();
 }
 //delete the habit
 void deleteHabit(int index){
   setState(() {
     db.habitlist.removeAt(index);
   });
   db.updateDataBase();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionBtn(
        onpressed: () => addNewHabit(),),
      backgroundColor: Colors.grey[300],
      body:ListView(
        children: [
          MyCalender(
            datasets_c: db.heatMapDataSet,
            startDate:_myhBox.get('START_DATE') ,),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:db.habitlist.length ,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.habitlist[index][0],
                habitCompleted: db.habitlist[index][1],
                onChanged:(value)=>checkBoxTapped(value,index),
                settingsBtn: (context) =>openSettings(index),
                deleteBtn: (context) => deleteHabit(index), );
            },

          ) ,
        ],
      )
    );
  }
}


