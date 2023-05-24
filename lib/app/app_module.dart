import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/app/data/datasources/todo/todo_datasource.dart';
import 'package:todo_list/app/data/datasources/todo/todo_datasource_impl.dart';
import 'package:todo_list/app/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/app/domain/usecases/create_todo/create_todo_usecase.dart';
import 'package:todo_list/app/domain/usecases/create_todo/create_todo_usecase_impl.dart';
import 'package:todo_list/app/domain/usecases/delete_todo/delete_todo_usecase.dart';
import 'package:todo_list/app/domain/usecases/delete_todo/delete_todo_usecase_impl.dart';
import 'package:todo_list/app/domain/usecases/list_todo/list_todo_usecase.dart';
import 'package:todo_list/app/domain/usecases/list_todo/list_todo_usecase_impl.dart';
import 'package:todo_list/app/ui/todo_list/todo_list_controller.dart';
import 'package:todo_list/app/ui/todo_list/todo_list_page.dart';
import 'package:todo_list/core/navigation/routes.dart';

import 'domain/repositories/todo_repository.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.initial.path, child: (context, args) => const TodoListPage(),)
  ];

  @override
  List<Bind> get binds => [
    // Datasources
    Bind.factory<ITodoDatasource>((i) => TodoDatasourceImpl()),

    // Repositories
    Bind.factory<ITodoRepository>((i) => TodoRepositoryImpl(i())),

    // Use Cases
    Bind.factory<ICreateTodoUseCase>((i) => CreateTodoUseCaseImpl(i())),
    Bind.factory<IListTodoUseCase>((i) => ListTodoUseCaseImpl(i())),
    Bind.factory<IDeleteTodoUseCase>((i) => DeleteTodoUseCaseImpl(i())),

    // Controllers

    Bind.factory<TodoListController>((i) => TodoListController(i(), i(), i())),
  ];
}