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
              content: Text("Liked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Nope"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("Superliked"),
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
          title: Text(
            "Get your Match",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff403b58),
          foregroundColor: Colors.white,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    //_displayDialog(context);
                  },
                  child: Icon(Icons.filter_list, color: Colors.white),
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

                          var id = user.id;
                          print(user.id);
                          print(user['UserName']);
                          print(user['Age']);
                          print(user['Bio']);
                          print(user['MobileNumber']);
                          print(user['Hobbie1']);

                          return SingleChildScrollView(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 20,
                              color: Colors.orange[200],
                              height: 500,
                              child: SingleChildScrollView(
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Image.network(
                                            "https://pbs.twimg.com/profile_images/1372030169985163266/ceCabVlu.jpg",
                                            height: 120,
                                            width: 120,
                                          ),
                                          // child: Ink.image(

                                          //   image: FirebaseImage(
                                          //       'gs://datekaro-53e2b.appspot.com/ProfileImages/$id/image1',
                                          //       shouldCache: true,
                                          //       maxSizeBytes: 3000 * 1000,
                                          //       cacheRefreshStrategy:
                                          //           CacheRefreshStrategy.NEVER),
                                          //   fit: BoxFit.cover,
                                          //   width: 128,
                                          //   height: 128,
                                          //   //child: InkWell(onTap: onClicked),
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 140),
                                          Text(
                                            user['UserName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            user['MobileNumber'].toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'About',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 0),
                                          Text(
                                            user['Bio'].toString(),
                                            style: TextStyle(
                                                fontSize: 16, height: 1.4),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            'Age',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 0),
                                          Text(
                                            user['Age'].toString(),
                                            style: TextStyle(
                                                fontSize: 16, height: 1.4),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          if (user['Gender'] == 0)
                                            Column(
                                              children: [
                                                Text(
                                                  'Gender',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 0),
                                                Text(
                                                  "Male",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.4),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          if (user['Gender'] == 1)
                                            Column(
                                              children: [
                                                Text(
                                                  'Gender',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 0),
                                                Text(
                                                  "FeMale",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.4),
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          Text(
                                            'Hobbies',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Wrap(
                                            children: [
                                              if (user['Hobbie1'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[3]),
                                                  ),
                                                ),

                                              if (user['Hobbie5'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[4]),
                                                  ),
                                                ),

                                              if (user['Hobbie6'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[5]),
                                                  ),
                                                ),

                                              if (user['Hobbie7'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[6]),
                                                  ),
                                                ),

                                              if (user['Hobbie8'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[7]),
                                                  ),
                                                ),

                                              if (user['Hobbie9'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[8]),
                                                  ),
                                                ),

                                              if (user['Hobbie10'] == 1)
                                                Card(
                                                  elevation: 3,
                                                  color: Colors.amber,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(hobbies[9]),
                                                  ),
                                                )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Center(
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    ClipOval(
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: Ink.image(
                                                          image: FirebaseImage(
                                                              'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image1',
                                                              shouldCache: true,
                                                              maxSizeBytes:
                                                                  3000 * 1000,
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
                                                        color:
                                                            Colors.transparent,
                                                        child: Ink.image(
                                                          image: FirebaseImage(
                                                              'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image2',
                                                              shouldCache: true,
                                                              maxSizeBytes:
                                                                  3000 * 1000,
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
                                                        color:
                                                            Colors.transparent,
                                                        child: Ink.image(
                                                          image: FirebaseImage(
                                                              'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image3',
                                                              shouldCache: true,
                                                              maxSizeBytes:
                                                                  3000 * 1000,
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
                                                            maxSizeBytes:
                                                                3000 * 1000,
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
                                                            maxSizeBytes:
                                                                3000 * 1000,
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
                                                            maxSizeBytes:
                                                                3000 * 1000,
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          // return SizedBox(
                          //   height: MediaQuery.of(context).size.height * 4 / 5,
                          //   child: ListView(
                          //     shrinkWrap: true,
                          //     physics: BouncingScrollPhysics(),
                          //     children: [
                          //       // Center(
                          //       //   child: Stack(
                          //       //     children: [
                          //       //       ClipOval(
                          //       //         child: Material(
                          //       //           color: Colors.transparent,
                          //       //           child: Ink.image(
                          //       //             image: FirebaseImage(
                          //       //                 'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image1',
                          //       //                 shouldCache: true,
                          //       //                 maxSizeBytes: 3000 * 1000,
                          //       //                 cacheRefreshStrategy:
                          //       //                     CacheRefreshStrategy.NEVER),
                          //       //             fit: BoxFit.cover,
                          //       //             width: 128,
                          //       //             height: 128,
                          //       //             //child: InkWell(onTap: onClicked),
                          //       //           ),
                          //       //         ),
                          //       //       )
                          //       //     ],
                          //       //   ),
                          //       // ),
                          //       const SizedBox(height: 24),
                          //       Column(
                          //         children: [
                          //           Expanded(
                          //             child: Text(
                          //               user['UserName'].toString(),
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 24),
                          //             ),
                          //           ),
                          //           const SizedBox(height: 4),
                          //           Expanded(
                          //             child: Text(
                          //               user['UserName'],
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 24),
                          //             ),
                          //           ),
                          //           SizedBox(height: 4),
                          //           Expanded(
                          //             child: Text(
                          //               user['MobileNumber'].toString(),
                          //               style: TextStyle(color: Colors.grey),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //       const SizedBox(height: 48),
                          //       Expanded(
                          //         child: Container(
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 48),
                          //           width: 200,
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 'About',
                          //                 style: TextStyle(
                          //                     fontSize: 24,
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               const SizedBox(height: 16),
                          //               Expanded(
                          //                 child: Text(
                          //                   user['Bio'].toString(),
                          //                   style: TextStyle(
                          //                       fontSize: 16, height: 1.4),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 24),
                          //       Container(
                          //         padding: EdgeInsets.symmetric(horizontal: 48),
                          //         width: 200,
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               'Age',
                          //               style: TextStyle(
                          //                   fontSize: 24,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //             const SizedBox(height: 16),
                          //             Expanded(
                          //               child: Text(
                          //                 user['Age'].toString(),
                          //                 style: TextStyle(
                          //                     fontSize: 16, height: 1.4),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       const SizedBox(height: 24),
                          //       // Container(
                          //       //   padding: EdgeInsets.symmetric(horizontal: 48),
                          //       //   child: Column(
                          //       //     crossAxisAlignment: CrossAxisAlignment.start,
                          //       //     children: [
                          //       //       Text(
                          //       //         'Hobbies',
                          //       //         style: TextStyle(
                          //       //             fontSize: 24,
                          //       //             fontWeight: FontWeight.bold),
                          //       //       ),
                          //       //       const SizedBox(height: 16),
                          //       //       Wrap(
                          //       //         children: [
                          //       //           if (user['Hobbie1'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[0]),
                          //       //               ),
                          //       //             ),
                          //       //           // else
                          //       //           //   Container(),
                          //       //           if (user['Hobbie2'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[1]),
                          //       //               ),
                          //       //             ),
                          //       //           // else
                          //       //           //   Container(),
                          //       //           if (user['Hobbie3'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[2]),
                          //       //               ),
                          //       //             )
                          //       //           else
                          //       //             Container(),
                          //       //           if (user['Hobbie4'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[3]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie5'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[4]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie6'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[5]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie7'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[6]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie8'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[7]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie9'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[8]),
                          //       //               ),
                          //       //             ),

                          //       //           if (user['Hobbie10'] == 1)
                          //       //             Card(
                          //       //               elevation: 3,
                          //       //               color: Colors.amber,
                          //       //               child: Padding(
                          //       //                 padding:
                          //       //                     const EdgeInsets.all(8.0),
                          //       //                 child: Text(hobbies[9]),
                          //       //               ),
                          //       //             )
                          //       //         ],
                          //       //       )
                          //       //     ],
                          //       //   ),
                          //       // ),
                          //       // SizedBox(
                          //       //   height: 50,
                          //       // ),
                          //       // Center(
                          //       //   child: Column(
                          //       //     children: [
                          //       //       Center(
                          //       //         child: Row(
                          //       //           children: [
                          //       //             SizedBox(
                          //       //               width: 30,
                          //       //             ),
                          //       //             ClipOval(
                          //       //               child: Material(
                          //       //                 color: Colors.transparent,
                          //       //                 child: Ink.image(
                          //       //                   image: FirebaseImage(
                          //       //                       'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image1',
                          //       //                       shouldCache: true,
                          //       //                       maxSizeBytes: 3000 * 1000,
                          //       //                       cacheRefreshStrategy:
                          //       //                           CacheRefreshStrategy
                          //       //                               .NEVER),
                          //       //                   fit: BoxFit.cover,
                          //       //                   width: 100,
                          //       //                   height: 100,
                          //       //                   //child: InkWell(onTap: onClicked),
                          //       //                 ),
                          //       //               ),
                          //       //             ),
                          //       //             ClipOval(
                          //       //               child: Material(
                          //       //                 color: Colors.transparent,
                          //       //                 child: Ink.image(
                          //       //                   image: FirebaseImage(
                          //       //                       'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image2',
                          //       //                       shouldCache: true,
                          //       //                       maxSizeBytes: 3000 * 1000,
                          //       //                       cacheRefreshStrategy:
                          //       //                           CacheRefreshStrategy
                          //       //                               .NEVER),
                          //       //                   fit: BoxFit.cover,
                          //       //                   width: 100,
                          //       //                   height: 100,
                          //       //                   //child: InkWell(onTap: onClicked),
                          //       //                 ),
                          //       //               ),
                          //       //             ),
                          //       //             ClipOval(
                          //       //               child: Material(
                          //       //                 color: Colors.transparent,
                          //       //                 child: Ink.image(
                          //       //                   image: FirebaseImage(
                          //       //                       'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image3',
                          //       //                       shouldCache: true,
                          //       //                       maxSizeBytes: 3000 * 1000,
                          //       //                       cacheRefreshStrategy:
                          //       //                           CacheRefreshStrategy
                          //       //                               .NEVER),
                          //       //                   fit: BoxFit.cover,
                          //       //                   width: 100,
                          //       //                   height: 100,
                          //       //                   //child: InkWell(onTap: onClicked),
                          //       //                 ),
                          //       //               ),
                          //       //             ),
                          //       //           ],
                          //       //         ),
                          //       //       ),
                          //       //       const SizedBox(height: 24),
                          //       //       Row(
                          //       //         children: [
                          //       //           SizedBox(
                          //       //             width: 30,
                          //       //           ),
                          //       //           ClipOval(
                          //       //             child: Material(
                          //       //               color: Colors.transparent,
                          //       //               child: Ink.image(
                          //       //                 image: FirebaseImage(
                          //       //                     'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image4',
                          //       //                     shouldCache: true,
                          //       //                     maxSizeBytes: 3000 * 1000,
                          //       //                     cacheRefreshStrategy:
                          //       //                         CacheRefreshStrategy
                          //       //                             .NEVER),
                          //       //                 fit: BoxFit.cover,
                          //       //                 width: 100,
                          //       //                 height: 100,
                          //       //                 //child: InkWell(onTap: onClicked),
                          //       //               ),
                          //       //             ),
                          //       //           ),
                          //       //           ClipOval(
                          //       //             child: Material(
                          //       //               color: Colors.transparent,
                          //       //               child: Ink.image(
                          //       //                 image: FirebaseImage(
                          //       //                     'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image5',
                          //       //                     shouldCache: true,
                          //       //                     maxSizeBytes: 3000 * 1000,
                          //       //                     cacheRefreshStrategy:
                          //       //                         CacheRefreshStrategy
                          //       //                             .NEVER),
                          //       //                 fit: BoxFit.cover,
                          //       //                 width: 100,
                          //       //                 height: 100,
                          //       //                 //child: InkWell(onTap: onClicked),
                          //       //               ),
                          //       //             ),
                          //       //           ),
                          //       //           ClipOval(
                          //       //             child: Material(
                          //       //               color: Colors.transparent,
                          //       //               child: Ink.image(
                          //       //                 image: FirebaseImage(
                          //       //                     'gs://datekaro-53e2b.appspot.com/ProfileImages/${user.id}/image6',
                          //       //                     shouldCache: true,
                          //       //                     maxSizeBytes: 3000 * 1000,
                          //       //                     cacheRefreshStrategy:
                          //       //                         CacheRefreshStrategy
                          //       //                             .NEVER),
                          //       //                 fit: BoxFit.cover,
                          //       //                 width: 100,
                          //       //                 height: 100,
                          //       //                 //child: InkWell(onTap: onClicked),
                          //       //               ),
                          //       //             ),
                          //       //           ),
                          //       //         ],
                          //       //       ),
                          //       //       const SizedBox(height: 24),
                          //       //     ],
                          //       //   ),
                          //       // ),
                          //       SizedBox(
                          //         height: 50,
                          //       ),
                          //       Center(
                          //         child: GestureDetector(
                          //             onTap: () {},
                          //             child: blueButton(
                          //                 context: context,
                          //                 label: "Edit Profile",
                          //                 buttonWidth: MediaQuery.of(context)
                          //                         .size
                          //                         .width /
                          //                     2)),
                          //       ),
                          //       SizedBox(
                          //         height: 50,
                          //       ),
                          //       Center(
                          //         child: GestureDetector(
                          //             onTap: () async => {
                          //                   await FirebaseAuth.instance
                          //                       .signOut(),
                          //                   Navigator.pushAndRemoveUntil(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               LoginPage()),
                          //                       (route) => false)
                          //                 },
                          //             child: blueButton(
                          //                 context: context,
                          //                 label: "LogOut",
                          //                 buttonWidth: MediaQuery.of(context)
                          //                         .size
                          //                         .width /
                          //                     2)),
                          //       ),
                          //     ],
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
                  }),
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
