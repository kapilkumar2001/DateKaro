import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:velocity_x/velocity_x.dart';

class Content {
  final String? text;
  final Color? color;

  Content({this.text, this.color});
}

class SwipePage extends StatefulWidget {
  const SwipePage();
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
  var currgender;

  @override
  void initState() {
    uid = auth.currentUser!.uid.toString();
    FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
      setState(() {
        currgender = value.data()!['Gender'].toString();
      });
    });

    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Get your Match"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    //_displayDialog(context);
                  },
                  child: Icon(Icons.filter_list),
                )),
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .where('Gender', isNotEqualTo: currgender)
                // .orderBy('TutionName')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Center(
                  child: new Text("No Profiles Available, change the filter"),
                ));
              }
              var name = "name not available";
              snapshot.data!.docs.map((doc) {
                name = doc['UserName'].toString();
              });
              return SwipeCards(
                matchEngine: _matchEngine,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Center(
                      child: Text(name),
                    ),
                  );
                },
                onStackFinished: () {
                  _scaffoldKey.currentState!.showSnackBar(SnackBar(
                    content: Text("Stack Finished"),
                    duration: Duration(milliseconds: 500),
                  ));
                },
              );
            }));
  }
}

// Container(
//     child: Column(children: [
//   Container(
//     height: 550,
//     child: SwipeCards(
//       matchEngine: _matchEngine,

//       itemBuilder: StreamBuilder(
//         stream: FirebaseFirestore.instance
//           .collection('User')
//           .where('Gender', isNotEqualTo: currgender)
//           // .orderBy('TutionName')
//           .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//                 child: Center(
//               child:
//                   new Text("No Profiles available"),
//             )
//                 //CircularProgressIndicator(),
//                 );
//           }
//           return Container(
//                 alignment: Alignment.center,
//                   color: Vx.yellow100,
//                   child: Text(
//                     snapshot.data!.docs.asMap()["UserName"].toString(),
//                     style: TextStyle(fontSize: 100),
//                   ),
//              );

//         }
//       ),
// itemBuilder: (BuildContext context, int index) {
//   return
//   // Container(
//   //   alignment: Alignment.center,
//   //   color: _swipeItems[index].content.color,
//   //   child: Text(
//   //     _swipeItems[index].content.text,
//   //     style: TextStyle(fontSize: 100),
//   //   ),
//   // );
// },
//
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine.currentItem?.nope();
//                   },
//                   child: Text("Nope")),
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine.currentItem?.superLike();
//                   },
//                   child: Text("Superlike")),
//               ElevatedButton(
//                   onPressed: () {
//                     _matchEngine.currentItem?.like();
//                   },
//                   child: Text("Like"))
//             ],
//           )
//         ])));
//   }
// }
