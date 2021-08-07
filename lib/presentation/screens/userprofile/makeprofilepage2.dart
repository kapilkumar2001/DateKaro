import 'package:datekaro/data/net/firebase.dart';
import 'package:datekaro/presentation/screens/Dashboard/swipeformatchpage.dart';
import 'package:datekaro/presentation/screens/userprofile/makeprofilepage3.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:flutter/material.dart';

class MakeProfilePage2 extends StatefulWidget {
  final String phonenumber;
  final String name;
  final int age;
  final String bio;
  final int gender;
  MakeProfilePage2(
    this.phonenumber,
    this.name,
    this.age,
    this.bio,
    this.gender,
  );
  @override
  _MakeProfilePage2State createState() => _MakeProfilePage2State();
}

class _MakeProfilePage2State extends State<MakeProfilePage2> {
  List<Map> availableHobbies = [
    {"name": "Foobball", "isChecked": false, "index": 0},
    {"name": "Cricket", "isChecked": false, "index": 1},
    {"name": "Video Games", "isChecked": false, "index": 2},
    {"name": "Readding Books", "isChecked": false, "index": 3},
    {"name": "Surfling The Internet", "isChecked": false, "index": 4},
    {"name": "Chating", "isChecked": false, "index": 5},
    {"name": "Music", "isChecked": false, "index": 6},
    {"name": "Dancing", "isChecked": false, "index": 7},
    {"name": "Concert", "isChecked": false, "index": 8},
    {"name": "Food", "isChecked": false, "index": 9}
  ];
  var hob = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Karo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Choose your hobbies:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Column(
                children: availableHobbies.map((hobby) {
              return CheckboxListTile(
                  value: hobby["isChecked"],
                  title: Text(hobby["name"]),
                  onChanged: (newValue) {
                    setState(() {
                      hobby["isChecked"] = newValue;
                    });
                  });
            }).toList()),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Wrap(
              children: availableHobbies.map((hobby) {
                if (hobby["isChecked"] == true) {
                  setState(() {
                    hob[hobby["index"]] = 1;
                  });
                  return Card(
                    elevation: 3,
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(hobby["name"]),
                    ),
                  );
                }
                return Container();
              }).toList(),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  userSetup(
                      widget.name.toString(),
                      widget.phonenumber.toString(),
                      widget.age,
                      widget.bio.toString(),
                      widget.gender,
                      hob[0],
                      hob[1],
                      hob[2],
                      hob[3],
                      hob[4],
                      hob[5],
                      hob[6],
                      hob[7],
                      hob[8],
                      hob[9]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SwipeForMatchPage()));
                },
                child: blueButton(
                    context: context,
                    label: "Next",
                    buttonWidth: MediaQuery.of(context).size.width / 2)),
          ]),
        ),
      ),
    );
  }
}
