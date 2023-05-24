import 'package:result/result.dart';
import 'package:todo_list/app/domain/usecases/list_todo/list_todo_usecase.dart';

import '../../repositories/todo_repository.dart';

class ListTodoUseCaseImpl implements IListTodoUseCase{
  final ITodoRepository repository;
  ListTodoUseCaseImpl(this.repository);
  @override
  Future<Result> call() async{
    return await repository.listTodo();
  }

}