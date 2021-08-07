import 'package:datekaro/core/constants/strings.dart';
import 'package:datekaro/data/models/models.dart';
import 'package:datekaro/presentation/screens/userprofile/makeprofilepage2.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:datekaro/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class MakeProfilePage1 extends StatefulWidget {
  final String phonenumber;
  MakeProfilePage1(
    this.phonenumber,
  );
  @override
  _MakeProfilePage1State createState() => _MakeProfilePage1State();
}

class _MakeProfilePage1State extends State<MakeProfilePage1> {
  final _formKey = GlobalKey<FormState>();

  // List<String> gender = ['Male', 'Female', 'Prefer not to say'];

  final namecontroller = new TextEditingController();
  final agecontroller = new TextEditingController();
  final biocontroller = new TextEditingController();
  final gendercontroller = new TextEditingController();
  late int age;

  int dropDownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text(Strings.homeScreenCenterText),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 24),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          labelText: "Your Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: agecontroller,
                        decoration: InputDecoration(
                          hintText: "Example: 20",
                          labelText: "Age",
                        ),
                        validator: (value) {
                          var numValue = int.tryParse(value!);

                          if (numValue! < 18) {
                            return "Must be Above 18";
                          } else {
                            setState(() {
                              age = numValue;
                            });
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: biocontroller,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "About yourself",
                          labelText: "Bio",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      SingleChildScrollView(
                        child: Row(
                          children: [
                            Text("Select your Gender"),
                            SizedBox(
                              width: 60,
                            ),
                            Container(
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MakeProfilePage2(
                                          widget.phonenumber.toString(),
                                          namecontroller.text,
                                          age,
                                          biocontroller.text,
                                          dropDownValue)));
                            }
                          },
                          child: blueButton(
                              context: context,
                              label: "Next",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
