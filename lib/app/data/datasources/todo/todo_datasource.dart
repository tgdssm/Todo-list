import 'package:todo_list/app/data/models/todo_model.dart';

abstract class ITodoDatasource {
  Future<void> createTodo(TodoModel todo);
  Future<void> deleteTodo(String todoID);
  Future<List<TodoModel>> listTodo();
}