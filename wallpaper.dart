import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(const MyApp());


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
  }



  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?page=1&per_page=80'),
      headers: {
        'Authorization': '"https://api.pexels.com/v1/search?query=people"',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['photos'];
      List<Photo> photos = data.map((photoData) {
        final imageUrl = photoData['src']['medium'];
        return Photo(imageUrl: imageUrl);
      }).toList();

      return photos;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Options Menu Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Photo>>(
          future: futurePhotos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return gridView(snapshot.data!);
            } else {
              return const Text('No data available.');
            }
          },
        ),
      ),

    );
  }


}
Widget gridView(List<Photo> photos)
{
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    ),
    itemCount: photos.length,
    itemBuilder: (context, index) {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            photos[index].imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
class Photo {
  final String imageUrl;

  Photo({required this.imageUrl});
}
