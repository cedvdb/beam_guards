import 'dart:async';

import 'package:rxdart/subjects.dart';

class AuthUser {}

class UnknownAuthUser extends AuthUser {}

class UnauthenticatedUser extends AuthUser {}

class AuthenticatedUser extends AuthUser {}

class AuthRepository {
  static final instance = AuthRepository._();

  BehaviorSubject<AuthUser> authUser$ =
      BehaviorSubject.seeded(UnknownAuthUser());

  AuthRepository._() {
    Future.delayed(Duration(seconds: 5))
        .then((_) => authUser$.add(UnauthenticatedUser()));
  }
}
