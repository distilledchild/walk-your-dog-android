import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../config/api_keys.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // GoogleSignIn is now a singleton
  GoogleSignIn get _googleSignIn => GoogleSignIn.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize the GoogleSignIn instance
      await _googleSignIn.initialize(
        serverClientId: ApiKeys.googleServerClientId,
      );

      // Trigger the authentication flow
      // authenticate() replaces signIn() and throws on error/cancellation?
      // It returns a non-nullable GoogleSignInAccount.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Obtain the auth details from the request
      // authentication is now synchronous
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      // Note: accessToken is no longer directly available in GoogleSignInAuthentication
      // for authentication purposes, idToken is usually sufficient for Firebase.
      final credential = GoogleAuthProvider.credential(
        accessToken: null, 
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      // print('Error signing in with Google: $e');
      // If it's a cancellation, we might want to return null, but for now rethrow or handle specific error codes
      // Assuming rethrow to maintain similar behavior for errors, but original code returned null on cancel.
      // We can't easily distinguish cancel without checking error type.
      rethrow;
    }
  }

  // Sign in with Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Trigger the Facebook authentication flow
      final LoginResult result = await _facebookAuth.login(
        permissions: ['public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;

        // Create a credential from the access token
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);

        // Sign in to Firebase with the Facebook credential
        return await _auth.signInWithCredential(credential);
      } else if (result.status == LoginStatus.cancelled) {
        // User cancelled the login
        return null;
      } else {
        throw Exception('Facebook login failed: ${result.message}');
      }
    } catch (e) {
      // print('Error signing in with Facebook: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (e) {
      // print('Error signing out: $e');
      rethrow;
    }
  }

  // Check if user is signed in
  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  // Get user display name
  String? getUserDisplayName() {
    return _auth.currentUser?.displayName;
  }

  // Get user email
  String? getUserEmail() {
    return _auth.currentUser?.email;
  }

  // Get user photo URL
  String? getUserPhotoUrl() {
    return _auth.currentUser?.photoURL;
  }
}
