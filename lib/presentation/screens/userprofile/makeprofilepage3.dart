import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class MakeProfilePage3 extends StatefulWidget {
  MakeProfilePage3();

  @override
  _MakeProfilePage3State createState() => _MakeProfilePage3State();
}

class _MakeProfilePage3State extends State<MakeProfilePage3> {
  late File _image;
  late String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    setState(() {
      _image = imageToFile(
              "https://www.phoca.cz/images/projects/phoca-gallery-r.png", "jpg")
          as File;
    });
  }

  Future<File> imageToFile(String imageName, String ext) async {
    var bytes = await rootBundle.load('$imageName');
    String tempPath = (await Directory.systemTemp).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  Future chooseFile() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image as File;
      });
    });
  }

  Future uploadFile() async {
    //  StorageReference storageReference = FirebaseStorage.instance
    //      .ref()
    //      .child('chats/${Path.basename(_image.path)}}');
    //  StorageUploadTask uploadTask = storageReference.putFile(_image);
    //  await uploadTask.onComplete;
    //  print('File Uploaded');
    //  storageReference.getDownloadURL().then((fileURL) {
    //    setState(() {
    //      _uploadedFileURL = fileURL;
    //    });
    //  });

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(
        "profile/${Path.basename(_image.path)}}" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Selected Image'),
            _image != null
                ? Image.asset(
                    _image.path,
                    height: 150,
                  )
                : Container(height: 150),
            _image == null
                ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile,
                    color: Colors.cyan,
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Upload File'),
                    onPressed: uploadFile,
                    color: Colors.cyan,
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Clear Selection'),
                    onPressed: () {},
                  )
                : Container(),
            Text('Uploaded Image'),
            _uploadedFileURL != null
                ? Image.network(
                    _uploadedFileURL,
                    height: 150,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
