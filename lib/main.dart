import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => CounterProvider(),)],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class CounterProvider extends ChangeNotifier{
  int count = 0;
  void increment(){
    count++;
    notifyListeners();
  }
}