import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/domain/entities/todo_entity.dart';
import 'package:todo_list/app/domain/usecases/create_todo/create_todo_usecase.dart';
import 'package:todo_list/app/domain/usecases/delete_todo/delete_todo_usecase.dart';
import 'package:todo_list/app/domain/usecases/list_todo/list_todo_usecase.dart';

import 'components/todo_filter.dart';

class TodoListController {
  final ICreateTodoUseCase createTodoUseCase;
  final IListTodoUseCase listTodoUseCase;
  final IDeleteTodoUseCase deleteTodoUseCase;

  TodoListController(
      this.createTodoUseCase, this.listTodoUseCase, this.deleteTodoUseCase);

  final RxString errorMessage = "".obs;
  final RxList<TodoEntity> filteredTasks = <TodoEntity>[].obs;
  final List<TodoEntity> allTasks = [];

  Future<void> createTodo(TodoEntity todo) async {
    final result = await createTodoUseCase(todo);
    if (result.isSuccess) {
      allTasks.add(todo);
    } else {
      errorMessage.value = result.errorData.message;
    }
  }

  Future<void> listTodo() async {
    final result = await listTodoUseCase();
    if (result.isSuccess) {
      allTasks.clear();
      filteredTasks.clear();
      allTasks.addAll((result.successData as List<TodoEntity>));
      filteredTasks.addAll(allTasks);
    } else {
      errorMessage.value = result.errorData.message;
    }
  }

  Future<void> deleteTodo(String id) async {
    final result = await deleteTodoUseCase(id);
    if (result.isSuccess) {
      allTasks.removeWhere((element) => element.id == id);
      filteredTasks.removeWhere((element) => element.id == id);
    } else {
      errorMessage.value = result.errorData.message;
    }
  }

  Future<void> changeState(TodoEntity entity) async {
    final result = await createTodoUseCase(entity);
    if (result.isError) {
      errorMessage.value = result.errorData.message;
    }
  }

  void filterList(Filter filter) {
    if (filter == Filter.done) {
      filteredTasks.value =
          allTasks.where((element) => element.done == true).toList();
    } else if (filter == Filter.pending) {
      filteredTasks.value =
          allTasks.where((element) => element.done == false).toList();
    } else {
      filteredTasks.value = allTasks;
    }
  }
}
