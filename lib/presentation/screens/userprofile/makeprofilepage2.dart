import 'package:datekaro/presentation/screens/Dashboard/swipeformatchpage.dart';
import 'package:datekaro/presentation/screens/userprofile/makeprofilepage3.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:flutter/material.dart';

class MakeProfilePage2 extends StatefulWidget {
  const MakeProfilePage2({ Key? key }) : super(key: key);

  @override
  _MakeProfilePage2State createState() => _MakeProfilePage2State();
}

class _MakeProfilePage2State extends State<MakeProfilePage2> {
  List<Map> availableHobbies = [
    {
      "name": "Foobball",
      "isChecked": false
    },
    {
      "name": "Baseball",
      "isChecked": false
    },
    {
      "name": "Video Games",
      "isChecked": false, 
    },
    {
      "name": "Readding Books",
      "isChecked": false
    },
    {
      "name": "Surfling The Internet",
      "isChecked": false
    }
  ];
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
                            
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SwipeForMatchPage() )
                                          );
                            },
                          
                          child: blueButton(
                              context: context,
                              label: "Next",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2)),
          ]),
        ),
      ),
    );
  }
}