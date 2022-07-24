import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_send/screens/welcome.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var emailController = TextEditingController();
  var firstController = TextEditingController();
  var idController = TextEditingController();
  var ageController = TextEditingController();
  var userInfoCheck;
  var _fileName;
  var path;
  var fileName;
  PlatformFile? pickedFile;
  File? fileDisplay;

  List<PlatformFile> files = [];
  static FirebaseStorage _storage = FirebaseStorage.instance;

  // add user function

  Future<String> addUserData() async {
    var userId = await db.collection('users').doc(idController.text);

    var userInfo = {
      "id": userId.id,
      "email": emailController.text,
      "first": firstController.text,
      "age": ageController.text
    };

    var added = userId.set(userInfo);

    // var getById = await db.collection("users").where({"id": userId.id}).get();

    // var userData = getById.docs.map((data) => data.data());
    // setState(() {
    //   userInfoCheck = userData.toList();
    // });
    // var checkId = userInfoCheck[0]!["id"];

    return userId.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView(
        children: [
          TextField(
            controller: emailController,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: firstController,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: 'First Name'),
          ),
          TextField(
            controller: idController,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: 'ID'),
          ),
          TextField(
            controller: ageController,
            textAlign: TextAlign.start,
            decoration: InputDecoration(hintText: 'Age'),
          ),
          ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform
                    .pickFiles(type: FileType.any, allowMultiple: false);
                if (result == null) return;

                if (result != null) {
                  _fileName = result.files.first.name;
                  setState(() {
                    pickedFile = result.files.first;
                    fileDisplay = File(pickedFile!.path.toString());
                    path = result.files.single.path;
                    fileName = result.files.single.name;
                    Reference ref = _storage.ref().child("images/${fileName}");
                    UploadTask uploadTask = ref.putFile(File(path!));
                    print(pickedFile!.path.toString());

                    uploadTask.then((res) {
                      res.ref.getDownloadURL();
                      print("done");
                    });
                  });
                }
              },
              child: Text("Add file")),
          if (pickedFile != null)
            SizedBox(
              width: 300,
              height: 300,
              child: Image.file(fileDisplay!),
            ),
          TextButton(
              onPressed: () async {
                var userId =
                    await db.collection('users').doc(idController.text);

                var userInfo = {
                  "id": userId.id,
                  "email": emailController.text,
                  "first": firstController.text,
                  "age": ageController.text
                };

                var added = await userId.set(userInfo);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Welcome(id: emailController.text)));
              },
              child: Text("Submit"))
        ],
      )),
    );
  }
}
