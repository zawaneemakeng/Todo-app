import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/todo.dart';

class SqliteDatabase {
  late Database database;
  final String dbFile = 'todo.sqlite3';
  final String tableName = 'Todolist';
  final String idField = 'id';
  final String titleField = 'title';
  final String detailField = 'detail';
  final String startdateFild = 'startdate';
  final String enddateFild = 'enddate';
  final String statusField = 'status';

  //เปิดใช้งานdatabase
  Future initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), dbFile),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
        $idField INTEGER PRIMARY KEY AUTOINCREMENT,
        $titleField TEXT,
        $detailField TEXT,
        $startdateFild TEXT,
        $enddateFild TEXT,
        $statusField INTEGER
      );
      ''');
      },
    );
  }

  Future createTodo(Todo todo) async {
    await initDatabase();
    return await database.insert(tableName, todo.toMap());
  }

  Future readTodo() async {
    await initDatabase();
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) {
      return Todo(
          id: maps[i][idField],
          title: maps[i][titleField],
          detail: maps[i][detailField],
          startdate: maps[i][startdateFild],
          enddate: maps[i][enddateFild],
          status: maps[i][statusField] == 1);
    });
  }

  Future updateTodo(Todo todo) async {
    await initDatabase();
    return await database
        .update(tableName, todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
  }

  Future delateTodo(int id) async {
    await initDatabase();
    return await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
