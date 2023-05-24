import 'dart:convert';
import 'package:result/result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/app/data/datasources/todo/todo_datasource.dart';
import 'package:todo_list/app/data/models/todo_model.dart';

class TodoDatasourceImpl implements ITodoDatasource {
  @override
  Future<void> createTodo(TodoModel todo) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(todo.id, jsonEncode(todo.toMap()));
    } catch (e) {
      print(e);
      throw BaseError(message: e.toString());
    }
  }

  @override
  Future<void> deleteTodo(String todoID) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove(todoID);
    } catch (e) {
      print(e);

      throw BaseError(message: e.toString());
    }
  }

  @override
  Future<List<TodoModel>> listTodo() async {
    try {
      final List<TodoModel> list = [];
      final pref = await SharedPreferences.getInstance();
      final keys = pref.getKeys();
      for(String key in keys) {
        final content = pref.getString(key);
        final Map<String, dynamic> map = jsonDecode(content!);
        list.add(TodoModel.fromMap(map));
      }
      return list;
    } catch (e) {
      print(e);

      throw BaseError(message: e.toString());
    }
  }
}
