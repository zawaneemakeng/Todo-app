import 'package:flutter/material.dart';
import 'package:todolist/sqlitedb.dart';
import 'package:todolist/todo.dart';

class UpdateTodo extends StatefulWidget {
  final id, title, detail, startdate, enddate;

  const UpdateTodo({
    super.key,
    this.title,
    this.detail,
    this.id,
    this.startdate,
    this.enddate,
  });

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  var _id, _title, _detail, _startdate, _enddate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _id = widget.id;
    _title = widget.title;
    _detail = widget.detail;
    _startdate = widget.startdate;
    _enddate = widget.enddate;
    todo_title.text = _title;
    todo_detail.text = _detail;
    startdate = _startdate;
    enddate = _enddate;
  }

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

  Todo edittodo = Todo(status: false);
  SqliteDatabase editsql = SqliteDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // <-- SEE HERE
        ),
        title: const Text('เเก้ไขรายการ',
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
        actions: [
          IconButton(
              onPressed: () async {
                deleteTodoSQL();
                Navigator.pop(context, 'delate');
              },
              icon: const Icon(Icons.delete_outline_outlined,
                  size: 28, color: Colors.white))
        ],
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
                decoration: InputDecoration(
                  hintText: _title,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
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
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 4,
                controller: todo_detail,
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: _detail,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  focusedBorder: const OutlineInputBorder(
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.date_range,
                        size: 30.0,
                        // color: Colors.grey[700],
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "เริ่ม $startdate",
                    style: const TextStyle(
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
                    "ครบกำหนด $enddate",
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
              onPressed: () async {
                if (selectedStartDate.day <= selectedEndDate.day &&
                    selectedStartDate.month - 1 <= selectedEndDate.month - 1 &&
                    selectedStartDate.year <= selectedEndDate.year) {
                  updateTodo(context);
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
              child: const Text('เเก้ไข',
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

  Future updateTodo(BuildContext context) async {
    edittodo = Todo(
        id: _id,
        title: todo_title.text,
        detail: todo_detail.text,
        startdate: startdate,
        enddate: enddate,
        status: false);
    await editsql.updateTodo(edittodo);
    Navigator.pop(context, "update");
  }

  Future deleteTodoSQL() async {
    await editsql.delateTodo(_id);
  }
}
