import 'package:result/result.dart';
import 'package:todo_list/app/domain/entities/todo_entity.dart';

abstract class ITodoRepository {
  Future<Result<void>> createTodo(TodoEntity todo);
  Future<Result<void>> deleteTodo(String todoID);
  Future<Result<List<TodoEntity>>> listTodo();
}