import 'package:beamer/beamer.dart';
import 'package:beamer_guards/auth_repository.dart';
import 'package:beamer_guards/main.dart';

abstract class AppRouter {
  static final routerDelegate = BeamerDelegate(
    guards: [
      BeamGuard(
        pathBlueprints: ['/'],
        check: (ctx, state) => false,
        beamToNamed: '/home',
      ),
      BeamGuard(
        guardNonMatching: true,
        pathBlueprints: ['/loading'],
        check: (ctx, state) =>
            AuthRepository.instance.authUser$.value is! LoadingAuthUser,
        beamToNamed: '/loading',
      )
    ],
    locationBuilder: SimpleLocationBuilder(
      routes: {
        '/loading': (context, state) => LoadingPage(),
        '/home': (context, state) => HomePage(),
        '/login': (context, state) => LoginPage(),
      },
    ),
  );

  static final routerParser = BeamerParser();
}
