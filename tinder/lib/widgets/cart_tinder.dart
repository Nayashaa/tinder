import 'package:flutter/material.dart';
import 'package:tinder/core/routing/contants.dart';
import 'package:tinder/core/routing/router.dart';
import 'package:tinder/data/userData.dart';

class CartTinderCard extends StatelessWidget {
  final User user;
  final passedFunctionUnmatch;
  final passedFunctionMessage;

  const CartTinderCard({super.key, required this.passedFunctionMessage, required this.user, required this.passedFunctionUnmatch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 400,
        width: 300,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                user.URLimage,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: SizedBox(
                  // color: Colors.deepOrange,
                  width: 260,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.green,
                        child: Row(
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            Text(user.age.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        // color: Colors.amber,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(user.bio, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.w100)),
                            // SizedBox(
                            //   width: 60,
                            // ),
                            Container(
                              // color: Colors.brown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Tooltip(
                                    message: "Unmatch",
                                    child: IconButton(
                                      onPressed: () {
                                        passedFunctionUnmatch();
                                      },
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                      ),
                                      color: const Color.fromARGB(165, 255, 255, 255),
                                    ),
                                  ),
                                  Tooltip(
                                    message: "Message",
                                    child: IconButton(
                                      onPressed: () {
                                        passedFunctionMessage();
                                        RandomName.routemaster.push(CONVERSATIONS);
                                      },
                                      icon: const Icon(Icons.chat_bubble_outline_rounded),
                                      color: const Color.fromARGB(158, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
