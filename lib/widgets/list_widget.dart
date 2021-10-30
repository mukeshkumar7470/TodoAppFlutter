import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class TodoItem {
  final String _text;
  bool? done;
  final String id;

  String get text {
    return _text;
  }

  TodoItem(
    this._text,
    this.done,
    this.id,
  );
}

class ListWidget extends StatefulWidget {
  final List<TodoItem> items;
  final void Function(String)? onRemove;
  const ListWidget({Key? key, required this.items, this.onRemove})
      : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final db = Localstore.instance;
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven
              ? Theme.of(context).primaryColor.withAlpha(20)
              : Theme.of(context).primaryColor.withAlpha(20),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  elevation: 2,
                  shadowColor: Colors.black45,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
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
                              color: Colors.red,
                              padding: const EdgeInsets.all(0),
                            ),
                            const SizedBox(width: 10),

                            Text(widget.items[index].text),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
