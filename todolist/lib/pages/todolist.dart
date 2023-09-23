import 'package:flutter/material.dart';
import 'package:todolist/pages/update_todo.dart';
import 'package:todolist/sqlitedb.dart';
import 'package:todolist/todo.dart';
import 'add_todo.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List<Todo> todolist = [];
  Todo readTodo = Todo(status: false);
  SqliteDatabase readsql = SqliteDatabase();

  getTodo() async {
    List<Todo> allList = await readsql.readTodo();
    setState(() {
      todolist = allList;
    });
  }

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AddPage()))).then((value) {
                //.then ตือให้ทำอะไรถ้ากลับมา
                setState(() {
                  getTodo();
                });
              });
            },
            label: Text(
              'เพิ่มรายการ',
              style: TextStyle(fontSize: 16),
            ),
            icon: Icon(Icons.add),
            backgroundColor: const Color(0xff8369B4),
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        appBar: AppBar(
            title: const Text(
              'Todolist',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xff8369B4),
                      const Color(0xff668FC5),
                    ]),
              ),
            )),
        body: Column(
          children: [
            gettodolist(),
          ],
        ));
  }

  Widget gettodolist() {
    return Expanded(
      child: ListView.builder(
          itemCount: todolist.length,
          itemBuilder: (context, index) {
            final reversedIndex = todolist.length - 1 - index;
            int todoID = todolist[reversedIndex].id!;
            String todoTitle = todolist[reversedIndex].title!;
            String todoDetails = todolist[reversedIndex].detail!;
            String todoStartDate = todolist[reversedIndex].startdate!;
            String totoEndDate = todolist[reversedIndex].enddate!;
            return Padding(
              padding: EdgeInsets.all(15),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 181, 153, 231),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    value: todolist[reversedIndex].status,
                    onChanged: (bool? value) {
                      setState(() {
                        todolist[reversedIndex].status = value!;
                      });
                    },
                  ),
                ),
                title: Text(
                  todoTitle,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  "กำหนด ${totoEndDate}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                tileColor: const Color.fromARGB(255, 254, 254, 254),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UpdateTodo(
                              id: todoID,
                              title: todoTitle,
                              detail: todoDetails,
                              startdate: todoStartDate,
                              enddate: totoEndDate)))).then((value) {
                    //.then ตือให้ทำอะไรถ้ากลับมา
                    setState(() {
                      if (value == 'update') {
                        final snackBar = SnackBar(
                          content: const Text('เเก้ไขเรียบร้อย'),
                          action: SnackBarAction(
                            label: 'รับทราบ',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (value == 'delate') {
                        final snackBar = SnackBar(
                          content: const Text('ลบเรียบร้อย'),
                          action: SnackBarAction(
                            label: 'รับทราบ',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      getTodo();
                    });
                  });
                },
                trailing: const Icon(Icons.chevron_right),
                enabled: todolist[reversedIndex].status ==
                    false, //ถ้าtodolist ถูกเช็ค ไม่สามารถทำงานได้
              ),
            );
          }),
    );
  }
}
