import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Product.dart';

class SubCat {
  final String sid;
  final String sname;
  final String simage;
  SubCat({required this.sid, required this.sname, required this.simage});
  
}
class BannerTwo {
  final String bimage;

  BannerTwo({required this.bimage});
}

class SubCategory extends StatefulWidget {
  final String cid;
  SubCategory({Key? key, required this.cid}) : super(key: key);
  @override
  State<SubCategory> createState() => _SubCategoryState();
}
// Future<List<SubCat>> fetchCountries() async {
//   final response = await http.get(
//     Uri.parse('https://www.webvalley.tech/Displaysubcategory.php?cid=${widget.cid}'),
//   );
//
//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body);
//     List<SubCat> subcat = data.map((subCatData) {
//       final sid = subCatData["sid"];
//       final sname = subCatData["sname"];
//       final simage = "https://www.webvalley.tech/" + subCatData["simage"];
//       return SubCat(sid: sid, sname: sname, simage: simage);
//     }).toList();
//     return subcat;
//   } else {
//
//     throw Exception('Failed to load data');
//   }
// }

Future<List<SubCat>> fetchCountries(String cid) async {
  final response = await http.get(
    Uri.parse('https://webvalley.tech/Displaysubcatagory.php?cid=$cid'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<SubCat> subcat = data.map((subCatData) {
      final sid = subCatData["sid"];
      final sname = subCatData["sname"];
      final simage = "https://www.webvalley.tech/"+subCatData["simage"];
      return SubCat(sid: sid, sname: sname, simage: simage);
    }).toList();
    return subcat;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<BannerTwo>> fetchBanner() async {
  final response = await http.get(Uri.parse('https://www.webvalley.tech/DisplayBanner.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<BannerTwo> Bannerdata = data.map((countryData) {
      final bimage = "https://www.webvalley.tech/"+countryData['bimage'];
      return BannerTwo(bimage: bimage);
    }).toList();
    return Bannerdata;
  } else {
    throw Exception('Failed to load data');
  }
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(title: Text("Category"),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Text('TRENDY WESTERN WEAR',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          ),
          
          FutureBuilder<List<SubCat>>(
            future: fetchCountries(widget.cid),
            builder: (context, snapshot, )
            {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.black87,
                );
              } else if (snapshot.hasData) {
                return
                  GridView.builder(
                    shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Change the number of columns as needed
                      ),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data?[index];
                       /* var index = snapshot.data![index].sid;
                        var sid=index++;*/
                            // print(snapshot.data![index].sid.toString());
                        return GestureDetector( onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Product(sid: widget.cid,);
                            //return Product(sid: snapshot.data![index].sid.toString(),);
                          }));


                          //print(widget.cid);
                        },
                          child: Column(children: [

                            Container(
                              child: Column(children: [
                                Container(
                                  height: 90,width: 90,
                                  child: Image.network(snapshot.data![index].simage,fit: BoxFit.cover,),
                                ),
                                Text(snapshot.data![index].sname,style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),),
                               // Text(snapshot.data![index].sid,style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),)
                              ],),
                              decoration: BoxDecoration( border: Border.all(width: 1), color: Colors.white30, borderRadius: BorderRadius.circular(10)),
                            ),
                          ],),
                        );
                      }
                      );
                /*  Container( height: 500,
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                    itemCount: abc.data!.length,
                    itemBuilder: (BuildContext context, int len) {
                      return
                        Column(
                        children:  <Widget>[
                          Container( decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black, // Set the border color
                              width: 1.5,         // Set the border width
                            ),
                          ),
                            child: CircleAvatar(radius: 30,  backgroundImage: NetworkImage(abc.data![len].simage,),
                          ),
                          ),
                           Text(abc.data![len].sname),
                        ],
                      );
                     // Text(abc.data![len].sname);
                    },
                ),
                  );*/
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.black87,
              );
            },
          ),
          //SizedBox(height: 20,),
          Container(height: 200, width: double.infinity,
            child: Image.asset("images/festival.jpg"),
          ),
          //SizedBox(height: 20,),
          FutureBuilder<List<BannerTwo>>(
            future: fetchBanner(),
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
                     // width: double.infinity,
                      height: double.infinity,
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
                    //enableInfiniteScroll: true,
                    //reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    //enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      // Handle page change
                    },
                  ),
                );
              }
            },
          ),
          Container(height: 120, 
            child: Image.asset('images/WhatsApp0.jpg'),
          )
          

        ]),
      ),
    );
  }
}








