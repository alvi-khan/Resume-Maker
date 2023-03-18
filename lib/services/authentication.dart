import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> createUser({required String email, required String password}) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    return auth.currentUser;
  }

  static Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await auth.signInWithCredential(credential);
    return auth.currentUser;
  }

  static Future<User?> loginUsingEmailPassword({required String email, required String password}) async {
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("No user found for that email");
      }
    }
    return user;
  }
}