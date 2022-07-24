import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_send/screens/addUser.dart';
import 'package:data_send/screens/fileupload.dart';
import 'package:data_send/screens/quizQues.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: fileUpload(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void _incrementCounter() async {
    // db.collection("users").add(user).then((DocumentReference doc) =>
    //     print('DocumentSnapshot added with ID: ${doc.id}'));

// send data to firebase with own id
    final userid = db.collection("users").doc('myid');
    final user = {
      "id": userid.id,
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    await userid.set(user);

    //  read data from firebase by any query

    // var dataAll =
    //     await db.collection("users").where('id', isEqualTo: 'myid').get();

    // get all data
    var dataAll = await db.collection("users").get();

    var Docs = dataAll.docs.map(
      (doc) => jsonDecode(jsonEncode(doc.data())),
    );

    print(Docs.toList());

    setState(() {
      _counter++;
    });
  }

// firebase update Data

  void updateData() async {
    final upDatacollect = await db.collection('users').doc('myid');
    final setData = upDatacollect.update({"first": "mahadi"});
  }

  // delete data firebase

  void deleteData() async {
    final upDatacollect = await db.collection('users').doc('myid');
    final setData = upDatacollect.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AllData(),
      drawer: Drawer(child: Column( children: [
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUser(title: "Add User")));
        } , child: Text("Add User"))
      ], ),
    
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AllData extends StatefulWidget {
  const AllData({Key? key}) : super(key: key);

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  FirebaseFirestore db = FirebaseFirestore.instance;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  var Users ;

  void _incrementCounter() async {
    // db.collection("users").add(user).then((DocumentReference doc) =>
    //     print('DocumentSnapshot added with ID: ${doc.id}'));

// send data to firebase with own id
    final userid = db.collection("users").doc('myid');
    final user = {
      "id": userid.id,
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    await userid.set(user);

    //  read all data from firebase

    var dataAll = await db.collection("users").get();

    var Docs = dataAll.docs.map(
      (doc) => jsonDecode(jsonEncode(doc.data())),
    );

    print(Docs.toList());
    setState(() {
      Users = Docs.toList();
    });
  }

// firebase update Data

  void updateData() async {
    final upDatacollect = await db.collection('users').doc('myid');
    final setData = upDatacollect.update({"first": "mahadi"});
  }

  // delete data firebase

  void deleteData(id) async {
    final upDatacollect = await db.collection('users').doc(id);
    final setData = upDatacollect.delete();
    setState(() {
      addUser();
    });
  }

  void addUser() async {
    // final userid = db.collection("users").doc('myid');
    // final user = {
    //   "id": userid.id,
    //   "first": "Ada",
    //   "last": "Lovelace",
    //   "born": 1815
    // };

    // await userid.set(user);

    //  read data from firebase

    var dataAll = await db.collection("users").get();

    var Docs = dataAll.docs.map(
      (doc) => jsonDecode(jsonEncode(doc.data())),
    );

    // print(Docs.toList());
    setState(() {
      Users = Docs.toList();
      print(Users);
    });
  }

  @override
  void initState() {
  
    super.initState();
    
      addUser();
  
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 3.0,
        onRefresh: () async {
            var dataAll = await db.collection("users").get();

    var Docs = dataAll.docs.map(
      (doc) => jsonDecode(jsonEncode(doc.data())),
    );

          setState(() {
             Users = Docs.toList();
            
          });


          return Future<void>.delayed(const Duration(seconds: 3));
        },child: Users!=null? Center(
      child: ListView.builder(
          itemCount: Users.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Center(
              child: ListTile(
                title: Text(Users[index]["first"]),
                trailing: InkWell(
                  child: Text("Delete"),
                  onTap: () {
                    deleteData(Users[index]["id"]);
                  },
                  
                ),
              ),
            );
          }),
    ): Center(child: CircularProgressIndicator(),));
  }
}
