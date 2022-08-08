import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential?> google() async {
  await Firebase.initializeApp();

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn(
    scopes: <String>['email', 'profile'],
  ).signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential
  var user = await FirebaseAuth.instance.signInWithCredential(credential);
  return user;
}

Future<UserCredential?> facebook() async {
  await Firebase.initializeApp();
  final LoginResult loginResult = await FacebookAuth.instance.login(
    permissions: <String>['email', 'public_profile'],
  );

  if (loginResult.accessToken == null) {
    return null;
  }

  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(
    loginResult.accessToken!.token,
  );

  var provider = FacebookAuthProvider();
  FirebaseAuth.instance.signInWithPopup(provider);

  return await FirebaseAuth.instance.signInWithCredential(
    facebookAuthCredential,
  );
}

Future<dynamic> init({
  String credential = "google",
}) async {
  UserCredential? user;

  if (credential == 'google') {
    user = await google();
  } else {
    user = await facebook();
  }

  if (user == null) return false;

  return user;
}
