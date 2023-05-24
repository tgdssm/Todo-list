import 'package:result/result.dart';
import 'package:todo_list/app/domain/usecases/delete_todo/delete_todo_usecase.dart';

import '../../repositories/todo_repository.dart';

class DeleteTodoUseCaseImpl implements IDeleteTodoUseCase {
  final ITodoRepository repository;
  DeleteTodoUseCaseImpl(this.repository);
  @override
  Future<Result> call(String todoID) async {
    return await repository.deleteTodo(todoID);
  }
  
}