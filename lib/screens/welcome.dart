import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var singleUserInfo;

  void getUser() async {
    print(widget.id);
    var findUser = await db.collection("users").where({"id": widget.id}).get();
    var getInfo = findUser.docs.map((user) => jsonDecode(jsonEncode(user.data())));

    setState(() {
      singleUserInfo = getInfo.toList();
      print(getInfo.toList());
    });
  }

  @override
  void initState() {
   

    super.initState();
    //  getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
      body:Center(
              child: Text("Welcome ${widget.id}", style: TextStyle(fontSize: 18),),
            )
          
    );
  }
}
