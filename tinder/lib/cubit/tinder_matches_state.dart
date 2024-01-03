part of 'tinder_matches_cubit.dart';

// @immutable
// sealed class TinderMatchesState {}

// final class TinderMatchesInitial extends TinderMatchesState {}

class TinderMatchesState {
  List<User> listOfTinderMatches;
  List<User> listOfNewMatches;
  List<User> listOfUserConversations;

  TinderMatchesState({required this.listOfUserConversations, required this.listOfTinderMatches, required this.listOfNewMatches});
}
