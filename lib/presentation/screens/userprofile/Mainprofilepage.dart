import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datekaro/data/data_providers/data_provider.dart';
import 'package:datekaro/data/models/models.dart';
import 'package:datekaro/presentation/screens/login.dart';
import 'package:datekaro/presentation/screens/userprofile/edit_profile_page.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:datekaro/presentation/widgets/profile_appbar_widget.dart';
import 'package:datekaro/presentation/widgets/user_profile._widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_image/firebase_image.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({Key? key}) : super(key: key);

  @override
  _MainProfilePageState createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String uid;
  late String userID;
  String currname = "XXX";
  String currphonenumber = "XXX";
  String about = "XXXXX";
  String age = "X";
  int hob1 = 1,
      hob2 = 1,
      hob3 = 1,
      hob4 = 1,
      hob5 = 1,
      hob6 = 1,
      hob7 = 1,
      hob8 = 1,
      hob9 = 1,
      hob10 = 1;

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

  Future<void> _getUserDetails() async {
    uid = auth.currentUser!.uid.toString();
    FirebaseFirestore.instance.collection('User').doc(uid).get().then((value) {
      setState(() {
        userID = uid;
        currname = value.data()!['UserName'].toString();
        currphonenumber = value.data()!['MobileNumber'].toString();
        about = value.data()!['Bio'].toString();
        age = value.data()!['Age'].toString();
        hob1 = value.data()!['Hobbie1'];
        hob2 = value.data()!['Hobbie2'];
        hob3 = value.data()!['Hobbie3'];
        hob4 = value.data()!['Hobbie4'];
        hob5 = value.data()!['Hobbie5'];
        hob6 = value.data()!['Hobbie6'];
        hob7 = value.data()!['Hobbie7'];
        hob8 = value.data()!['Hobbie8'];
        hob9 = value.data()!['Hobbie9'];
        hob10 = value.data()!['Hobbie10'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // ProfileWidget(
          //     imagePath:
          //         "https://pbs.twimg.com/profile_images/1372030169985163266/ceCabVlu.jpg",
          //     onClicked: () {}
          //     // => Navigator.of(context).push(
          //     // MaterialPageRoute(builder: (context) => EditProfilePage()),
          //     //),
          //     ),

          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: FirebaseImage(
                          'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image1',
                          shouldCache: true,
                          maxSizeBytes: 3000 * 1000,
                          cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
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
              Text(
                currname,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                currphonenumber,
                style: TextStyle(color: Colors.grey),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  about,
                  style: TextStyle(fontSize: 16, height: 1.4),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  age,
                  style: TextStyle(fontSize: 16, height: 1.4),
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Wrap(
                  children: [
                    if (hob1 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[0]),
                        ),
                      ),
                    // else
                    //   Container(),
                    if (hob2 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[1]),
                        ),
                      ),
                    // else
                    //   Container(),
                    if (hob3 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[2]),
                        ),
                      )
                    else
                      Container(),
                    if (hob4 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[3]),
                        ),
                      ),

                    if (hob5 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[4]),
                        ),
                      ),

                    if (hob6 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[5]),
                        ),
                      ),

                    if (hob7 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[6]),
                        ),
                      ),

                    if (hob8 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[7]),
                        ),
                      ),

                    if (hob9 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(hobbies[8]),
                        ),
                      ),

                    if (hob10 == 1)
                      Card(
                        elevation: 3,
                        color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image1',
                                shouldCache: true,
                                maxSizeBytes: 3000 * 1000,
                                cacheRefreshStrategy:
                                    CacheRefreshStrategy.NEVER),
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
                                'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image2',
                                shouldCache: true,
                                maxSizeBytes: 3000 * 1000,
                                cacheRefreshStrategy:
                                    CacheRefreshStrategy.NEVER),
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
                                'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image3',
                                shouldCache: true,
                                maxSizeBytes: 3000 * 1000,
                                cacheRefreshStrategy:
                                    CacheRefreshStrategy.NEVER),
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
                              'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image4',
                              shouldCache: true,
                              maxSizeBytes: 3000 * 1000,
                              cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
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
                              'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image5',
                              shouldCache: true,
                              maxSizeBytes: 3000 * 1000,
                              cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
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
                              'gs://datekaro-53e2b.appspot.com/ProfileImages/$uid/image6',
                              shouldCache: true,
                              maxSizeBytes: 3000 * 1000,
                              cacheRefreshStrategy: CacheRefreshStrategy.NEVER),
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
                    buttonWidth: MediaQuery.of(context).size.width / 2)),
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    },
                child: blueButton(
                    context: context,
                    label: "LogOut",
                    buttonWidth: MediaQuery.of(context).size.width / 2)),
          ),
        ],
      ),
    );
  }

  // Widget buildImage() {
  //   final image = NetworkImage(imagePath);

  //   return
  // }

  // Widget buildEditIcon(Color color) => buildCircle(
  //       color: Colors.white,
  //       all: 3,
  //       child: buildCircle(
  //         color: color,
  //         all: 8,
  //         child: Icon(
  //           isEdit ? Icons.add_a_photo : Icons.edit,
  //           color: Colors.white,
  //           size: 20,
  //         ),
  //       ),
  //     );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
