import 'package:habit_tracker/components/date_and_time/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

//reference our box
final _myhBox = Hive.box('taskBox');

class HabitDataBase {
  List habitlist = [];
  Map<DateTime,int> heatMapDataSet = {};

  //create initial default data
  void createDefaultdata(){
    habitlist = [
      ['Do Excersice',false],
      ['Read book',false],
    ];

    _myhBox.put('START_DATE', todaysDateFormatted());
  }

  //load the data if it exists already
  void loadData(){
   //check if it is a new day, get habit list from database
   if(_myhBox.get(todaysDateFormatted()) == null){
     habitlist = _myhBox.get('CURRENT_HABIT_LIST');
     //set all habit completed to false since it's a new day
     for(int i = 0; i < habitlist.length; i++){
       habitlist[i][1] = false;
     }
   }
   //check if it is not a new day, load todays list
   else{
    //load today's list
    habitlist = _myhBox.get(todaysDateFormatted());
   }
  }

  //update the database
  void updateDataBase(){
     // update todays enrty
    _myhBox.put(todaysDateFormatted(), habitlist);

    // update the habit list in case it changed (new habit, edit habit, delete habit)
    _myhBox.put('CURRENT_HABIT_LIST', habitlist);

    // calculate habit complete percentages for each day
    calculateHabitPercentages();

    // load heat map calender
    loadHeatMap();
  }

  void calculateHabitPercentages(){
    int countCompleted = 0;
    for(int i = 0; i < habitlist.length; i++){
      if(habitlist[i][1] == true){
        countCompleted++;
      }
    }

    String percent = habitlist.isEmpty
    ? '0.0'
    :(countCompleted / habitlist.length).toStringAsFixed(1);

    // key: 'PERCENTAGE_SUMMARY_yyyymmdd'
    // value: string of 1dp number between 0.0 - 0.1 inclusive
    _myhBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percent);
  }

  void loadHeatMap(){
   DateTime startDate = createDateTimeObject(_myhBox.get('START_DATE'));

   //count the number of days to load
   int daysInBtwn = DateTime.now().difference(startDate).inDays;

   //go from start date to today and add each percentage to the dataset
   // 'PERCENTAGE_SUMMARY_yyyymmdd' will be the key in the database
   for(int i = 0; i < daysInBtwn +1; i++){
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double stregnthAsPercent = double.parse(
        _myhBox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0',
      );

      // split the datetime up like below so it doesn't worry about hours/minutes/seconds etc.

     // year
     int year = startDate.add(Duration(days: i)).year;

     // month
     int month = startDate.add(Duration(days: i)).month;

     // day
     int day = startDate.add(Duration(days: i)).day;

     final percentageForEachDay = <DateTime, int>{
       DateTime(year,month,day):(10 * stregnthAsPercent).toInt(),
     };
     heatMapDataSet.addEntries(percentageForEachDay.entries);
     print(heatMapDataSet);
   }
  }
}
