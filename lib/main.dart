import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:management_global/globalState.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MyStatefulWidgetApp(),
    ),
  );
}

class MyStatefulWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var globalState = Provider.of<GlobalState>(context);
    var cards = globalState.cards;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Stateful Counter App')),
        body: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                globalState.addCard();
              },
              child: Text('Tambah Kartu'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  globalState.reorderCards(oldIndex, newIndex);
                },
                children: cards.asMap().entries.map((entry) {
                  var cardIndex = entry.key;
                  return Dismissible(
                    key: ValueKey(cardIndex),
                    onDismissed: (direction) {
                      globalState.removeCard(cardIndex);
                    },
                    child: DraggableCardWidget(cardIndex: cardIndex),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableCardWidget extends StatelessWidget {
  final int cardIndex;

  DraggableCardWidget({required this.cardIndex});

  Color getCardColor(int index) {
    // Daftar warna yang bisa digunakan
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      // Tambahkan warna lainnya sesuai kebutuhan
    ];

    // Menggunakan modulo untuk memastikan indeks tetap dalam rentang warna yang tersedia
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    var globalState = Provider.of<GlobalState>(context);
    return Card(
      color: getCardColor(cardIndex), // Mengatur warna card
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Kartu ${cardIndex + 1}'),
                Text('Counter Value: ${globalState.getCount(cardIndex)}'),
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    globalState.incrementCounter(cardIndex);
                  },
                  child: Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    globalState.decrementCounter(cardIndex);
                  },
                  child: Text('Decrement'),
                ),
                ElevatedButton(
                  onPressed: () {
                    globalState.removeCard(cardIndex);
                  },
                  child: Text('Hapus Kartu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
