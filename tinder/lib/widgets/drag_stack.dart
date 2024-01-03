import 'package:flutter/material.dart';
import 'package:tinder/screens/match.dart';

class DragStack extends StatelessWidget {
  const DragStack({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 500,
      child: Stack(children: [
        Draggable(
            feedback: Container(
              color: Colors.cyan,
              width: 50,
              height: 50,
            ),
            child: Container(
              color: Colors.cyan,
              width: 50,
              height: 50,
            )),
        Dismissible(
          key: const Key("draggable"),
          child: Draggable(
              childWhenDragging: Container(
                color: const Color.fromARGB(0, 85, 212, 0),
                width: 50,
                height: 50,
              ),
              feedback: Container(
                color: Colors.pink,
                width: 50,
                height: 50,
              ),
              child: Container(
                color: Colors.pink,
                width: 50,
                height: 50,
              )),
        )
      ]),
    );
  }
}

class Again extends StatefulWidget {
  const Again({Key? key}) : super(key: key);

  @override
  _AgainState createState() => _AgainState();
}

class _AgainState extends State<Again> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3'
  ]; // Your list of items

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: 200,
      height: 50,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              if (direction == Swipe.left) {
                setState(() {
                  items.removeAt(index);
                });
              }
            },
            child: ListTile(
              title: Text(item),
            ),
          );
        },
      ),
    );
  }
}
