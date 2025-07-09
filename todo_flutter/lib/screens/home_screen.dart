import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      final tasks = Provider.of<TaskProvider>(context, listen: false);
      if (auth.user != null) {
        tasks.fetchTasks(auth.user!.userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final tasks = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF23272F), // dark grey background
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 231, 95), // mild yellow
        centerTitle: true,
        elevation: 0,
        title: Text(
          'MY TASKS',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black87),
            tooltip: 'Logout',
            onPressed: () {
              auth.logout();
              tasks.clearTasks();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: tasks.isLoading
          ? Center(child: CircularProgressIndicator())
          : tasks.tasks.isEmpty
              ? Center(
                  child: Text(
                    'No tasks yet. Add one!',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  itemCount: tasks.tasks.length,
                  itemBuilder: (context, i) {
                    final t = tasks.tasks[i];
                    return Card(
                      elevation: 8,
                      color: const Color(0xFFF5F6FA), // light grey/white "floating" card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: ListTile(
                        title: Text(
                          t.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.description,
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: t.status,
                                  dropdownColor: Colors.white,
                                  items: ['pending', 'completed']
                                      .map((s) => DropdownMenuItem(
                                            value: s,
                                            child: Text(
                                              s[0].toUpperCase() + s.substring(1),
                                              style: TextStyle(
                                                color: s == 'completed'
                                                    ? Colors.green
                                                    : Colors.orange,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (val) async {
                                    if (val != null && val != t.status) {
                                      await tasks.updateTask(
                                        taskId: t.id!,
                                        userId: t.userId,
                                        status: val,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueGrey),
                          tooltip: 'Edit Task',
                          onPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              '/task-form',
                              arguments: t,
                            );
                            if (auth.user != null) {
                              await tasks.fetchTasks(auth.user!.userId);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () {
          Navigator.pushNamed(context, '/task-form');
        },
        child: Icon(Icons.add, color: Colors.black87),
        tooltip: 'Add Task',
      ),
    );
  }
}
