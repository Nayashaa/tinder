import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tinder/core/routing/contants.dart';
import 'package:tinder/designSystem/layout.dart';
import 'package:tinder/screens/conversations.dart';
import 'package:tinder/screens/liked.dart';
import 'package:tinder/screens/match.dart';

class RandomName {
  static const routeInformationParser = RoutemasterParser();
  static final routemaster = RoutemasterDelegate(
    routesBuilder: (context) {
      return routes();
    },
  );

  static void initRoutes() {
    Routemaster.setPathUrlStrategy();
  }

  static RouteMap routes() {
    return RouteMap(
      onUnknownRoute: (route) {
        return MaterialPage(
          name: 'Not Found',
          child: Scaffold(
            body: Center(
              child: Text(
                'Route $route not found',
              ),
            ),
          ),
        );
      },
      routes: {
        ROOT: (_) => IndexedPage(
              pageBuilder: (child) => MaterialPage(child: child),
              child: const AppScaffold(),
              paths: const [
                RANDOM_MATCH,
                CONVERSATIONS,
                FAVORITES,
                // ALBUMS
              ],
            ),
        RANDOM_MATCH: (route) => const MaterialPage(child: MatchPage()),
        CONVERSATIONS: (route) => const MaterialPage(child: ConversationsPage()),
        FAVORITES: (route) => const MaterialPage(
              child: LikedPage(),
            ),
        // ALBUMS: (route) => const MaterialPage(child: MyAlbum())
      },
    );
  }
}
