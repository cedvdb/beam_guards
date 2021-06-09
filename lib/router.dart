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
      // when starting the application, we check if the authenticated user is
      // already set. If not we go to the loading page.
      // however we need to redirect when the user is finally authenticated
      // or unauthenticated. We could redirect the user when he logs in / out
      // but that doesn't account for things happening on the server side.
      // For example there could be a property on firebase that when changed should
      // unauthenticate the user and that should be reflected in the UI.
      BeamGuard(
        guardNonMatching: true,
        pathBlueprints: ['/loading'],
        check: (ctx, state) =>
            AuthRepository.instance.authUser$.value is! UnknownAuthUser,
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
