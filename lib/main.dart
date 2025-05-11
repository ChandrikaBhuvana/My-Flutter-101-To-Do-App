import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';              // Firebase core
import 'package:cloud_firestore/cloud_firestore.dart';          // Firestore for tasks
import 'screens/task_list_screen.dart';                         // Your UI screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();                    // Ensure binding before Firebase init
  await Firebase.initializeApp();                               // Manual Firebase init (no flutterfire)
  runApp(const MyApp());                                        // Start the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: const TaskListScreen(),                             // Start at task list screen
      debugShowCheckedModeBanner: false,
    );
  }
}
