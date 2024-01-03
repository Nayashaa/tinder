
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/cubit/tinder_matches_cubit.dart';
import 'package:tinder/data/userData.dart';

const descTextStyle = TextStyle(
  color: Color.fromARGB(255, 0, 0, 0),
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: descTextStyle,
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Center(
            child: Scaffold(
              appBar: const TabBar(labelColor: Color.fromARGB(255, 54, 131, 203), unselectedLabelColor: Color.fromARGB(255, 164, 164, 164), overlayColor: MaterialStatePropertyAll(Color.fromARGB(170, 227, 246, 255)), tabs: [
                Tab(
                  text: "Active",
                ),
                Tab(
                  text: "Archive",
                  // icon: Icon(Icons.directions_car)
                ),
              ]),
              body: BlocConsumer<TinderMatchesCubit, TinderMatchesState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return TabBarView(children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: state.listOfUserConversations.length,
                              itemBuilder: (BuildContext context, int index) {
                                User user = state.listOfUserConversations[index];
                                final cubit = context.read<TinderMatchesCubit>();

                                return InkWell(
                                    onTap: () {
                                      cubit.toggleConversation(user);
                                    },
                                    child: ChatPreviewCard(user: user));
                              }),
                        ),
                        Container(
                          // color: const Color.fromARGB(255, 255, 255, 255),
                          decoration: const BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: Color.fromARGB(85, 71, 95, 116)))),
                          width: MediaQuery.of(context).size.width / 2,
                          child: BlocConsumer<TinderMatchesCubit, TinderMatchesState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              User? chattingUser; // Variable to hold the chatting user, initialized as null

                              // Loop through the list to find the user that is chatting
                              for (var element in state.listOfUserConversations) {
                                if (element.isChatting == true) {
                                  chattingUser = element;
                                  break; // Exit loop when the chatting user is found
                                }
                              }

                              // Check if a chatting user was found, build UI accordingly
                              if (chattingUser != null) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border.symmetric(
                                          horizontal: BorderSide(color: Color.fromARGB(85, 71, 95, 116)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(chattingUser.URLimage),
                                                  radius: 20.0,
                                                ),
                                              ),
                                              Text(
                                                chattingUser.name,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.call),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.video_call),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.info),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Column(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.add),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.image),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.gif),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                              width: 200,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions)),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(40.0),
                                                  ),
                                                  filled: true,
                                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                                  hintText: "Aa",
                                                  fillColor: const Color.fromARGB(179, 224, 224, 224),
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                                        )
                                      ],
                                    ),
                                    // Build UI using the chattingUser
                                    // Other UI elements based on the chattingUser
                                  ],
                                );
                              } else {
                                // If no chatting user found, display default UI
                                return const Column(
                                  children: [
                                    Text('No user is currently chatting.'),
                                    // Other default UI elements
                                  ],
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    // Container(decoration: const BoxDecoration(color: Colors.tealAccent), child: const Text("yo")),
                    const Icon(Icons.directions_transit),
                  ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatPreviewCard extends StatelessWidget {
  const ChatPreviewCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(10, 0, 0, 0), borderRadius: BorderRadius.all(Radius.circular(10))),
        // color: const Color.fromARGB(36, 0, 0, 0),
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(user.URLimage),
                    radius: 30.0,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Row(
                        children: [
                          Text("Hey whats up?"),
                          Text(
                            "10m",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Icon(
                Icons.circle,
                size: 12,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// final items = List<String>.generate(1000, (i) => i % 6 == 0);

// final items = List<ListItem>.generate(
//   1000,
//   (i) => i % 6 == 0 ? HeadingItem('Heading $i') : MessageItem('Sender $i', 'Message body $i'),
// );

final fixedLengthList = List<int>.generate(3, (int index) => index * index, growable: false);
print(fixedLengthList) {
  // TODO: implement print
  throw UnimplementedError();
}
