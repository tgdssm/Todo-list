import 'package:result/result.dart';
import 'package:todo_list/app/domain/entities/todo_entity.dart';
import 'package:todo_list/app/domain/repositories/todo_repository.dart';
import 'package:todo_list/app/domain/usecases/create_todo/create_todo_usecase.dart';

class CreateTodoUseCaseImpl implements ICreateTodoUseCase {
  final ITodoRepository repository;
  CreateTodoUseCaseImpl(this.repository);
  @override
  Future<Result> call(TodoEntity todo) async {
    return await repository.createTodo(todo);
  }

}