import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:provider/provider.dart';
import 'package:tinder/core/routing/router.dart';
import 'package:tinder/cubit/tinder_matches_cubit.dart';

// import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
//////////////////BLOC LEARNING

  // final bloc = CounterBloc();
  // print(bloc.state); // 0
  // bloc.add(CounterIncrementPressed());
  // await Future.delayed(Duration.zero);
  // print(bloc.state); // 1
  // await bloc.close();

  // final bloc = CounterBloc();
  // final subscription = bloc.stream.listen(print); // 1
  // bloc.add(CounterIncrementPressed());
  // await Future.delayed(Duration.zero);
  // await subscription.cancel();
  // await bloc.close();

  // CounterBloc()
  //   ..add(CounterIncrementPressed())
  //   ..close();

  Bloc.observer = SimpleBlocObserver();
  CounterBloc()
    ..add(CounterIncrementPressed())
    ..close();

  ///CUBIT LEARNING

  // Bloc.observer = SimpleBlocObserver();
  // final cubit = CounterCubit();
  // final subscription = cubit.stream.listen(
  //   (event) {},
  // ); // 1
  // cubit.emit(cubit.state + 1);
  // cubit.increment();
  // await Future.delayed(Duration.zero);
  // await subscription.cancel();
  // await cubit.close();

  // var stream = countStream(3);
  // var sum = await sumStream(stream);
  // print(sum);
  // var stream = generateIntStream();
  // // ...

  // var pos = await lastPositive(stream); // Wait for the Future<int> result
  // print(pos); // Now you can print the integer value

////////////////////////////////////////////////////

  // debugPaintSizeEnabled = true;
  // WidgetsFlutterBinding.ensureInitialized();
  RandomName.initRoutes();
  // usePathUrlStrategy();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TinderMatchesCubit(),
          child: const MaterialApp(),
        )
      ],
      child: MaterialApp.router(
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          useMaterial3: true,

          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.pink,
              // ···
              brightness: Brightness.light),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
            // ···
            titleLarge: GoogleFonts.oswald(
              fontSize: 30,
              fontStyle: FontStyle.italic,
            ),
            bodyLarge: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            bodyMedium: const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w100),
            // bodyMedium: GoogleFonts.merriweather(),
            displaySmall: GoogleFonts.pacifico(),
          ),
        ),
        debugShowCheckedModeBanner: false,
        routeInformationParser: RandomName.routeInformationParser,
        routerDelegate: RandomName.routemaster,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

/////////////////////////////////////////
///LEARNING STREAMS:
// Stream<int> countStream(int to) async* {
//   for (int i = 1; i <= to; i++) {
//     yield i;
//   }
// }

// Future<List> sumStream(Stream<int> stream) async {
//   List<int> numbers = [];
//   var sum = 0;
//   await for (final value in stream) {
//     numbers.add(value);
//     sum += value;
//   }
//   return numbers;
// }

///////////////////
///
Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw Exception('Intentional exception');
    } else {
      yield i;
    }
  }
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (final value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

Stream<int> generateIntStream() async* {
  for (int i = 0; i <= 10; i++) {
    yield i;
  }
}

Future<int> lastPositive(Stream<int> stream) async {
  var hi = await stream.lastWhere((x) => x >= 0);
  return hi;
}

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(5);

//   void increment() => emit(state + 1);
// }

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void increment() {
//     if (state + 1 == 2) {
//       addError(Exception('increment error!'), StackTrace.current);
//     }

//     emit(state + 1);
//   }

//   @override
//   void onChange(Change<int> change) {
//     super.onChange(change);
//     // print(change);
//   }

//   // @override
//   // void onError(Object error, StackTrace stackTrace) {
//   //   print('$error, $stackTrace');
//   //   super.onError(error, stackTrace);
//   // }
// }

// ///////////////////////

// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     // print('${bloc.runtimeType} $change');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     print("an error happened");
//     print("$bloc, $stackTrace");

//     super.onError(bloc, error, stackTrace);
//   }

//   // @override
//   // void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//   //   print('${bloc.runtimeType} $error $stackTrace');
//   //   super.onError(bloc, error, stackTrace);
//   // }
// }

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      addError(Exception('increment error!'), StackTrace.current);
      emit(state + 7);
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print("$event, I am onEvent");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // @override
  // void onChange(Change<int> change) {
  //   super.onChange(change);
  //   print(change);
  // }

  // @override
  // void onTransition(Transition<CounterEvent, int> transition) {
  //   super.onTransition(transition);
  //   print(transition);
  // }
}

//////////////////////////////////

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change, i am the onChange');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition, i am the on transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
