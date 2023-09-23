import 'package:flutter/material.dart';
import 'package:todolist/sqlitedb.dart';
import 'dart:async';
import 'package:todolist/todo.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String startdate = "";
  String enddate = "";
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  List<String> months = [
    "ม.ค.",
    "ก.พ.",
    "มี.ค.",
    "เม.ย.",
    "พ.ค.",
    "มิ.ย.",
    "ก.ค.",
    "ส.ค.",
    "ก.ย.",
    "ต.ค.",
    "พ.ย.",
    "ธ.ค."
  ];
  Todo addTodoC = Todo(status: false);
  SqliteDatabase addsql = SqliteDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // <-- SEE HERE
        ),
        title: const Text('เพิ่มรายการ',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff8369B4),
                  Color(0xff668FC5),
                ]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          const SizedBox(
            height: 30,
          ),
          Container(
              width: 120,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: todo_title,
                autocorrect: true,
                decoration: const InputDecoration(
                  hintText: "รายการ",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 181, 153, 231), width: 2),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: 120,
              padding: EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 4,
                controller: todo_detail,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: "รายละเอียดราการ",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 181, 153, 231), width: 2),
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectStartDate(context);
                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.date_range,
                        size: 30.0,
                        // color: Colors.grey[700],
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "เริ่ม ${selectedStartDate.day} ${months[selectedStartDate.month - 1]} ${selectedStartDate.year}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectEndDate(context);
                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.date_range,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "ครบกำหนด ${selectedEndDate.day} ${months[selectedEndDate.month - 1]} ${selectedEndDate.year}",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 100, right: 100, top: 30, bottom: 0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedStartDate.day <= selectedEndDate.day &&
                    selectedStartDate.month - 1 <= selectedEndDate.month - 1 &&
                    selectedStartDate.year <= selectedEndDate.year) {
                  addTodo();
                } else {
                  final snackBar = SnackBar(
                    content: const Text('กรุณาเลือกวันที่อีกครั้ง'),
                    action: SnackBarAction(
                      label: 'รับทราบ',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('เพิ่ม',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8369B4),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                minimumSize: const Size(20, 55),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        startdate =
            "${selectedStartDate.day} ${months[selectedStartDate.month - 1]} ${selectedStartDate.year}";
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        enddate =
            "${selectedEndDate.day} ${months[selectedEndDate.month - 1]} ${selectedEndDate.year}";
      });
    }
  }

  Future addTodo() async {
    if (startdate == '')
      startdate =
          "${selectedStartDate.day} ${months[selectedStartDate.month - 1]} ${selectedStartDate.year}";
    if (enddate == '')
      enddate =
          "${selectedEndDate.day} ${months[selectedEndDate.month - 1]} ${selectedEndDate.year}";

    addTodoC = Todo(
        title: todo_title.text,
        detail: todo_detail.text,
        startdate: startdate,
        enddate: enddate,
        status: false);
    await addsql.createTodo(addTodoC);
    Navigator.pop(context, 'add');
  }
}
