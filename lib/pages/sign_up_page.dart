import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email= TextEditingController();
  TextEditingController _password=TextEditingController();

  var _isObscured;

  final _formkey=GlobalKey<FormState>();
  bool isLoading=false;
  createUserWithEmailAndPassword() async{
    setState(() {
      isLoading=true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("weak password")));
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("email already in use")));
      }
    } catch (e) {
      print(e);
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
          title: Text("Sign Up"),
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
                  obscureText: _isObscured,
                  controller: _password,
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
                          createUserWithEmailAndPassword();
                        }

                      },
                      child:isLoading?Center(child: CircularProgressIndicator(color: Colors.white,)):Text("SignUp") ,
                    )
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 5,),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                        },
                        child: Text("Login", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),))
                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}
