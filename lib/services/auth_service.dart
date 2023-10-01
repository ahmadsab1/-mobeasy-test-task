import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Signe in
  signInWithGoogle() async {
    // begin interactive signe in process
    final GoogleSignInAccount? eUser = await GoogleSignIn().signIn();

    // obtain auth details  from  request

    final GoogleSignInAuthentication eAuth = await eUser!.authentication;

    // create new credential for user

    final credential = GoogleAuthProvider.credential(
      accessToken: eAuth.accessToken,
      idToken: eAuth.idToken,
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  String? getUserEmail() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user.providerData.isNotEmpty) {
        for (var userInfo in user.providerData) {
          if (userInfo.providerId == GoogleAuthProvider.PROVIDER_ID) {
            // The user signed in with Google
            return userInfo.email;
          }
          // Add more conditions for other providers if needed
        }
      }
    }

    return null; // Return null if the user is not signed in or if the provider is not Google
  }
}
