import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CobaFirebaseUser {
  CobaFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CobaFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CobaFirebaseUser> cobaFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CobaFirebaseUser>((user) => currentUser = CobaFirebaseUser(user));
