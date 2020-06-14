import 'package:cached_network_image/cached_network_image.dart';
import 'package:clash_royale_support/domain/deck.dart';
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
  var db = Firestore.instance;
  var decks = new List();

  _getFavoriteDecks() {
    db.collection("cr-top-decks").getDocuments()
        .then((snapshot) {
          setState(() {
            snapshot.documents.forEach((element) {
              decks.add(new Deck(element['deckId'], element['name'],
                  element['elixirCost'], element['winPercentage'], element['slot1'],
                  element['slot2'], element['slot3'], element['slot4'],
                  element['slot5'], element['slot6'], element['slot7'],
                  element['slot8'], element['link'], element['avatar']));
            });
            isInProgress = false;
          });
    });
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
          itemCount: decks.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CachedNetworkImage(imageUrl: decks[index].avatar),
                title: Text(decks[index].name),
                subtitle: Text('Elixir Cost: ' + decks[index].elixirCost +
                '\nWin Percentage: ' + decks[index].winPercentage),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  launch(decks[index].link);
                },
              ),
            );
          }),
      inAsyncCall: isInProgress,
      opacity: 0.5,
    );
  }
}
