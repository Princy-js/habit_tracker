import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsBtn;
  final Function(BuildContext)? deleteBtn;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsBtn,
    required this.deleteBtn
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed:settingsBtn,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.grey,
                icon: Icons.settings,
              ),
              SlidableAction(
                onPressed: deleteBtn,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.red.shade400,
                icon: Icons.delete,
              )
            ]),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                  value: habitCompleted,
                  onChanged: onChanged),
              Text(habitName),
            ],
          ),
        ),
      ),
    );
  }
}
