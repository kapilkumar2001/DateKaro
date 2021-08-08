import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datekaro/presentation/screens/login.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
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

  var hobbies = [
    "Foobball",
    "Cricket",
    "Video Games",
    "Readding Books",
    "Surfling The Internet",
    "Chating",
    "Music",
    "Dancing",
    "Concert",
    "Food"
  ];

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User')
                      .where('Gender', isNotEqualTo: currgender)
                      // .orderBy('TutionName')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SwipeCards(
                        //itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot user = snapshot.data!.docs[index];

                          print(user.id);
                          print(user['UserName']);
                          print(user['Age']);
                          print(user['Bio']);
                          print(user['MobileNumber']);
                          print(user['Hobbie1']);

                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    ClipOval(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Ink.image(
                                          image: FirebaseImage(
                                              'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image1',
                                              shouldCache: true,
                                              maxSizeBytes: 3000 * 1000,
                                              cacheRefreshStrategy:
                                                  CacheRefreshStrategy.NEVER),
                                          fit: BoxFit.cover,
                                          width: 128,
                                          height: 128,
                                          //child: InkWell(onTap: onClicked),
                                        ),
                                      ),
                                    )
                                    // Positioned(
                                    //   bottom: 0,
                                    //   right: 4,
                                    //  // child: buildEditIcon(color),
                                    // ),
                                  ],
                                ),
                              ),

                              //     Image(
                              //   image: FirebaseImage(
                              //     'gs://bucket123/userIcon123.jpg',
                              //     shouldCache: true, // The image should be cached (default: True)
                              //     maxSizeBytes: 3000 * 1000, // 3MB max file size (default: 2.5MB)
                              //     cacheRefreshStrategy: CacheRefreshStrategy.NEVER // Switch off update checking
                              //   ),
                              //   width: 100,
                              // ),

                              const SizedBox(height: 24),
                              Column(
                                children: [
                                  Expanded(
                                    child: Text(
                                      user['UserName'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Expanded(
                                    child: Text(
                                      user['MobileNumber'].toString(),
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 48),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: Text(
                                        user['Bio'].toString(),
                                        style: TextStyle(
                                            fontSize: 16, height: 1.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Age',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: Text(
                                        user['Age'].toString(),
                                        style: TextStyle(
                                            fontSize: 16, height: 1.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hobbies',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      children: [
                                        if (user['Hobbie1'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[0]),
                                            ),
                                          ),
                                        // else
                                        //   Container(),
                                        if (user['Hobbie2'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[1]),
                                            ),
                                          ),
                                        // else
                                        //   Container(),
                                        if (user['Hobbie3'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[2]),
                                            ),
                                          )
                                        else
                                          Container(),
                                        if (user['Hobbie4'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[3]),
                                            ),
                                          ),

                                        if (user['Hobbie5'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[4]),
                                            ),
                                          ),

                                        if (user['Hobbie6'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[5]),
                                            ),
                                          ),

                                        if (user['Hobbie7'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[6]),
                                            ),
                                          ),

                                        if (user['Hobbie8'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[7]),
                                            ),
                                          ),

                                        if (user['Hobbie9'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[8]),
                                            ),
                                          ),

                                        if (user['Hobbie10'] == 1)
                                          Card(
                                            elevation: 3,
                                            color: Colors.amber,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(hobbies[9]),
                                            ),
                                          )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 50,
                              ),

                              Center(
                                child: Column(
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: FirebaseImage(
                                                    'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image1',
                                                    shouldCache: true,
                                                    maxSizeBytes: 3000 * 1000,
                                                    cacheRefreshStrategy:
                                                        CacheRefreshStrategy
                                                            .NEVER),
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                //child: InkWell(onTap: onClicked),
                                              ),
                                            ),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: FirebaseImage(
                                                    'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image2',
                                                    shouldCache: true,
                                                    maxSizeBytes: 3000 * 1000,
                                                    cacheRefreshStrategy:
                                                        CacheRefreshStrategy
                                                            .NEVER),
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                //child: InkWell(onTap: onClicked),
                                              ),
                                            ),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Ink.image(
                                                image: FirebaseImage(
                                                    'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image3',
                                                    shouldCache: true,
                                                    maxSizeBytes: 3000 * 1000,
                                                    cacheRefreshStrategy:
                                                        CacheRefreshStrategy
                                                            .NEVER),
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                //child: InkWell(onTap: onClicked),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Ink.image(
                                              image: FirebaseImage(
                                                  'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image4',
                                                  shouldCache: true,
                                                  maxSizeBytes: 3000 * 1000,
                                                  cacheRefreshStrategy:
                                                      CacheRefreshStrategy
                                                          .NEVER),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              //child: InkWell(onTap: onClicked),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Ink.image(
                                              image: FirebaseImage(
                                                  'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image5',
                                                  shouldCache: true,
                                                  maxSizeBytes: 3000 * 1000,
                                                  cacheRefreshStrategy:
                                                      CacheRefreshStrategy
                                                          .NEVER),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              //child: InkWell(onTap: onClicked),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Ink.image(
                                              image: FirebaseImage(
                                                  'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image6',
                                                  shouldCache: true,
                                                  maxSizeBytes: 3000 * 1000,
                                                  cacheRefreshStrategy:
                                                      CacheRefreshStrategy
                                                          .NEVER),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              //child: InkWell(onTap: onClicked),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: GestureDetector(
                                    onTap: () {},
                                    child: blueButton(
                                        context: context,
                                        label: "Edit Profile",
                                        buttonWidth:
                                            MediaQuery.of(context).size.width /
                                                2)),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: GestureDetector(
                                    onTap: () async => {
                                          await FirebaseAuth.instance.signOut(),
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                              (route) => false)
                                        },
                                    child: blueButton(
                                        context: context,
                                        label: "LogOut",
                                        buttonWidth:
                                            MediaQuery.of(context).size.width /
                                                2)),
                              ),
                            ],
                          );

                          // return Container(
                          //   alignment: Alignment.center,
                          //   color: Colors.orange[300],
                          //   child: Text(
                          //     user['UserName'].toString(),
                          //     style: TextStyle(fontSize: 100),
                          //   ),
                          // );
                        },
                        matchEngine: _matchEngine,
                        onStackFinished: () {
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Text("Stack Finished"),
                            duration: Duration(milliseconds: 500),
                          ));
                        },
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        !snapshot.hasData) {
                      // Handle no data
                      return Center(
                        child: Text("No users found."),
                      );
                    } else {
                      // Still loading
                      return CircularProgressIndicator();
                    }
                  }

                  //     (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  //   if (!snapshot.hasData) {
                  //     return Center(
                  //         child: Center(
                  //       child: new Text("No Profiles Available, change the filter"),
                  //     ));
                  //   }
                  //   var name = "name not available";
                  //   snapshot.data!.docs.map((doc) {
                  //     name = doc['UserName'].toString();
                  //   });
                  //   return SwipeCards(
                  //     matchEngine: _matchEngine,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Container(
                  //         child: Center(
                  //           child: Text(name),
                  //         ),
                  //       );
                  //     },
                  //     onStackFinished: () {
                  //       _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  //         content: Text("Stack Finished"),
                  //         duration: Duration(milliseconds: 500),
                  //       ));
                  //     },
                  //   );
                  // }
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.nope();
                      },
                      child: Text("Nope")),
                  RaisedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.superLike();
                      },
                      child: Text("Superlike")),
                  RaisedButton(
                      onPressed: () {
                        _matchEngine.currentItem!.like();
                      },
                      child: Text("Like"))
                ],
              )
            ],
          ),
        ));
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
