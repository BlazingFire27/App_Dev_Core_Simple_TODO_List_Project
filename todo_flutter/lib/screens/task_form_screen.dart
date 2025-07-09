import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';
import '../model/task.dart';

class TaskFormScreen extends StatefulWidget {
  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _status = 'pending';
  String? _taskId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TaskProvider>(context, listen: false).clearError();
    final task = ModalRoute.of(context)?.settings.arguments as Task?;
    if (task != null && _taskId == null) {
      _taskId = task.id;
      _titleController.text = task.title;
      _descController.text = task.description;
      _status = task.status;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _saveTask(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final tasks = Provider.of<TaskProvider>(context, listen: false);

    bool ok;
    if (_taskId == null) {
      ok = await tasks.createTask(
        userId: auth.user!.userId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        status: _status,
      );
    } else {
      ok = await tasks.updateTask(
        taskId: _taskId!,
        userId: auth.user!.userId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        status: _status,
      );
    }
    if (ok) {
      Navigator.pop(context, _taskId == null ? 'Task added!' : 'Task updated!');
    } else if (tasks.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tasks.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF23272F), // dark background
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 231, 95), // mild yellow
        centerTitle: true,
        title: Text(
          _taskId == null ? 'Add Task' : 'Edit Task',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Enter title' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Enter description' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _status,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      items: ['pending', 'completed']
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s[0].toUpperCase() + s.substring(1)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _status = val);
                      },
                    ),
                    const SizedBox(height: 24),
                    if (tasks.errorMessage != null)
                      Text(
                        tasks.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ElevatedButton(
                      onPressed: () => _saveTask(context),
                      child: Text(_taskId == null ? 'Add Task' : 'Update Task'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
