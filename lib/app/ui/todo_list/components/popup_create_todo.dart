import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/design_system/app_colors.dart';
import 'package:todo_list/design_system/text_styles.dart';

class PopupCreateTodo extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final VoidCallback onTapOk;
  const PopupCreateTodo({
    Key? key,
    required this.controller,
    required this.onTapOk,
    this.validator,
  }) : super(key: key);

  @override
  State<PopupCreateTodo> createState() => _PopupCreateTodoState();
}

class _PopupCreateTodoState extends State<PopupCreateTodo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Create new Task",
              style: TextStyles.title.copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: "Describe the task",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              onPressed: widget.onTapOk,
              color: AppColors.primary,
              child: const Text(
                "OK",
                style: TextStyles.title2,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              onPressed: () {
                widget.controller.clear();
                Modular.to.pop();
              },
              color: AppColors.iceBlue,
              child: const Text(
                "Cancel",
                style: TextStyles.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
