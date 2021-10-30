import 'package:flutter/material.dart';
import 'package:todo_app_flutter/widgets/list_widget.dart';

class DoListPage extends StatelessWidget {
  final List<TodoItem> items;
  final Function(String)? onRemove;
  const DoListPage({Key? key, required this.items, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TodoItem> _itemsFiltered =
        items.where((item) => item.done == false).toList();

    return ListWidget(
      items: _itemsFiltered,
      onRemove: (id) {
        if (onRemove != null) {
          onRemove!(id);
        }
      },
    );
  }
}
