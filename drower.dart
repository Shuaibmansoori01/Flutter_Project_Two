import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SubCategory.dart';
//import 'package:wallpaperwithapishuaib/Subcat.dart';
//import 'package:wallpaperwithapishuaib/profile2.dart';


class Country {
  final String bimage;

  Country({required this.bimage});
}


class Category {
  final String id;
  final String name;
  final String image;




  Category({ required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image:  json['image'],
    );
  }
} // end category work





//static final String apiUrl = 'https://www.webvalley.tech/DisplayCatApi.php';
//fatech category api work
Future<List<Category>> fetchCategories() async {
  final response = await http.post(Uri.parse('https://www.webvalley.tech/DisplayCatApi.php'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    print(response.body);
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}   // end fartech category work


class drower extends StatefulWidget {
  // int ?id;
  // drower({super.key,required this.id});

  @override
  State<drower> createState() => _drowerState();
}

class _drowerState extends State<drower> {
  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://www.webvalley.tech/DisplayBanner.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Country> countries = data.map((countryData) {
        final bimage = "https://www.webvalley.tech/"+countryData['bimage'];
        return Country(bimage: bimage);
      }).toList();
      return countries;
    } else {
      throw Exception('Failed to load data');
    }
  }

  var name="";
  var email="";
  /* void fetchUserProfile() async {
    final response = await http.get(Uri.parse('https://www.webvalley.tech/profilepageapi.php?id=${widget.id}'));

    if (response.statusCode == 200) {
      //   final jsonData = json.decode(response.body);
      // print(jsonData);`
      Map<String, dynamic> user = jsonDecode(response.body);
      setState(() {
        name=user['name'];
        email=user['email'];

      });


    } else {
      // Handle error, e.g., show an error message
      return null;
    }
  }*/

  @override
  void initState() {
    super.initState();
    //fetchCategories();
    //fetchUserProfile();
  }
  Widget build(BuildContext context) {


    String searchValue;
    return Scaffold( backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(  backgroundColor: Colors.green, items:  [
          Icon(Icons.home,),
          Icon(Icons.category),
          Icon(Icons.favorite_border_rounded,),
          Icon(Icons.account_box,),
        ],),
        appBar: EasySearchBar(  backgroundColor: Colors.white,
            title: Text('Search Api'),
            onSearch: (value) => setState(() => searchValue = value)
        ),
        body:
        SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(height: 10,),
            //category work
            Container(
              height: 150,
              width: double.infinity,
              child:
              FutureBuilder<List<Category>>(
                  future:  fetchCategories(),
                  builder: (context,abc){
                    if(abc.hasData){
                      return  ListView.builder(
                           itemExtent: 80,
                          itemCount: abc.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int len){
                            return GestureDetector(
                              onTap: (){

                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return SubCategory( cid:abc.data![len].id.toString(),  );
                                }));




                              //  print('${abc.data![len].id.toString()}');


                              },
                              child: Column(children: [

                                Container( decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black, // Set the border color
                                    width: 1.5,         // Set the border width
                                  ),
                                ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage("https://www.webvalley.tech/"+abc.data![len].image,),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Center(child:Text(abc.data![len].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                                        Text(abc.data![len].id.toString())

                                      ],))]),
                            );
                          });
                    }
                    else if(abc.hasError){
                      return Text(abc.error.toString());
                    }
                    return const LinearProgressIndicator(
                      color: Colors.black,
                    );
                  }
              ),
            ),
            // end category
            SizedBox(height: 10),
            //Scroller
            // start banner work
            FutureBuilder<List<Country>>(
              future: fetchCountries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data available'));
                } else {
                  return CarouselSlider.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        height: 156,
                        // decoration: BoxDecoration(
                        //   border: Border.all(width: 1),
                        //   borderRadius: BorderRadius.circular(20)
                        // ),
                        // decoration: null,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.network(snapshot.data![index].bimage, fit: BoxFit.cover,)
                        ),

                      );
                    },
                    options: CarouselOptions(
                      height: 220,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      //reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        // Handle page change
                      },
                    ),
                  );
                }
              },

            ),
            // end banner work
            SizedBox(height: 10),

             Container(height: 200,width: double.infinity, color: Colors.blue,
             child: Image.asset("images/shoes.gif",fit: BoxFit.cover,),
             ),


            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Text('𝙉𝙚𝙬 𝙇𝙖𝙪𝙣𝙘𝙝𝙚𝙨',style: TextStyle(fontSize: 25,),),
            ),

            Container(height: 250, width: double.infinity,
            child: Image.asset("images/shoes2.gif",fit: BoxFit.cover,),
            ),


            SizedBox(height: 100,)





          ],

          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("$name",style: TextStyle(fontSize: 15),),
                accountEmail: Text("$email",style: TextStyle(color: Colors.white,fontSize: 20),),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "S",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home), title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings), title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts), title: Text("Contact Us"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout), title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),


        );


  }
}