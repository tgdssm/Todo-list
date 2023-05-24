import 'package:flutter/cupertino.dart';
import 'package:result/result.dart';
import 'package:todo_list/app/data/datasources/todo/todo_datasource.dart';
import 'package:todo_list/app/data/models/todo_model.dart';
import 'package:todo_list/app/domain/entities/todo_entity.dart';
import 'package:todo_list/app/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements ITodoRepository {
  final ITodoDatasource datasource;
  TodoRepositoryImpl(this.datasource);
  @override
  Future<Result<void>> createTodo(TodoEntity todo) async {
    try {
      final model = TodoModel(todo.id, todo.description, todo.done);
      await datasource.createTodo(model);
      return ResultSuccess(DoNothingAction);
    } on BaseError catch (e) {
      return ResultError(BaseError(message: e.message));
    } catch (e) {
      return ResultError(BaseError(message: e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteTodo(String todoID) async {
    try {
      await datasource.deleteTodo(todoID);
      return ResultSuccess(DoNothingAction);
    } on BaseError catch (e) {
      return ResultError(BaseError(message: e.message));
    } catch (e) {
      return ResultError(BaseError(message: e.toString()));
    }
  }

  @override
  Future<Result<List<TodoEntity>>> listTodo() async {
    try {
      final result = await datasource.listTodo();
      return ResultSuccess(result);
    } on BaseError catch (e) {
      return ResultError(BaseError(message: e.message));
    } catch (e) {
      return ResultError(BaseError(message: e.toString()));
    }
  }
}
