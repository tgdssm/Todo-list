import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/design_system/app_colors.dart';
import 'package:todo_list/design_system/text_styles.dart';

class PopupDeleteTodo extends StatefulWidget {
  final VoidCallback onTapOk;
  const PopupDeleteTodo({
    Key? key,
    required this.onTapOk,
  }) : super(key: key);

  @override
  State<PopupDeleteTodo> createState() => _PopupDeleteTodoState();
}

class _PopupDeleteTodoState extends State<PopupDeleteTodo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Do you want to delete these tasks?",
              style: TextStyles.title.copyWith(fontSize: 18),
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
                "Delete",
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
