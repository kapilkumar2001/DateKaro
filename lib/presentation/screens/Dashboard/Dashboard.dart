import 'package:datekaro/presentation/screens/userprofile/Mainprofilepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static const List<Widget> _tabs = <Widget>[
    Center(
      child: Text(
        'Swipe page',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Chat',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    MainProfilePage(),
  ];

  List<BottomNavigationBarItem> _item = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: "Home",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "Chat",
        backgroundColor: Colors.black),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person),
        label: "Profile",
        backgroundColor: Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        // elevation: Sizes.dimen_200,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(Sizes.dimen_16),
        //     topRight: Radius.circular(Sizes.dimen_16),
        //   ),
        child: Container(
          child: _tabs.elementAt(_currentIndex),
        ),
      ),
      bottomNavigationBar:
          // Container(
          //   decoration: BoxDecoration(
          //      borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(30),
          //       topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          //   boxShadow: [
          //     BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          //   ],
          //   ),

          ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          items: _item,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white38,
          onTap: _onTapped,
          backgroundColor: Colors.white38,
        ),
      ),
      // ),
    );
  }
}
