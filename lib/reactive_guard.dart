import 'package:beamer/beamer.dart';
import 'package:beamer_guards/auth_repository.dart';
import 'package:beamer_guards/router.dart';
import 'package:flutter/material.dart';

class ReactiveGuard extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository.instance;
  final Widget child;

  ReactiveGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthUser>(
        stream: authRepository.authUser$,
        builder: (ctx, snap) {
          if (!snap.hasData) return CircularProgressIndicator();
          print(snap.data);
          AuthUser authUser = snap.data!;

          // in more complicated systems there is often more than one stream being listened onto and it sort of cascades here.

          if (authUser is UnknownAuthUser) {
            Beamer.of(context).beamToNamed(AppRouter.loadingRoute);
          }

          if (authUser is AuthenticatedUser) {
            Beamer.of(context).beamToNamed(AppRouter.homeRoute);
          }

          if (authUser is UnauthenticatedUser) {
            Beamer.of(context).beamToNamed(AppRouter.signInRoute);
          }
          return child;
        });
  }
}
