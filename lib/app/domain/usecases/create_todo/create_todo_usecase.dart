import 'package:result/result.dart';
import '../../entities/todo_entity.dart';

abstract class ICreateTodoUseCase {
  Future<Result> call(TodoEntity todo);
}