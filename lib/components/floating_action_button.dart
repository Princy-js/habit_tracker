import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingActionBtn extends StatelessWidget {
  final Function()? onpressed;
  const FloatingActionBtn({super.key,
    required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed:onpressed,
        child:FaIcon(FontAwesomeIcons.plus),
    );
  }
}
