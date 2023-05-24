import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/domain/entities/todo_entity.dart';
import 'package:todo_list/app/ui/todo_list/components/popup_create_todo.dart';
import 'package:todo_list/app/ui/todo_list/components/popup_delete_todo.dart';
import 'package:todo_list/app/ui/todo_list/components/todo_filter.dart';
import 'package:todo_list/app/ui/todo_list/todo_list_controller.dart';
import 'package:todo_list/design_system/app_colors.dart';
import 'package:todo_list/design_system/text_styles.dart';
import 'package:uuid/uuid.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final controller = Modular.get<TodoListController>();
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Filter selectedFilter = Filter.all;

  @override
  void initState() {
    controller.listTodo();
    super.initState();
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Enter the description";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do list"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Form(
                key: formKey,
                child: PopupCreateTodo(
                  controller: textController,
                  validator: validator,
                  onTapOk: () async {
                    if (formKey.currentState!.validate()) {
                      var uuid = const Uuid();
                      final entity = TodoEntity(
                        uuid.v1(),
                        textController.text,
                        false,
                      );
                      await controller.createTodo(entity);
                      controller.filterList(selectedFilter);
                      textController.clear();
                      Modular.to.pop();
                    }
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: [
            TodoFilterWidget(
              onChanged: (filter) {
                selectedFilter = filter;
                controller.filterList(filter);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredTasks.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Form(
                            key: formKey,
                            child: PopupDeleteTodo(
                              onTapOk: () async {
                                await controller.deleteTodo(
                                    controller.filteredTasks[index].id);
                                Modular.to.pop();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.secondary,
                      title: Text(
                        controller.filteredTasks[index].description,
                        style: TextStyles.title.copyWith(
                          fontSize: 15,
                          decoration: controller.filteredTasks[index].done
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      value: controller.filteredTasks[index].done,
                      onChanged: (value) async {
                        controller.filteredTasks[index].done = value!;
                        await controller
                            .changeState(controller.filteredTasks[index]);
                        controller.filterList(selectedFilter);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
