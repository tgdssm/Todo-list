import 'package:flutter/material.dart';
import 'package:todo_list/design_system/app_colors.dart';
import 'package:todo_list/design_system/text_styles.dart';

enum Filter {
  all(filterIndex: 0),
  pending(filterIndex: 1),
  done(filterIndex: 2);

  const Filter({required this.filterIndex});
  final int filterIndex;
}

class TodoFilterWidget extends StatefulWidget {
  final ValueChanged<Filter> onChanged;
  const TodoFilterWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<TodoFilterWidget> createState() => _TodoFilterWidgetState();
}

class _TodoFilterWidgetState extends State<TodoFilterWidget> {
  Filter filter = Filter.all;

  BorderRadius getBorderRadius() {
    print(filter.filterIndex);
    switch (filter) {
      case Filter.all:
        return const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        );
      case Filter.done:
        return const BorderRadius.only(
          topRight: Radius.circular(25),
          bottomRight: Radius.circular(25),
        );
      default:
        return BorderRadius.zero;
    }
  }

  FractionalOffset getAlignment() {
    switch (filter) {
      case Filter.all:
        return const FractionalOffset(0, 0);
      case Filter.done:
        return const FractionalOffset(1, 0);
      default:
        return const FractionalOffset(.5, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.iceBlue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: getAlignment(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: getBorderRadius(),
              ),
              child: const FractionallySizedBox(
                widthFactor: 1 / 3,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onChanged(Filter.all);
                    setState(() {
                      filter = Filter.all;
                    });
                  },
                  child: Center(
                    child: Text(
                      "All",
                      style: filter == Filter.all
                          ? TextStyles.title2
                          : TextStyles.title,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onChanged(Filter.pending);
                    setState(() {
                      filter = Filter.pending;
                    });
                  },
                  child: Center(
                      child: Text(
                    "Pending",
                    style: filter == Filter.pending
                        ? TextStyles.title2
                        : TextStyles.title,
                  )),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onChanged(Filter.done);
                    setState(() {
                      filter = Filter.done;
                    });
                  },
                  child: Center(
                      child: Text(
                    "Done",
                    style: filter == Filter.done
                        ? TextStyles.title2
                        : TextStyles.title,
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
