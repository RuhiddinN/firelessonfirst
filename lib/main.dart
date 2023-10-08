import 'package:firebase_core/firebase_core.dart';
import 'package:firelessonfirst/pages/home_pages.dart';
import 'package:firelessonfirst/pages/login_page.dart';
import 'package:firelessonfirst/services/auth_services.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CheckUserPage(),
      routes: {
        MyHomePage.id: (context) => const MyHomePage(),
        CheckUserPage.id: (context) => const CheckUserPage(),
      },
    );
  }
}

class CheckUserPage extends StatelessWidget {
  static const String id = "/check";
  const CheckUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthServices().checkUser(),
      builder: (context, hasan) {
        if (hasan.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(hasan.hasError){
          return Scaffold(
            body: Center(
              child: Text(hasan.error.toString()),
            ),
          );
        } else {
          final data = hasan.data;

          if(data == null){
            return const LoginPage();
          } else {
            return const MyHomePage();
          }
        }
      },
    );
  }
}