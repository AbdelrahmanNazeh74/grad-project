import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/auth_container.dart';
import 'package:graduation_project/chatbot/chat_screen.dart';
import 'package:graduation_project/registration/auth_provider.dart';
import 'package:graduation_project/student/student.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Science',
      routes: {
        Student.routeName: (context) => AuthContainrt(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
      initialRoute: Student.routeName,
    );
  }
}

//userProvider.firebaseUser==null?Login.routeName:Student.routeName

