import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/components/date_and_time/date_time.dart';

class MyCalender extends StatelessWidget {
  final Map<DateTime,int>? datasets_c;
  final String startDate;

  const MyCalender({
     super.key,
     required this.datasets_c,
     required this.startDate
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.only(top: 25,bottom: 25,left: 15,right: 15),
        child: HeatMap(
          startDate: createDateTimeObject(startDate),
          endDate: DateTime.now().add(Duration(days: 47)),
          datasets: datasets_c,
          colorMode: ColorMode.color,
          defaultColor: Colors.grey[200],
          textColor: Colors.white,
          showColorTip: false,
          showText: true,
          scrollable: true,
          size: 30,
          colorsets: const {
             1: Color.fromARGB(20, 2, 179, 8),
             2: Color.fromARGB(40, 2, 179, 8),
             3: Color.fromARGB(60, 2, 179, 8),
             4: Color.fromARGB(80, 2, 179, 8),
             5: Color.fromARGB(100, 2, 179, 8),
             6: Color.fromARGB(120, 2, 179, 8),
             7: Color.fromARGB(150, 2, 179, 8),
             8: Color.fromARGB(180, 2, 179, 8),
             9: Color.fromARGB(220, 2, 179, 8),
            10: Color.fromARGB(255, 2, 179, 8),
          },
          onClick: (value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.toString())));
          },
        ),
      );
  }
}
