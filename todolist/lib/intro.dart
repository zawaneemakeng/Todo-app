import 'package:flutter/material.dart';

import 'package:todolist/pages/todolist.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff8369B4),
                  Color(0xff668FC5),
                ]),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 150,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/checklist.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'To Do List',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'การติดตามงานที่ง่ายขึ้น',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Todolist()));
                    },
                    child: const Text('เริ่ม',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)),
                      minimumSize: const Size(320, 55),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
