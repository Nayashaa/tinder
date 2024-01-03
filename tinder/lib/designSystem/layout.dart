import 'package:flutter/material.dart';

import 'package:routemaster/routemaster.dart';
import 'package:tinder/core/routing/contants.dart';
import 'package:tinder/core/routing/router.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final indexedPage = IndexedPage.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Center(
                  child: Text(
                    'Find your Soulmate!',
                  ),
                ),
              ],
            ),
            // IconButton(
            //   onPressed: () {
            //     context.read<ThemeRepo>().switchTheme();
            //   },
            //   icon: context.watch<ThemeRepo>().themeMode == ThemeMode.light ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
            // ),
          ],
        ),
      ),
      body: PageStackNavigator(
        stack: indexedPage.currentStack,
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              RandomName.routemaster.push(RANDOM_MATCH);
            case 1:
              RandomName.routemaster.push(CONVERSATIONS);
            case 2:
              RandomName.routemaster.push(FAVORITES);
            // case 3:
            //   RandomName.routemaster.push(ALBUMS);
          }
        },
        selectedIndex: indexedPage.index,
        destinations: <Widget>[
          NavigationDestination(
            icon: Semantics(
              container: true,
              label: 'Match',
              image: true,
              child: const Icon(Icons.favorite),
            ),
            label: 'Match',
          ),
          NavigationDestination(
            icon: Semantics(
              container: true,
              label: 'Talk',
              image: true,
              child: const Icon(Icons.list_rounded),
            ),
            label: 'Talk',
          ),
          NavigationDestination(
            icon: Semantics(
              container: true,
              label: 'Favorite',
              image: true,
              child: const Icon(Icons.bookmark),
            ),
            label: 'Favorite',
          ),
          // NavigationDestination(
          //   icon: Semantics(
          //     container: true,
          //     label: 'Favorites',
          //     image: true,
          //     child: const Icon(Icons.bookmark),
          //   ),
          //   label: 'Favorites',
          // ),
        ],
      ),
    );
  }
}
