import 'package:flutter/material.dart';

class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(

        child: Column(children: [
          SizedBox(height: 80),
          Image.asset('images/forgetpass.png',width: 500, height: 150,),
          Text('Reset Passeord', style: TextStyle(fontSize: 30),),
          SizedBox(height: 20),
          Container(
            height: 55,
            width: 320,
            child: TextField(decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20) ),
                    borderSide: BorderSide(width: 3,color: Colors.black)),

                hintText: "Password",prefixIcon: Icon(Icons.lock)),

            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 55,
            width: 320,
            child: TextField(decoration: InputDecoration( filled: true, fillColor:  Colors.white,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 3),borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20) ),
                    borderSide: BorderSide(width: 3,color: Colors.black)),

                hintText: "Conform password",prefixIcon: Icon(Icons.lock)),

            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 55,
            width: 320,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
            ),
            child: Center(child: Text('Reset Password', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),)),
          ),
        ],),
      )

    );
  }
}
