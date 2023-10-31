import 'package:flutter/foundation.dart';

class GlobalState with ChangeNotifier {
  List<List<int>> cards = [];

  void addCard() {
    cards.add([0]);
    notifyListeners(); // memberitahu provider bahwa ada perubahan di dalam state
  }

  int getCount(int cardIndex) {
    return cards[cardIndex][0];
  }

  void incrementCounter(int cardIndex) {
    cards[cardIndex][0]++;
    notifyListeners();
  }

  void decrementCounter(int cardIndex) {
    if (cards[cardIndex][0] > 0) {
      cards[cardIndex][0]--;
      notifyListeners();
    }
  }

  void removeCard(int cardIndex) {
    cards.removeAt(cardIndex);
    notifyListeners();
  }

  void reorderCards(int startIndex, int endIndex) {
    var movedCard = cards[startIndex];
    cards.removeAt(startIndex);
    cards.insert(endIndex, movedCard);
    notifyListeners();
  }
}
