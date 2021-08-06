import 'package:flutter/material.dart';

class PlayerPreferences extends StatefulWidget {
  final int ?numPlayers;
  PlayerPreferences({this.numPlayers});

  @override
  _PlayerPreferencesState createState() => _PlayerPreferencesState();
}

class _PlayerPreferencesState extends State<PlayerPreferences> {
  int dropDownValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: dropDownValue,
        onChanged: (int ?newVal){
          setState(() {
            dropDownValue = newVal!;
          });
        },
        items: [
          DropdownMenuItem(
            value: 0,
            child: Text('Yellow'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('Red'),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text('Blue'),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text('Green'),
          ),
        ],
      ),
    );
  }
}