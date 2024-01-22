import 'package:balmond_chat/chat_page.dart';
import 'package:balmond_chat/contact_page.dart';
import 'package:balmond_chat/firebase_options.dart';
import 'package:balmond_chat/home_page.dart';
import 'package:balmond_chat/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  @override
  Widget build(BuildContext context) {
    bool logged = FirebaseAuth.instance.currentUser != null;

    return  OKToast(
      child: MaterialApp(
        theme: ThemeData(    
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: logged ? const HomePage() : const LoginPage()
      ),
    );
  }
}
