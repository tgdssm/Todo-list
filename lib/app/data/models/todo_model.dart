import 'package:todo_list/app/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel(
    super.id,
    super.description,
    super.pending,
  );

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        map["id"],
        map["description"],
        map["pending"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "pending": done,
      };
}
