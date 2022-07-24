import 'package:data_send/screens/eListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllQuestion extends StatefulWidget {
  const AllQuestion({Key? key}) : super(key: key);

  @override
  State<AllQuestion> createState() => _AllQuestionState();
}

class _AllQuestionState extends State<AllQuestion> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: ((context, index) {
          return MyWidget(index: index.toString(),right: '3',);
        }),
        separatorBuilder: (BuildContext ctx, int index) {
          return SizedBox(
            height: 50,
          );
        },
        itemCount: 20),
    );
  }
}
