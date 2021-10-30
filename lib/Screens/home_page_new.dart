import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstore/localstore.dart';
import 'package:todo_app_flutter/Screens/todo_list_page.dart';
import 'package:todo_app_flutter/widgets/list_widget.dart';
import 'package:todo_app_flutter/widgets/round_conner_bottom_sheet.dart';

import 'add_items_page.dart';
import 'do_list_page.dart';
import 'done_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> _items = [];
  final db = Localstore.instance;

  @override
  void initState() {
    super.initState();
    _getItems().then((value) {
      setState(() {
        _items = value;
      });
    });
  }

  void _addItem(String text) {
    final id = db.collection('todos').doc().id;
    db.collection('todos').doc(id).set({
      'text': text,
      'done': false,
      'id': id,
    });
    _getItems();
    setState(() {
      _getItems().then((value) => _items = value);
    });
  }

  void _removeItem(String id) {
    db.collection('todos').doc(id).delete();
    setState(() {
      _getItems().then((value) => _items = value);
    });
  }
  void _editItem(String id) {
    db.collection('todos').doc(id).get();
    setState(() {
      _getItems().then((value) => _items = value);
    });
  }

  Future<List<TodoItem>> _getItems() async {
    final data = await db.collection('todos').get();
    final List<TodoItem> list = <TodoItem>[];
    data?.forEach((key, value) {
      list.add(TodoItem(value['text'], value['done'], value['id']));
    });
    return list;
  }

  Future<void> showRemoveConfirmationDialog(String id) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Do you want to remove this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _removeItem(id);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddTask(BuildContext context) async {
    final result =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddItemPage();
    }));

    if (result != null) {
      _addItem(result.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            indicatorColor: Color(0xffF15C22),
            unselectedLabelColor: Colors.black45,
            labelColor: Color(0xffF15C22),
            tabs: [
              Tab(text: 'Tasks'),
              Tab(text: 'Do'),
              Tab(text: 'Done'),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            TodoListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
            DoListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
            DoneListPage(
              items: _items,
              onRemove: (id) {
                showRemoveConfirmationDialog(id);
              },
            ),
          ],
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
            // createSnackBar("Welcome back coder");
            // showInsertTaskDialog();
            // showInsertBottomSheet();
            _navigateToAddTask(context);
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.blueAccent,
            size: 36,
          ),
          //const Icon(Icons.add),
          // label: const Text('Add a new task')
        ),

        bottomNavigationBar: BottomAppBar(
          elevation: 16.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: showMenu,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: showMore,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return RoundConnerBototmSheet(Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  title: Text(
                    'Mukesh Kumar',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                  subtitle: Text(
                    'kumarmukesh@gmail.com',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      margin:
                      const EdgeInsets.only(
                          left: 16.0, top: 16.0, bottom: 16.0),
                      padding: EdgeInsets.all(16.0),
                      child: const Text(
                        'My Task',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w400),
                      ),
                      decoration: ShapeDecoration(
                          color: Colors.blue[50],
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(22.0),
                                  topStart: Radius.circular(22.0)))),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                const ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    'Create new list',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                const ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text(
                    'Send feedback',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  height: 1.0,
                ),
                const ListTile(
                  title: Text(
                    'Open-source licenses',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(color: Colors.black),
                        )),
                    const Text(
                      '•',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          ));
        });
  }

  showMore() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return RoundConnerBototmSheet(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: const <Widget>[
                    Text(
                      'Sort by',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black87),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'My order',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Icon(Icons.check)
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: const <Widget>[
                      Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black26,
                height: 1.0,
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Rename list',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black87),
                        textAlign: TextAlign.start,
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Delete list',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black87),
                        textAlign: TextAlign.start,
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        'Delete all completed tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.black87),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ))
            ],
          ));
        });
  }
}