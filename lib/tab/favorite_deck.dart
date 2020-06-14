import 'package:clash_royale_support/util/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteDeck extends StatefulWidget {
  
  @override
  createState() => FavoriteDeckState();
  
}

class FavoriteDeckState extends State<FavoriteDeck> {

  bool isInProgress = true;
  final db = Firestore.instance;

  _getFavoriteDecks() {
    db.collection("cr-top-decks").getDocuments()
        .then((snapshot) => snapshot.documents.forEach((element) {
          print(element.data);
    }));
    isInProgress = false;
  }
  
  @override
  void initState() {
    super.initState();
    _getFavoriteDecks();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://cdn.royaleapi.com/static/img/cards-150/hog-rider.png'),
                ),
                title: Text('Hog 2.6'),
                subtitle: Text('Ice Spirit, Skeletons, Log, Ice Golem, '
                    'Musketeer, Hog, Fireball, Tesla'),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  launch('clashroyale://copyDeck?deck=26000010;28000011;26000038;26000030;27000000;26000014;26000021;28000000');
                },
              ),
            );
          }),
      inAsyncCall: isInProgress,
      opacity: 0.5,
    );
  }
}
