class TaskModel {
  String title;
  String? subTitle;
  bool isDone;
  DateTime createAt;

  TaskModel({
    required this.title,
    this.subTitle,
    this.isDone = false,
    required this.createAt
  });
}