// /*
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
//
// void main() {
//   runApp(const homepahe());
// }
//
// class homepahe extends StatefulWidget {
//   const homepahe({super.key});
//
//   @override
//   State<homepahe> createState() => _homepaheState();
// }
//
// class _homepaheState extends State<homepahe> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: GNav(
//         tabs: [
//           GButton(icon: Icons.home, text: 'home',),
//           GButton(icon: Icons.settings, text: 'Setting',),
//           GButton(icon: Icons.person_off, text: 'profile',),
//
//
//
//         ],
//       )
//     );
//   }
// }
// */
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// //import 'package:netflix/apis/Category/product.dart';
// class SubCat{
//   final String sid;
//   final String sname;
//   final String simage;
//   SubCat({required this.sid,required this.sname,required this.simage});
//   factory SubCat.FromJson(Map<String,dynamic>json){
//     return SubCat(sid: json['sid'].toString(),sname: json['sname'],simage: "https://www.webvalley.tech/"+json['simage']);
//
//   }
// }
// class SubCategory extends StatefulWidget {
//   final String sid;
//   SubCategory({Key? key,required this.sid}) : super(key: key);
//
//   @override
//   State<SubCategory> createState() => _SubCategoryState();
// }
// Future<List<SubCat>>fetchData(id) async{
//   var url=Uri.parse("https://www.webvalley.tech/Displaysubcategory.php"+id);
//   final responce=await http.get(url);
//   if(responce.statusCode==200){
//
//     List listresponce=json.decode(responce.body);
//
//     return listresponce.map((data) => SubCat.FromJson(data)).toList();
//   }
//   else{
//     throw Exception('Unexpected error occured!');
//   }
//
//
// }
// class _SubCategoryState extends State<SubCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//             children:[
//
//               Padding(
//                 padding:  EdgeInsets.only(left: 18.0,top: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Discover",style: TextStyle(color: Colors.white,fontSize: 30),),
//                   ],
//                 ),
//               ),
//               FutureBuilder<List<SubCat>>(
//                   future: fetchData(widget.sid),
//                   builder: (context,abc){
//                     if(abc.hasData){
//                       return  ListView.builder(
//                           itemCount: abc.data!.length,
//
//                           itemBuilder: (BuildContext context,int len){
//                             return Padding(
//                               padding: const EdgeInsets.only(left: 18.0,right: 18),
//                               child: Column(
//                                 children: [
//
//                                   Container(
//                                     height: 80,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                                       children: [
//
//                                         Text(abc.data![len].sid,style: TextStyle(color: Colors.white),),
//
//
//                                         Text(abc.data![len].sname,style: TextStyle(color: Colors.white),),
//                                         Image.network(abc.data![len].simage,height: 80,fit: BoxFit.cover,),
//
//                                       ],
//                                     ),
//                                   ),
//                                   Divider(color: Colors.white,),
//                                 ],
//                               ),
//                             );
//
//                           });
//                     }
//                     else if(abc.hasError){
//                       return Text(abc.error.toString());
//
//                     }
//                     return const CircularProgressIndicator(
//                       color: Colors.black,backgroundColor: Colors.black87,
//                     );
//                   }
//
//               ),
//             ]  ),
//       ),
//     );
//   }
// }
//
