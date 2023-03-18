import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_pixel_pioneers/components/edit_resume.dart';
import 'package:the_pixel_pioneers/components/preview.dart';
import 'package:the_pixel_pioneers/components/profile.dart';
import 'package:the_pixel_pioneers/firebase_options.dart';
import 'package:the_pixel_pioneers/services/authentication.dart';
import '/components/login_signup.dart';
import '/components/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Authentication.auth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          return snapshot.data == null ? LoginPage() : Profile();
        },
      ),
    );
  }
}
