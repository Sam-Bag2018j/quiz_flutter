import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:quiz_flutter/quiz.dart';

final _lightColors = [
  Colors.amber.shade200,
  Colors.lightGreen.shade200,
  Colors.lightBlue.shade200,
  Colors.orange.shade200,
  Colors.red.shade100,
  Colors.tealAccent.shade100
];

class HardPage extends StatefulWidget {
  const HardPage({Key? key}) : super(key: key);

  @override
  _HardPageState createState() => _HardPageState();
}

class _HardPageState extends State<HardPage> {
  List _itemsHard = [];
  String answerText = "View Answer";
  bool isPressed = false;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      _itemsHard = data["items_hard"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_return,
              color: Colors.black54,
            ),
          ),
        ),
        body: Center(
            child: Scrollbar(
                child: ListView.builder(
                    itemCount: _itemsHard.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        color: _lightColors[index % _lightColors.length],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ExpansionTile(
                          title: Text(_itemsHard[index]["id"],
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black54)),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                                child: Column(children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    //dense: true,
                                    title: Text(_itemsHard[index]["name"],
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    subtitle:
                                        Text(_itemsHard[index]["description"],
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.black54,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.normal)),
                                        onPressed: () {
                                          setState(() {
                                            _itemsHard[index]["isShowing"] =
                                                !_itemsHard[index]["isShowing"];
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.question_answer_rounded,
                                          size: 12,
                                          color: Colors.white70,
                                        ),
                                        label: (_itemsHard[index]["isShowing"]
                                            ? Text(_itemsHard[index]["answer"])
                                            : Text(answerText))),
                                  )
                                ]),
                              ),
                            ),
                          ],
                        ),
                      );
                      // ],
                    }))));
  }
}
