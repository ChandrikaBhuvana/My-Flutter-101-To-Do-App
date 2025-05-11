import 'package:flutter/material.dart';                         // Flutter UI package
import 'package:cloud_firestore/cloud_firestore.dart';          // Firebase Firestore package

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});                            // Stateless screen widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tasks'),                        // Title bar
        centerTitle: true,                                      // Center align the title
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')                                // Listen to 'tasks' collection in Firestore
            .orderBy('createdAt', descending: true)             // Order by newest tasks first
            .snapshots(),                                       // Get real-time updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tasks yet!'));  // Empty state UI
          }

          final tasks = snapshot.data!.docs;                    // Firestore task documents

          return ListView.builder(
            itemCount: tasks.length,                            // Number of tasks
            itemBuilder: (context, index) {
              final task = tasks[index];
              final taskName = task['taskName'];                // Task name from Firestore
              final isCompleted = task['isCompleted'];          // Completion status

              return ListTile(
                title: Text(taskName),
                leading: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(task.id)
                        .update({'isCompleted': value});        // Update task completion
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(task.id)
                        .delete();                              // Delete task from Firestore
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);                          // Open dialog to add new task
        },
        child: const Icon(Icons.add),                           // Plus icon
      ),
    );
  }

  // Show dialog to enter and save new task
  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();                     // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final taskName = _controller.text.trim();       // Get user input
                if (taskName.isNotEmpty) {
                  FirebaseFirestore.instance.collection('tasks').add({
                    'taskName': taskName,
                    'isCompleted': false,
                    'createdAt': Timestamp.now(),
                    'dueDate': Timestamp.now(),                 // Optional: can be updated later
                  });                                            // Save task to Firestore
                }
                Navigator.of(context).pop();                     // Close dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
