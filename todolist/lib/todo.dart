class Todo {
  int? id;
  String? title;
  String? detail;
  String? startdate;
  String? enddate;
  bool status;

  Todo(
      {this.id,
      this.title,
      this.detail,
      this.startdate,
      this.enddate,
      required this.status});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'detail': detail,
      'startdate': startdate,
      'enddate': enddate,
      'status': status
    };
    return map;
  }
}
