

import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;


class registation extends StatefulWidget {
  const registation({super.key});

  @override
  State<registation> createState() => _registationState();
}

class _registationState extends State<registation> {

  /*final String _name= TextEditingController() as String;
  final String email=TextEditingController() as String;
  final String password=TextEditingController() as String;
  final String mobile=TextEditingController() as String;
  final String address=TextEditingController() as String;*/




   TextEditingController _name = TextEditingController();
   TextEditingController _email = TextEditingController();
   TextEditingController _password = TextEditingController();
   TextEditingController _mobile = TextEditingController();
   TextEditingController _address = TextEditingController();

  Future<void>registerUser (String name, String email, String password, String mobile, String address) async {
     final uri = Uri.parse('https://www.webvalley.tech/registerpage.php');

     final response = await http.post(
       uri,
       body: {
         'name':name,
         'email':email,
         'password':password,
         'mobile':mobile,
         'address':address,

       }

     );
     if(response==200){
       print('Registration successful!');
     //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful')));
     }
     else{
      // Sc
       print("responce code is="+response.statusCode.toString());
       //ScaffoldMessenger.of(context).showSnackBar(SnackBar(dc6content: Text('Registration faild')));
     }
  }





   @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView( scrollDirection: Axis.vertical,
        child: Form(

          child: Column(children: [
            SizedBox(height: 50,),
            Image.asset('images/registation.png',width: 200, height: 100,),
            Text('𝓢𝓲𝓰𝓷 𝓤𝓹',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),),
            Text('Hey, Enter your details to get sign up in to your account ',style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 320,
              child: TextFormField(
               controller: _name,
                decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20) ),
                      borderSide: BorderSide(width: 3,color: Colors.black)
                  ),

                  hintText: "Name",prefixIcon: Icon(Icons.person)),
                  validator: (value){
                 if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                   return "Enter Your Correct name";
                 }
                 else{
                   return null;
                 }

                }

              ),


            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 320,
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 320,
              child: TextFormField(
                controller: _password,

                decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      borderSide: BorderSide(width: 3,color: Colors.black)),

                  hintText: "Password",prefixIcon: Icon(Icons.lock)),
                 validator: (value){
                    if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
                      return "Enter Your Correct name";
                    }
                    else{
                      return null;
                    }

                  }

              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 320,
              child: TextFormField(
                controller: _mobile,
                  keyboardType: TextInputType.number,
                decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      borderSide: BorderSide(width: 3,color: Colors.black)),

                  hintText: "mobile",prefixIcon: Icon(Icons.phone)),
                  validator: (value){
                    if(value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value!)){
                      return "Enter Your Correct Mobile";
                    }
                    else{
                      return null;
                    }

                  }

              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 320,
              child: TextFormField(
                controller: _address,
                decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      borderSide: BorderSide(width: 3,color: Colors.black)),

                  hintText: "Address",prefixIcon: Icon(Icons.spatial_audio)),
                  validator: (value){
                    if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                      return "Enter Your Correct Address";
                    }
                    else{
                      return null;
                    }

                  }

              ),
            ),
            SizedBox(height: 20),
            /*GestureDetector( onTap: (){
              registerUser(_name.text,_email.text,_password.text,_mobile.text,_address.text);
              final snackBar = SnackBar(content: Text('This is a SnackBar message'));
              //scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
              //ScaffoldMessenger=SnackBar(content: Text('hello'));
             // ScaffoldMessengerState.showSnak(SnackBar(content: Text('hello')))


            },
              child: Container(

                height: 55,
                width: 320,

                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                child: Center(child: GestureDetector(onTap:(){
                  _submit();
                }, child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),))),
              ),

            ),*/

            ElevatedButton(onPressed: (){
             //. print('Tujhe me rab ');

              registerUser(_name.text,_email.text,_password.text,_mobile.text,_address.text);
            //  _submit();
            }, child: Text('Submit')),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 80),
              child: Row(children: [
                Text('You have An Account?',style: TextStyle(color: Colors.grey),),
                GestureDetector( onTap: (){
                //  _submit();
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return login();
                  }));
                }, child: Text('Sign In',style: TextStyle(color: Colors.blue),)),
              ],),
            )



          ],),
        ),
      ),
    );
  }
}
