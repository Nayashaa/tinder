import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder/cubit/tinder_matches_cubit.dart';
import 'package:tinder/data/userData.dart';
import 'package:tinder/widgets/cart_tinder.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 600,
        child: BlocConsumer<TinderMatchesCubit, TinderMatchesState>(
            builder: (context, state) {
              if (state.listOfTinderMatches.isEmpty) {
                return const Center(child: Text("You havent liked anyone yet!"));
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: state.listOfTinderMatches.length,
                itemBuilder: (BuildContext context, index) {
                  User user = state.listOfTinderMatches[index];
                  final cubit = context.read<TinderMatchesCubit>();
                  return CartTinderCard(
                    passedFunctionMessage: () {
                      cubit.startConvo(user);
                    },
                    // passedFunctionUnmatch: cubit.removeMatch(user),
                    passedFunctionUnmatch: () {
                      cubit.removeMatch(user);
                    },
                    user: user,
                  );
                },
              );
            },
            listener: (context, state) {}),
      ),
    ));
    // children: List.generate(100, (index) => Text('$index')),
  }
}
