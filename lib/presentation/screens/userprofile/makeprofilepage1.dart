import 'package:datekaro/core/constants/strings.dart';
import 'package:datekaro/data/models/models.dart';
import 'package:datekaro/presentation/screens/userprofile/makeprofilepage2.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:datekaro/presentation/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class MakeProfilePage1 extends StatefulWidget {
  const MakeProfilePage1(
    String text, {
    Key? key,
  });

  @override
  _MakeProfilePage1State createState() => _MakeProfilePage1State();
}

class _MakeProfilePage1State extends State<MakeProfilePage1> {
  final _formKey = GlobalKey<FormState>();

   List<String> location = ['One', 'Two', 'Three', 'Four'];

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
                        decoration: InputDecoration(
                          hintText: "Example: 20",
                          labelText: "Age",
                        ),
                        validator: (value) {
                          var numValue = int.tryParse(value!);
                          
                          if (numValue!<18) {
                            return "Must be Above 18";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
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
                    Row(
                      children: [
                        Text(
                          "Select your Gender"
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Container(
                        child: PlayerPreferences(),
                      ),
                      ], 
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
                                      builder: (context) => MakeProfilePage2() )
                                          );
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
