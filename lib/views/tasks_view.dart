import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  const Tasks(Map<String, dynamic> map, {Key? key}) : super(key: key);

  @override
  TasksState createState() => TasksState();
}

class TasksState extends State<Tasks> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _taskController = TextEditingController();
  final Map<String, List<Task>> _tasks = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffac255e),
                Color(0xffca485c),
                Color(0xffe16b5c),
                Color(0xfff39060),
                Color(0xffffb56b),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'ShadowsIntoLight',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          _buildTaskInput(),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
    if (_tasks.keys.isEmpty) {
      return const Center(
        child: Text(
          'No tasks yet',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _tasks.keys.length,
      itemBuilder: (BuildContext context, int index) {
        String date = _tasks.keys.toList()[index];
        return _buildTaskListItem(date);
      },
    );
  }

  Widget _buildTaskListItem(String date) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editTask(date),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteDate(date),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: _tasks[date]!.map((task) => _buildTask(task)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTask(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: task.completed,
            onChanged: (value) {
              setState(() {
                task.completed = value!;
              });
            },
          ),
          Expanded(
            child: Text(
              task.name,
              style: TextStyle(
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTask(task),
          ),
        ],
      ),
    );
  }

  void _addTask() {
    if (_taskController.text.isEmpty) return;
    String taskName = _taskController.text;
    _taskController.clear();
    String date = DateTime.now().toString().substring(0, 10);
    date = date.split('-').reversed.join('-');

    if (_tasks.containsKey(date)) {
      _tasks[date]!.add(Task(name: taskName));
    } else {
      _tasks[date] = [Task(name: taskName)];
    }

    setState(() {});
  }

  void _editTask(String date) {
    _scaffoldKey.currentState!.showBottomSheet(
      (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Edit date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onSubmitted: (newDate) {
                    if (newDate.isNotEmpty) {
                      List<Task> tasks = _tasks[date]!;
                      _tasks.remove(date);
                      _tasks[newDate] = tasks;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTask(Task task) {
    String date = _tasks.keys.firstWhere((key) => _tasks[key]!.contains(task));
    _tasks[date]!.remove(task);
    setState(() {});
  }

  void _deleteDate(String date) {
    _tasks.remove(date);
    setState(() {});
  }
}

class Task {
  String name;
  bool completed;

  Task({required this.name, this.completed = false});
}
