import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import 'list_widget.dart';

class ListWidgetDone extends StatefulWidget {
  final List<TodoItem> items;
  final void Function(String)? onRemove;
  const ListWidgetDone({Key? key, required this.items, this.onRemove})
      : super(key: key);

  @override
  State<ListWidgetDone> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidgetDone> {
  @override
  Widget build(BuildContext context) {
    final db = Localstore.instance;
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven
              ? Theme.of(context).primaryColor.withAlpha(20)
              : Theme.of(context).primaryColor.withAlpha(40),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (widget.onRemove != null) {
                          widget.onRemove!(widget.items[index].id);
                        }
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.black,
                      padding: const EdgeInsets.all(0),
                    ),
                    const SizedBox(width: 10),

                    Text(widget.items[index].text, style: const TextStyle(
                      decorationColor: Colors.black,
                      decorationStyle: TextDecorationStyle.solid,
                      decoration:
                      TextDecoration.lineThrough,
                      fontSize: 20,
                    ),),
                  ],
                ),
                Checkbox(
                  value: widget.items[index].done,
                  onChanged: (value) {
                    final item = widget.items[index];
                    db.collection('todos').doc(item.id).set({
                      'text': item.text,
                      'done': !item.done!,
                      'id': item.id,
                    });
                    setState(() {
                      widget.items[index].done = value;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}