import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_task4/pages/login_page.dart';
import 'package:login_task4/pages/sign_up_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyB88RbjwEYD5y3r2cQnKVk3MF1bK3hDtME", appId: "1:886358513379:web:434a2cc00cfc7238ec57d6", messagingSenderId: "886358513379", projectId: "logintask4"));
  }
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(),
        home: SignUp(),
    );
    }
}
