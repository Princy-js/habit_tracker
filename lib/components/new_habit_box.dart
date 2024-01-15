import 'package:flutter/material.dart';

class createNewHabit_Box extends StatelessWidget {
  final taskController;
  final String hint_text;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  createNewHabit_Box({super.key,
    required this.taskController,
    required this.hint_text,
    required this.onsave,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)),
     content: TextField(
       controller: taskController,
       decoration: InputDecoration(
         hintText: hint_text,
         border: OutlineInputBorder()
       ),
     ),
      actions: [
        MaterialButton(
          color: Colors.deepPurple,
            onPressed:onsave,
            child: Text('save',
              style: TextStyle(
              color: Colors.white
            ),),
        ),
        MaterialButton(
          color: Colors.deepPurple,
            onPressed: oncancel,
            child: Text('cancel',
              style: TextStyle(
                  color: Colors.white),),
        )
      ],
    );
  }
}
