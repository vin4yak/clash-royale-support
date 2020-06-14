import 'package:clash_royale_support/tab/favorite_deck.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 2,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Clash Royale Support'),
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.star),
            ),
            Tab(
              icon: Icon(Icons.info),
            )
          ],
        ),
      ),
      body: TabBarView(
        children: [
          FavoriteDeck(),
          Icon(Icons.info)
        ],
    ),
    );
  }

}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer();
  }

}
