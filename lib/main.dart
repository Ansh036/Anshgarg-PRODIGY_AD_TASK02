import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tasks = [];
  List<String> done = [];
  TextEditingController c = TextEditingController();

  void addTask() {
    if (c.text.isNotEmpty) {
      setState(() {
        tasks.add(c.text);
        c.clear();
      });
    }
  }

  void completeTask(int i) {
    setState(() {
      done.add(tasks[i]);
      tasks.removeAt(i);
    });
  }

  void removeDone(int i) {
    setState(() {
      done.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonePage(done: done, remove: removeDone),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c,
                    decoration: InputDecoration(hintText: 'Add a task'),
                  ),
                ),
                ElevatedButton(
                  onPressed: addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(tasks[i]),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => completeTask(i),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DonePage extends StatelessWidget {
  final List<String> done;
  final Function(int) remove;

  DonePage({required this.done, required this.remove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: done.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              done[i],
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => remove(i),
            ),
          );
        },
      ),
    );
  }
}