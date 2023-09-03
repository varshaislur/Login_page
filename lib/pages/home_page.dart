import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_task4/pages/login_page.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final user= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions:[
          Tooltip(
            message:'LogOut',
            child: IconButton(onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              }, icon: Icon(Icons.login)),
          )
        ]
      ),
          body: Column(
            children: [
              Container(
                child:Center(child: Image.asset('assets/gdsctask.png')),
                height:70.0,
                width: 1000.0,
              ),
              SizedBox(height:20),

              Center(
                child: Text(user!.email.toString()
        ),
    ),
            ],
          )

    );
  }
}
