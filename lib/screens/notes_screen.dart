import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _newTodoController = TextEditingController();
  List<String> todos = [];
  List<Color> colors = [];

  @override
  Widget build(BuildContext context) {
    print(colors.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "My Todo's",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("hkhj");
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text("Todo's Available!",
                style: TextStyle(color: Colors.grey, fontSize: 15)),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: todos.isNotEmpty
                    ? ListView.separated(
                        itemCount: todos.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          return Slidable(
                            key: Key(todos[index]),
                            startActionPane: const ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: null,
                                    label: 'Edit',
                                    icon: CupertinoIcons.pencil_outline,
                                    backgroundColor: Colors.white60,
                                  )
                                ]),
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    key: Key(todos[index]),
                                    onPressed: (_) => {
                                      setState(() {
                                        todos.remove(todos[index]);
                                        colors.remove(colors[index]);
                                      })
                                    },
                                    backgroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ]),
                            child: Container(
                              height: 90,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: colors[index],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: const Icon(
                                        CupertinoIcons.check_mark_circled,
                                        color: Colors.white,
                                      ),
                                      title: Text(todos[index]),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //  const    Icon(CupertinoIcons.bell_circle,color: Colors.white,),
                                          Text(DateFormat('yyyy-MM-dd')
                                              .format(DateTime.now()))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                      )
                    : LayoutBuilder(builder: (ctx, constrains) {
                        return ListView(
                          children: [
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Good Day,Mr Kweku Anansi.",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    Text(DateFormat('KK:mm a')
                                        .format(DateTime.now()))
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'Empty Todos...',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          "assets/new.png",
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      //  height: 900,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Add New Todo ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _newTodoController,
                            decoration: const InputDecoration(
                                labelText: "About Today's Todo"),
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 3,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (_newTodoController.text == '') {
                                return;
                              }
                              setState(() {
                                todos.add(_newTodoController.text);
                                colors.add(Colors
                                    .primaries[Random()
                                        .nextInt(Colors.primaries.length)]
                                    .shade300);
                              });
                              _newTodoController.clear();
                            },
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Card(
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          );
        },
        tooltip: 'Add new Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
