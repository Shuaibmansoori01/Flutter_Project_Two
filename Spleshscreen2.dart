import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:netflix/Homepages/homepage.dart';
//import 'package:netflix/login&reg/login.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

import 'Welcome_screen.dart';
import 'login.dart';

//import 'Navigationbar.dart';




class Splesh_screen extends StatefulWidget {
  const Splesh_screen({Key? key}) : super(key: key);

  @override
  State<Splesh_screen> createState() => _Splesh_screenState();
}

class _Splesh_screenState extends State<Splesh_screen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.push(context,MaterialPageRoute(builder: (context){
          return spleshscreen();
        }))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(child: Container(
            height: 300,
            width: 300,
            child: LottieBuilder.network('https://assets3.lottiefiles.com/private_files/lf30_c3gZyd.json'),
            
          ),)


        );}
}