import 'package:firebase_auth/firebase_auth.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;

// Sign In
  Future<String?> signUp({required String email, required String password}) async {
    try {
      await
      auth.signInWithEmailAndPassword(
          email: email,
          password: password);
      return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
  }
  //Login
  Future <String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "User Authenticated";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }


  //Reset password
  Future<String> resetPassword({required String email}) async {
    try {
      await
      auth.sendPasswordResetEmail(
          email: email
      );
      return 'Email Sent';
    }catch(e){
      return 'Error Occurred';
    }
  }

  //Sign Out

  void signOut(){
    auth.signOut();
  }

}