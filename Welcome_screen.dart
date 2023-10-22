import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallpaperwithapishuaib/registration.dart';

//import 'homescreen.dart';
import 'drower.dart';
import 'login.dart';
//import 'loginpage.dart';

class spleshscreen extends StatefulWidget {
  const spleshscreen({Key? key}) : super(key: key);

  @override
  State<spleshscreen> createState() => _spleshscreenState();
}

class _spleshscreenState extends State<spleshscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50,),
         Padding(
          padding: const EdgeInsets.only(left: 250,top: 20),
          child: GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){
                return drower();
              }));},
              child: Text('Skip >',style: TextStyle(fontWeight: FontWeight.bold),)),
        ),
        SizedBox(height: 40,),
        Text('Welcome Tech World',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        Text('Please log in or sign in to conntinue'),
        SizedBox(height: 50,),
        SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const  EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        constraints: const  BoxConstraints.expand(width: double.infinity,height: 100.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: const DecorationImage(
                            image: AssetImage('images/air.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(3.0),
                        constraints: const BoxConstraints.expand(width: double.infinity,height: 100.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),

                          image: const DecorationImage(
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVGzdEh9ICvFp_VYJtyrM_l9he2fg8FEV5bkzhRVqjibMPlAHCfuDx5qOmlXUE_03o40&usqp=CAU"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const  EdgeInsets.all(3.0),
                        constraints: const BoxConstraints.expand(width: double.infinity,height: 100.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: const DecorationImage(
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVGzdEh9ICvFp_VYJtyrM_l9he2fg8FEV5bkzhRVqjibMPlAHCfuDx5qOmlXUE_03o40&usqp=CAU"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(3.0),
                        constraints: const BoxConstraints.expand(width: double.infinity,height: 100.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: const DecorationImage(
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVGzdEh9ICvFp_VYJtyrM_l9he2fg8FEV5bkzhRVqjibMPlAHCfuDx5qOmlXUE_03o40&usqp=CAU"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const  EdgeInsets.all(3.0),
                        constraints: const BoxConstraints.expand(width: double.infinity,height: 100.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: const DecorationImage(
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVGzdEh9ICvFp_VYJtyrM_l9he2fg8FEV5bkzhRVqjibMPlAHCfuDx5qOmlXUE_03o40&usqp=CAU"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //3rd Image of Slider
                    ],
                    //Slider Container properties
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      viewportFraction: 0.8,
                    ),
                  ),
               ],
              ),
             )
            ),
        // login and sign button work
        SizedBox(height: 70,),
       // SizedBox(height: 60,),
        GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){
          return registation();
        }));},
          child: Container(
            height: 50,width: 300,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
             )
            ),
           ),
          ),
        SizedBox(height: 30,),
        GestureDetector( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){
          return login();
        }));} ,
          child: Container(
            height: 50,width: 300,
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(colors: [Colors.white,Colors.black]),
              borderRadius: BorderRadius.circular(10),),
            child: Center(child: Text('Log in',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
         )
        ),
       ),
      ),
     ]
    ),
   );
  }
 }
