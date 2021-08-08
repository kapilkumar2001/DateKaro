import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(
    String userName,
    String mobile,
    int age,
    String bio,
    int gender,
    int hobbie1,
    int hobbie2,
    int hobbie3,
    int hobbie4,
    int hobbie5,
    int hobbie6,
    int hobbie7,
    int hobbie8,
    int hobbie9,
    int hobbie10) async {
  CollectionReference users = FirebaseFirestore.instance.collection('User');

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({
    'UserName': userName,
    'MobileNumber': mobile,
    'Age': age,
    'Bio': bio,
    'Gender': gender,
    'Hobbie1': hobbie1,
    'Hobbie2': hobbie2,
    'Hobbie3': hobbie3,
    'Hobbie4': hobbie4,
    'Hobbie5': hobbie5,
    'Hobbie6': hobbie6,
    'Hobbie7': hobbie7,
    'Hobbie8': hobbie8,
    'Hobbie9': hobbie9,
    'Hobbie10': hobbie10,
    'LikedProfiles': []
  });
  return;
}

Future<void> userConnection(String user1ID, String user2ID) async {
  CollectionReference connection =
      FirebaseFirestore.instance.collection('User');

  print("connection => firebase run hua");

  connection.doc(user1ID).update({
    'LikedProfiles': FieldValue.arrayUnion([user2ID])
  });
  return;
}

Future<void> matchingmatching(String user1ID, String user2ID) async {
  CollectionReference connection =
      FirebaseFirestore.instance.collection('User');

  print("matching => firebase run hua");

  connection.doc(user1ID).update({
    'MatchedProfiles': FieldValue.arrayUnion([user2ID])
  });
  return;
}
