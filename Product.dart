import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class ProductModel{
  final String pname;
  final String price;
  final String pdes;
  final String pimage;
  ProductModel({required this.pname, required this.price, required this.pdes, required this.pimage});
}


class Product extends StatefulWidget {
  final String sid;
  const Product({super.key, required this.sid});

  @override
  State<Product> createState() => _ProductState();
}
Future<List<ProductModel>> fetchproduct(String sid) async {
  final response = await http.post(
      Uri.parse('https://www.webvalley.tech/Displayproduct.php'),
      body: {
        "sid":sid,
      }
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<ProductModel> pro = data.map((subCatData) {
      final pname = subCatData["pname"];
      final price = subCatData["price"];
      final pdes = subCatData["pdes"];
      final pimage = subCatData["pimage"];
      return ProductModel(pname: pname, price: price, pdes: pdes, pimage:pimage);
    }).toList();
    return pro;
  } else {
    throw Exception('Failed to load data');
  }
}


class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Product"
           // widget.sid
          ),
        ),
        body: FutureBuilder<List<ProductModel>>(
          future: fetchproduct(widget.sid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index];
                  if (item?.pimage != null) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              "https://www.webvalley.tech/" + item!.pimage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.pname, overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.pdes),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.price),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString(),));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        );
    }
}