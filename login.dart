import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:wallpaperwithapishuaib/profile2.dart';
//import 'package:wallpaperwithapishuaib/profilepage.dart';
import 'package:wallpaperwithapishuaib/registration.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';


import 'Profilepage1.dart';
//import 'category.dart';
import 'drower.dart';
import 'forgetpass.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      print("User Details : ${_googleSignIn.currentUser}");
    } catch (error) {
      print(error);
    }
  }

  void loginpage(String ? email,String? pass) async {
    const String apiUrl= 'https://www.webvalley.tech/login.php';
    final Map<String?, String?> requestData={
      'email':email!,
      'password': pass!

    };
    final response = await http.post(Uri.parse(apiUrl), body: requestData);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode==200) {
      // Successful login, handle the response
      // var map=response.body;

       Map<String, dynamic> user = jsonDecode(response.body);

     /*  if(user['success']==true){

         int id=int.parse(user['userid']);
          //print(id.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context){
        return drower(id: id);
       }));
     }*/
     /*else{
       print('Invalid User');
     }*/


     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$rr')));



    } else {
      // Handle errors
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('login failed')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,
resizeToAvoidBottomInset: false,
      body: Column(children: [
       SizedBox(height: 20),
Image.asset("images/login.png"),
       // SizedBox(height: 250,),


        Text('Sign In !', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
       SizedBox(height: 10),
       Padding(
         padding:  EdgeInsets.only(left: 1.0),
         child: Text('Hey, Enter your details to get sign in to your account',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),),
       ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(right: 260),
          child: Text('Email',style: TextStyle(color: Colors.grey, fontSize: 17),),
        ), // Email Text


        Container(
          height: 56,
          width: 320,
          child: TextFormField(
            controller: _email,
            decoration: InputDecoration( filled: true, fillColor:  Colors.white,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 3,color: Colors.black)),

              hintText: "Email",prefixIcon: Icon(Icons.local_post_office_outlined)),
              validator: (value){
                if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
                  return "Enter Your Correct Email";
                }
                else{
                  return null;
                }

              }

          ),
        ), // Email container


        SizedBox(height: 25),


        Padding(
          padding: const EdgeInsets.only(right: 230),
          child: Text('Password',style: TextStyle(color: Colors.grey, fontSize: 17),),
        ), // password Text


        Container(
          height: 55,
          width: 320,


          child: TextFormField(
            controller: _password,
            decoration: InputDecoration(

              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
             filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 3,color: Colors.black)),

              hintText: "Password",prefixIcon: Icon(Icons.lock)),
              validator: (value){
                if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
                  return "Enter Your Correct Email";
                }
                else{
                  return null;
                }

              }

          ),
        ), // password container


        SizedBox(height: 5,),


        Padding(
          padding: const EdgeInsets.only(left: 190),
          child: GestureDetector( onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return forget();
            }));
          }, child: Text('Forget Password ?',style: TextStyle(color: Colors.grey),)),
        ), // forget password

        SizedBox(height: 50),

        Container(
          height: 55,
          width: 320,
                  decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
          child: Center(
              child: GestureDetector( onTap: (){
           /* Navigator.push(context, MaterialPageRoute(builder: (context){
            return NavigationBarApp();
          }));
           */

                if(_email.text.toString()!=null && _password.text.toString()!=null) {
                  loginpage(_email.text, _password.text);
                }



          }, child: Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),))),

        ), // sing in container


        SizedBox(height: 40),

        Padding(



          padding: const EdgeInsets.only(left: 80),
          child: Row(
            children: [
              Text("Dont't Have An Account ?",style: TextStyle(color: Colors.grey,),),
              GestureDetector(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return registation();
                }));
              }, child: Text('Sign Up',style: TextStyle(color: Colors.red),))
            ],
          ),
        ),


        ElevatedButton(onPressed: _handleSignIn, child: Text('singh'))


      ],),
    );
  }
}
