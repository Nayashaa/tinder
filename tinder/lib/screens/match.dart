import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/cubit/tinder_matches_cubit.dart';
import 'package:tinder/data/userData.dart';
import 'package:tinder/screens/conversations.dart';

import 'package:tinder/core/routing/contants.dart';
import 'package:tinder/core/routing/router.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Matches",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              // color: Colors.amber,
              width: 800,
              height: 500,
              child: Center(
                child: BlocConsumer<TinderMatchesCubit, TinderMatchesState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    // User user = state.listOfNewMatches[index];
                    final cubit = context.read<TinderMatchesCubit>();
                    return Stack(
                      children: [
                        for (var i in state.listOfNewMatches) DragFeature(i: i, cubit: cubit)
                      ],
                    );
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                RandomName.routemaster.push(FAVORITES);
              },
              child: const Text("go to your likes"),
            ),
          ],
        ),
      ),
    );
  }
}

class DragFeature extends StatelessWidget {
  const DragFeature({
    super.key,
    required this.i,
    required this.cubit,
  });

  final User i;
  final TinderMatchesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Draggable(
        childWhenDragging: Container(
          width: 450,
          height: 500,
          color: const Color.fromARGB(80, 255, 255, 255),
        ),
        feedback: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 0) {
              print("dragging left");
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {}
          },
          child: TinderCardWidget(
              user: i,
              passedLikedFuction: () {
                cubit.addMatch(i);
              },
              passedDislikedFuction: () {
                cubit.removeMatch(i);
              }),
        ),
        child: TinderCardWidget(
            user: i,
            passedLikedFuction: () {
              cubit.addMatch(i);
            },
            passedDislikedFuction: () {
              cubit.removeMatch(i);
            }),
        onDragEnd: (details) {
          final dx = details.offset.dx;
          if (dx < 0) {
            alert("Disliked!", context);
            cubit.removeMatch(i);
          } else {
            alert("Matched!", context);
            cubit.addMatch(i);
          }
        });
  }
}

class TinderCardWidget extends StatelessWidget {
  const TinderCardWidget({Key? key, required this.user, required this.passedLikedFuction, required this.passedDislikedFuction}) : super(key: key);
  final User user;
  final passedLikedFuction;
  final passedDislikedFuction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 400, // Set a fixed width
        height: 500, // Set a fixed height
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(user.URLimage, fit: BoxFit.fill, width: double.infinity, height: 460),
              Positioned(
                bottom: 45,
                left: 0,
                right: 0,
                child: Container(
                  // color: Colors.amber,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.age.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        user.bio,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                          Text("4 miles away"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            tooltip: "Previous match",
                            hoverColor: Theme.of(context).colorScheme.primaryContainer,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        IconButton(
                            tooltip: "Dislike",
                            hoverColor: Theme.of(context).colorScheme.primaryContainer,
                            onPressed: () {
                              alert("Disliked!", context);
                              passedDislikedFuction();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        IconButton(
                            tooltip: "SuperLike!",
                            onPressed: () {},
                            hoverColor: Theme.of(context).colorScheme.primaryContainer,
                            icon: Icon(
                              Icons.star,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        IconButton(
                            tooltip: "Like",
                            hoverColor: Theme.of(context).colorScheme.primaryContainer,
                            onPressed: () {
                              alert("matched!", context);
                              passedLikedFuction();
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Theme.of(context).colorScheme.primary,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum Swipe {
  left,
  right,
  none
}

class TinderCardWidgetDrag extends StatefulWidget {
  const TinderCardWidgetDrag({super.key, required this.user, required this.passedFunctionMatch, required this.passedFunctionDislike});
  final User user;
  final passedFunctionMatch;
  final passedFunctionDislike;

  @override
  State<TinderCardWidgetDrag> createState() => _TinderCardWidgetDragState();
}

class _TinderCardWidgetDragState extends State<TinderCardWidgetDrag> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        ClipRRect(
          // borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: DragTarget<int>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(color: const Color.fromARGB(82, 123, 123, 123), width: 50, height: 400, child: const Center(child: Icon(Icons.heart_broken)));
            },
            onAccept: (int data) {
              alert("Goodbye!", context);
              widget.passedFunctionDislike();
            },
          ),
        ),
        Draggable<int>(
          data: 10,
          feedback: fadeImage(widget.user.URLimage),
          childWhenDragging: Container(
            width: 300,
            height: 400,
            color: const Color.fromARGB(0, 255, 255, 255),
            child: const Center(
              child: Text('Drag to make your decision'),
            ),
          ),
          child: Image.asset(
            widget.user.URLimage,
            width: 300,
            height: 400,
          ),
        ),
        DragTarget<int>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(color: const Color.fromARGB(62, 149, 243, 33), width: 50, height: 400, child: const Center(child: Icon(Icons.favorite)));
          },
          onAccept: (int data) {
            alert("Matched!", context);

            Future.delayed(const Duration(milliseconds: 500), () {
              widget.passedFunctionMatch();
            });
          },
        )
      ]),
    );
  }
}

fadeImage(image) {
  return Transform.rotate(
    angle: 0.04,
    child: Image.asset(
      image,
      width: 300,
      height: 400,
      color: Colors.white.withOpacity(0.8),
      colorBlendMode: BlendMode.modulate,
    ),
  );
}

alert(String message, context) {
  String message1 = message;

  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Text(message1),
        );
      });
}
