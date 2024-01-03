import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/cubit/tinder_matches_cubit.dart';
import 'package:tinder/data/userData.dart';

class AnimatedPhotoContainer extends StatefulWidget {
  const AnimatedPhotoContainer({super.key, required this.user});

  final User user;
  @override
  State<AnimatedPhotoContainer> createState() => _AnimatedPhotoContainerState();
}

class _AnimatedPhotoContainerState extends State<AnimatedPhotoContainer> {
  bool selected = false;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          isVisible = !isVisible;
        });
      },
      child: Column(children: [
        Stack(
          children: [
            AnimatedContainer(
              width: selected ? 400.0 : 350.0,
              height: selected ? 550.0 : 450.0,
              // color: selected ? Colors.red : Colors.blue,
              alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
              duration: const Duration(seconds: 2),
              // curve: Curves.fastOutSlowIn,
              child: Card(
                  child: Stack(
                children: [
                  Image.asset(
                    widget.user.URLimage,
                    width: 600,
                    height: 550,
                  ),
                  Positioned(
                      bottom: 0,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 2),
                        opacity: selected ? 1 : 0,
                        child: Container(
                          width: 400,
                          height: 100,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Color.fromARGB(87, 255, 255, 255)
                            ],
                          )),
                          child: Text(widget.user.name),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    child: BlocConsumer<TinderMatchesCubit, TinderMatchesState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Visibility(
                          visible: isVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(onPressed: () {}, icon: const Icon(Icons.cancel), label: const Text("")),
                              TextButton.icon(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return const AlertDialog(
                                            title: Text("Matched!"),
                                          );
                                        });
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      setState(() {
                                        final cubit = context.read<TinderMatchesCubit>();
                                        cubit.addMatch(widget.user);
                                      });
                                    });
                                  },
                                  icon: const Icon(Icons.check),
                                  label: const Text("")),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ]

          //
          ),
    );
  }
}
