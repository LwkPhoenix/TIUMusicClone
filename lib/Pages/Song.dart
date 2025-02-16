import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class SongPage extends StatelessWidget {
  final String name;

  SongPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [Text(
          name,
          style: TextStyle(fontSize: 24),
        ),
        Text("${context.watch<CounterProvider>().count}"),
        ElevatedButton(onPressed:(){context.read<CounterProvider>().increment();} , child: Text("add")),
        InternetImg()
        ]
      ),
    );
  }
}

class InternetImg extends StatefulWidget {
  const InternetImg({super.key});

  @override
  State<InternetImg> createState() => _InternetImgState();
}

class _InternetImgState extends State<InternetImg> {
  String img = "";
  String img2 = "https://picsum.photos/200";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos/1'); // Sample API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        img = jsonDecode(response.body)['thumbnailUrl'];
      });
    } else {
      setState(() {
        img = "error"; // Change "none" to something meaningful
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Center(
    child: img.isEmpty
        ? CircularProgressIndicator() // Show loading while fetching
        : img == "error"
            ? Text("Failed to load image", style: TextStyle(color: Colors.red))
            : Image.network(img2, width: 100, height: 100, errorBuilder: (context, error, stackTrace) {
                return Text("Image failed to load");
              }),
  );
}
}