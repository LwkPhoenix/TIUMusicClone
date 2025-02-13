import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color? _primaryColor;

  @override
  void initState() {
    super.initState();
    _getPrimaryColor();
  }

  Future<void> _getPrimaryColor() async {
    PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        AssetImage('assets/images/HMHAS.png')); // Use a sample image for initial test

    setState(() {
      _primaryColor = palette.dominantColor?.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: bottomBar(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Home Screen',
            style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                ),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/user.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                print('User Profile');
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Top Picks For You",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            Text("Based on your recent activity",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)),
            SizedBox(
              height: 280,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  homeCard(
                      context,
                      'Hit Me Hard And Soft',
                      'Billie Eilish',
                      'assets/images/HMHAS.png'),
                  homeCard(
                      context,
                      "intro(end of the world)",
                      "Ariana Grande",
                      "assets/images/IEOTW.jpg"),
                  homeCard(
                      context,
                      "save your tears",
                      "The Weeknd",
                      "assets/images/SYT.jpeg"),
                  homeCard(
                      context,
                      "Siêu anh hùng",
                      "Tlinh",
                      "assets/images/SAH.webp"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trending Songs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: songsGrid(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget homeCard(BuildContext context, String title, String artist, String image) {
  return FutureBuilder<PaletteGenerator>(
    future: _getPalette(image),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError || !snapshot.hasData) {
        return Center(child: Text('Error loading color'));
      }

      Color? primaryColor = snapshot.data!.dominantColor?.color ?? Colors.black;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor.withOpacity(0.7), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image, width: 200, height: 200),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column (children: [
                  Text(title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(artist,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      )),
                ],)
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget songsGrid(BuildContext context) {
  return GridView.builder(
    scrollDirection: Axis.horizontal,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 2.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: songs.length,
    itemBuilder: (context, index) {
      final song = songs[index];
      return songTab(
        context,
        song['title'] ?? 'Unknown Title',
        song['artist'] ?? 'Unknown Artist',
        song['image'] ?? 'assets/default_image.png',
      );
    },
  );
}

Widget songTab(BuildContext context, String title, String artist, String image) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image, width: double.infinity, height: 80, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                artist,
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget bottomBar(BuildContext context) {
  return CupertinoTabBar(
    backgroundColor: Colors.black,
    activeColor: Colors.redAccent,
    inactiveColor: Colors.grey,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.playlist_play),
        label: 'Playlist',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Setting',
      ),
    ],
  );
}

// Helper function to fetch the PaletteGenerator
Future<PaletteGenerator> _getPalette(String image) async {
  return await PaletteGenerator.fromImageProvider(AssetImage(image));
}


List<Map<String, String>> songs = [
  {'title': 'Hit Me Hard And Soft', 'artist': 'Billie Eilish', 'image': 'assets/images/HMHAS.png'},
  {'title': 'intro(end of the world)', 'artist': 'Ariana Grande', 'image': 'assets/images/IEOTW.jpg'},
  {'title': 'save your tears', 'artist': 'The Weeknd', 'image': 'assets/images/SYT.jpeg'},
  {'title': 'Siêu anh hùng', 'artist': 'Tlinh', 'image': 'assets/images/SAH.webp'},
  {'title': 'Blinding Lights', 'artist': 'The Weeknd', 'image': 'assets/images/placeholder.png'},
  {'title': 'Shape of You', 'artist': 'Ed Sheeran', 'image': 'assets/images/placeholder.png'},
  {'title': 'Dance Monkey', 'artist': 'Tones and I', 'image': 'assets/images/placeholder.png'},
  {'title': 'Someone Like You', 'artist': 'Adele', 'image': 'assets/images/placeholder.png'},
  {'title': 'Uptown Funk', 'artist': 'Mark Ronson ft. Bruno Mars', 'image': 'assets/images/placeholder.png'},
  {'title': 'Despacito', 'artist': 'Luis Fonsi & Daddy Yankee ft. Justin Bieber', 'image': 'assets/images/placeholder.png'},
  {'title': 'Shape of My Heart', 'artist': 'Sting', 'image': 'assets/images/placeholder.png'},
  {'title': 'Bohemian Rhapsody', 'artist': 'Queen', 'image': 'assets/images/placeholder.png'},
  {'title': 'Smells Like Teen Spirit', 'artist': 'Nirvana', 'image': 'assets/images/placeholder.png'},
  {'title': 'Billie Jean', 'artist': 'Michael Jackson', 'image': 'assets/images/placeholder.png'},
  {'title': 'Stairway to Heaven', 'artist': 'Led Zeppelin', 'image': 'assets/images/placeholder.png'},
  {'title': 'Imagine', 'artist': 'John Lennon', 'image': 'assets/images/placeholder.png'},
];

