import 'package:data_send/screens/addUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key, required this.index, required this.right})
      : super(key: key);
  // required this.onChanged, required this.value
  final String index;
  final String right;
  // final List onegroup;
  // final  value;
  // final ValueChanged onChanged;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var selectedRadioTile;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;

  var selectedList;

  @override
  void initState() {
    super.initState();

    var selectedRadio = '';
    var selectedRadioTile = '';
  }

  setSelectedRadioTile(var val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    initState() {}

    return Column(
      children: [
        CountdownTimer(
          endTime: endTime,
          widgetBuilder: (BuildContext ctx, CurrentRemainingTime? time) {
            if (time == null) {
                  Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (context) => AddUser(title: '')));
          
              return Text('Game over');
            }
            return Text(
                ' hours: [ ${time.hours == null ? 0 : time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
          },
        ),
        ListTile(
          title: Text(
            "What is flutter?",
            style: TextStyle(fontSize: 18),
          ),
          leading: Text(
            "${widget.index}.",
            style: TextStyle(fontSize: 18),
          ),
        ),
        RadioListTile(
          value: 1,
          groupValue: selectedRadioTile,
          title: Text("Radio 1"),
          subtitle: Text("Radio 1 Subtitle"),
          onChanged: (val) {
            print("Radio Tile pressed $val");
            setState(() {
              selectedList.add(val.toString());
            });
            setSelectedRadioTile(val.toString());
          },
          activeColor: Colors.red,
          secondary: TextButton(
            child: Text("Say Hi"),
            onPressed: () {
              print("Say Hello");
            },
          ),
          selected: true,
        ),
        selectedList == '2'
            ? RadioListTile(
                value: '2',
                groupValue: selectedRadioTile,
                title: Text("Radio 1"),
                subtitle: Text("Radio 1 Subtitle"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setState(() {
                    selectedList.add(val.toString());
                    selectedList.contains(val.toString());
                    print(selectedList);
                  });
                  setSelectedRadioTile(val.toString());
                },
                activeColor: Colors.red,
                secondary: TextButton(
                  child: Text("Say Hi"),
                  onPressed: () {
                    print("Say Hello");
                  },
                ),
                selected: true,
              )
            : RadioListTile(
                value: '2',
                groupValue: selectedRadioTile,
                title: Text("Radio 1"),
                subtitle: Text("Radio 1 Subtitle"),
                onChanged: (val) {
                  print("Radio Tile pressed $val");
                  setState(() {
                    selectedList.add(val.toString());
                    selectedList.contains(val.toString());
                    print(selectedList);
                  });
                  setSelectedRadioTile(val.toString());
                },
                activeColor: Colors.red,
                secondary: TextButton(
                  child: Text("Say Hi"),
                  onPressed: () {
                    print("Say Hello");
                  },
                ),
                selected: false,
                autofocus: true,
              ),
        RadioListTile(
          value: '3',
          groupValue: selectedRadioTile,
          title: Text("Radio 1"),
          subtitle: Text("Radio 1 Subtitle"),
          onChanged: (val) {
            print("Radio Tile pressed $val");
            setState(() {
              selectedList.add(val.toString());
            });
            setSelectedRadioTile(val.toString());
            print(selectedList);
          },
          activeColor: Colors.red,
          secondary: TextButton(
            child: Text("Say Hi"),
            onPressed: () {
              print("Say Hello");
            },
          ),
          selected: false,
        ),
        RadioListTile(
            value: '4',
            groupValue: selectedRadioTile,
            title: Text("Radio 1"),
            subtitle: Text("Radio 1 Subtitle"),
            onChanged: (val) {
              print("Radio Tile pressed $val");
              setState(() {
                selectedList.add(val.toString());
              });
              setSelectedRadioTile(val.toString());
              print(selectedList);
            },
            activeColor: Colors.red,
            secondary: TextButton(
              child: Text("Say Hi"),
              onPressed: () {
                print("Say Hello");
              },
            ),
            selected: false)
      ],
    );
  }
}
