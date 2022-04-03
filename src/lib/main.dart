import 'package:flutter/material.dart';

import 'game.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mia的小数独',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage()//GamePage('1'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> levels = [];
    for (int i = 1; i < 10; ++i) {
      levels.add(
        ListTile(title: Center(child : Text('第' + i.toString() + '级')),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GamePage(i.toString());}))
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mia的小数独"),
      ),
      body: Center(
        child: ListView(children: levels,),
      )
    );
  }
}

