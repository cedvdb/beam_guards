import 'package:beamer/beamer.dart';
import 'package:beamer_guards/auth_repository.dart';
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
          AuthUser authUser = snap.data!;
          if (authUser is UnknownAuthUser) {
            Beamer.of(context).beamTo(location)
          }
        });
  }
}
