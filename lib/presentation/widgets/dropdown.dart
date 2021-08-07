import 'package:flutter/material.dart';

class GenderPreferences extends StatefulWidget {
  final int? numPlayers;
  GenderPreferences({this.numPlayers});

  @override
  _GenderPreferencesState createState() => _GenderPreferencesState();
}

class _GenderPreferencesState extends State<GenderPreferences> {
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: dropDownValue,
        onChanged: (int? newVal) {
          setState(() {
            dropDownValue = newVal!;
          });
        },
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text('Male'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Female'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Prefer not to say'),
          ),
        ],
      ),
    );
  }
}
