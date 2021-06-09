import 'dart:async';

import 'package:rxdart/subjects.dart';

class AuthUser {}

class LoadingAuthUser extends AuthUser {}

class UnauthenticatedUser extends AuthUser {}

class AuthenticatedUser extends AuthUser {}

class AuthRepository {
  static final instance = AuthRepository._();

  BehaviorSubject<AuthUser> authUser$ =
      BehaviorSubject.seeded(LoadingAuthUser());

  AuthRepository._() {
    Future.delayed(Duration(seconds: 5))
        .then((_) => authUser$.add(UnauthenticatedUser()));
  }
}
