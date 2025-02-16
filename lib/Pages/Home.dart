import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Song.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("helloworld"),
        actions: [
          Padding(padding: EdgeInsets.all(10), 
          child: SvgPicture.asset("assets/icons/user.svg",), )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(16, 0,0, 16),
          child: Text("Header 1", style: TextStyle(fontSize: 32),)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              MyCard(name: "HMHAS", image: "assets/images/HMHAS.png", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(name: "HMHAS")));
              }),
              MyCard(name: "IEOTW", image: "assets/images/IEOTW.jpg", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(name: "IEOTW")));
              }),
              MyCard(name: "A", image: "assets/images/SAH.webp", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(name: "A")));
              }),
              MyCard(name: "SYT", image: "assets/images/SYT.jpeg", onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage(name: "SYT")));
              }),
            ]),
            ),
            Text("${context.watch<CounterProvider>().count}")
          ],
          )
      );
  }
}

class MyCard extends StatelessWidget{
  final String name;
  final String image;
  final VoidCallback onPressed;

  const MyCard({
    super.key,
    required this.name,
    required this.image,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: 200,
        child: Column(
          children: [
            Image(image: AssetImage(image)),
            Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
          ],
        )
      ,
    )
    );
  }
}