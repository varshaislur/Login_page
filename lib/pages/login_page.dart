import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_task4/pages/sign_up_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email= TextEditingController();
  TextEditingController _password=TextEditingController();
  var _isObscured;
  final _formkey=GlobalKey<FormState>();
  bool isLoading=false;
  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading=true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
      );
      setState(() {
        isLoading=false;
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading=false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("user not found")));
      } else if (e.code == 'wrong-password') {
       return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("wrong password")));
      }
      else{
        print(e);
      }
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured =true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Login"),
      ),
      body:Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key:_formkey,
          child: OverflowBar(

            overflowSpacing: 20.0,
            children: [
              Container(
                child:Center(child: Image.asset('assets/gdsctask.png')),
                height:70.0,
                width: 1000.0,
              ),
              TextFormField(
                controller: _email,
                validator:(text){
                  if(text==null||text.isEmpty){
                    return 'email is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "email",
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              TextFormField(
                controller: _password,
                obscureText: _isObscured,
                validator:(text){
                  if(text==null||text.isEmpty){
                    return 'password is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "password",
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    padding: EdgeInsetsDirectional.only(end: 12.0),
                    icon:_isObscured ? const Icon(Icons.visibility_off, color: Colors.grey,): Icon(Icons.visibility, color:Colors.blue),
                    onPressed: (){
                      setState(() {
                        _isObscured =! _isObscured;
                      });
                    },
                  )

                ),
              ),
              SizedBox(
                width: double.infinity,
                height:45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                      signInWithEmailAndPassword();
                    }

                  },
                  child:isLoading?Center(child: CircularProgressIndicator(color: Colors.white,)):Text("login") ,
                )
              ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?"),
            SizedBox(width:5,),
            GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignUp()),(route)=>false);
                },
                child:Text("SignUp",
                    style:TextStyle(
                      color: Colors.blue,
                    ))
            ),
           ],
        ),
            ],
          ),
        ),
      )
    );
  }
}
