import 'package:bloc/bloc.dart';
import 'package:tinder/data/userData.dart';

part 'tinder_matches_state.dart';

class TinderMatchesCubit extends Cubit<TinderMatchesState> {
  TinderMatchesCubit()
      : super(TinderMatchesState(listOfUserConversations: [], listOfTinderMatches: [], listOfNewMatches: [
          User("Mary Kate", "/Users/natashamonk/workspace/flutter/tinder/tinder/assets/images/tinder_girl_2.jpeg", 23, "i like to party", "hdkaye86", false),
          User("Ash Lee", "/Users/natashamonk/workspace/flutter/tinder/tinder/assets/images/tindergirl.jpeg", 29, "all phases of the moon", "fdhkhiuhfe998", false),
          User("Darren koe", "/Users/natashamonk/workspace/flutter/tinder/tinder/assets/images/darren_koe.jpeg", 26, "yo whats up ", "foljfrljfe89", false),
        ]));

  void toggleConversation(User clickedUser) {
    // User? chattingUser;
    for (var element in state.listOfUserConversations) {
      if (element == clickedUser) {
        // Toggle isChatting for the clicked user
        element.isChatting = true;
      } else {
        // Set isChatting to false for other users
        element.isChatting = false;
      }
    }

    emit(TinderMatchesState(listOfUserConversations: [
      ...state.listOfUserConversations,
    ], listOfTinderMatches: [
      ...state.listOfNewMatches
    ], listOfNewMatches: [
      ...state.listOfNewMatches
    ]));
  }

  void addMatch(User likedUser) {
    emit(TinderMatchesState(
        listOfUserConversations: [
          ...state.listOfUserConversations
        ],
        listOfNewMatches: state.listOfNewMatches..remove(likedUser),
        listOfTinderMatches: [
          ...state.listOfTinderMatches,
          likedUser
        ]));
  }

  void startConvo(User userToMessage) {
    emit(TinderMatchesState(listOfUserConversations: [
      ...state.listOfUserConversations,
      userToMessage
    ], listOfTinderMatches: [
      ...state.listOfTinderMatches
    ], listOfNewMatches: [
      ...state.listOfNewMatches
    ]));
  }

  void removeMatch(User unlikedUser) {
    emit(TinderMatchesState(listOfUserConversations: [
      ...state.listOfUserConversations
    ], listOfNewMatches: state.listOfNewMatches..remove(unlikedUser), listOfTinderMatches: state.listOfTinderMatches..remove(unlikedUser)));
  }
}
