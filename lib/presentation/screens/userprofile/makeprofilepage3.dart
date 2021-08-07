import 'dart:io';
import 'package:datekaro/presentation/screens/Dashboard/Dashboard.dart';
import 'package:datekaro/presentation/widgets/blue_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MakeProfilePage3 extends StatefulWidget {
  MakeProfilePage3();

  @override
  _MakeProfilePage3State createState() => _MakeProfilePage3State();
}

class _MakeProfilePage3State extends State<MakeProfilePage3> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var imageUrl1;
  var imageUrl2;
  var imageUrl3;
  var imageUrl4;
  var imageUrl5;
  var imageUrl6;
  var uid;

  int count = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      uid = auth.currentUser!.uid.toString();
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Compulsary!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please add atleast 2 images!!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  uploadImage1() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image1')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl1 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage2() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image2')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl2 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage3() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image3')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl3 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage4() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image4')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl4 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage5() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image5')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl5 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  uploadImage6() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await _imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProfileImages/$uid/image6')
            .putFile(file);
        // StorageReference storageReference = FirebaseStorage.instance
        //  .ref()
        //  .child('images/imageName');
        // StorageUploadTask snapshot = storageReference.putFile(image);
        // await snapshot.onComplete;
        // print('File Uploaded');
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl6 = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Images',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl1 != null)
                      ? Image.network(imageUrl1)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image1",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage1();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl2 != null)
                      ? Image.network(imageUrl2)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image2",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage2();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl3 != null)
                      ? Image.network(imageUrl3)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image3",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage3();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl4 != null)
                      ? Image.network(imageUrl4)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image4",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage4();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl5 != null)
                      ? Image.network(imageUrl5)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image5",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage5();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl6 != null)
                      ? Image.network(imageUrl6)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Upload Image6",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                onPressed: () {
                  uploadImage6();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)),
                elevation: 5.0,
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                splashColor: Colors.grey,
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: () {
                    if (imageUrl1 != null) count++;
                    if (imageUrl2 != null) count++;
                    if (imageUrl3 != null) count++;
                    if (imageUrl4 != null) count++;
                    if (imageUrl5 != null) count++;
                    if (imageUrl6 != null) count++;

                    if (count < 2) {
                      _showMyDialog();
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    }
                  },
                  child: blueButton(
                      context: context,
                      label: "Submit",
                      buttonWidth: MediaQuery.of(context).size.width / 2)),
            ],
          ),
        ),
      ),
    );
  }
}
