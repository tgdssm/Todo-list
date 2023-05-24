import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/app/app_module.dart';
import 'package:todo_list/app/app_widget.dart';

void main() => runApp(ModularApp(module: AppModule(), child: const AppWidget()));