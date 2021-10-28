import 'package:flutter/material.dart';
import 'package:todo_app_flutter/utils/my_shared_preferences.dart';
import 'package:todo_app_flutter/widgets/round_conner_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  String email = "";

  HomeState() {
    MySharedPreferences.instance
        .getStringValue("email")
        .then((value) => setState(() {
      email = value;
      
      print("fsffsdfss-----"+email);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
              // createSnackBar("Welcome back coder");
              // showInsertTaskDialog();
              showInsertBottomSheet();
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

          /*floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: const Icon(Icons.navigation),
            backgroundColor: Colors.green,
          ),*/


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
          body: RefreshIndicator(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 24.0, bottom: 24.0, right: 24.0, left: 24.0),
                    child: const Text(
                      'My Tasks',
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.radio_button_unchecked),
                    title: Text('1. '+email),
                  )
                ],
              ),
              onRefresh: onRefresh),
        )
    );
  }

  /*final _snackBar1 = SnackBar(
    content: Text('Welcome to My Task'),
  );
*/
  void createSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(message, style: const TextStyle(
          color: Colors.black,
        ),
        ),
        backgroundColor: Colors.green
    );
    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    return;
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

  void showInsertTaskDialog() {
    String teamName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter current team'),
          content: Row(
            children: [
              Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
                    onChanged: (value) {
                      teamName = value;
                    },
                  ))
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }

  void showInsertBottomSheet() {
    TextEditingController controllerTask = TextEditingController();
    showModalBottomSheet<void>(
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          backgroundColor: Colors.white,

      context: context,
      builder: (BuildContext context) {
        return Form(
          child: SingleChildScrollView(
            child: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 50),
              curve: Curves.decelerate,
              child: Column(
                children: <Widget>[

                  SizedBox(
                    width: 100,
                    height: 16,
                  ),

                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                      child: const Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: Container(
                        child: TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'New Task'
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Enter Task";
                            }
                          },
                          controller: controllerTask,
                        )
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                          var getEmail = controllerTask.text;
                          print("hello: --- "+controllerTask.text);
                          MySharedPreferences.instance
                              .setStringValue("email", getEmail);

                         /* Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Profile()),
                          );*/
                      },
                      child: const Text('Save'),
                    )
                  ),

                  SizedBox(
                    width: 100,
                    height: 16,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
