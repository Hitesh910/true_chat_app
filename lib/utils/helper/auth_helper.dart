import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper
{
  static AuthHelper helper = AuthHelper._();

  AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  Future<String?> signUp(String email,String password)
  async {
    try
        {
            await auth.createUserWithEmailAndPassword(email: email,password: password,);

            return "Success";
        }
        on FirebaseException catch (e) {
      return e.message;
        }
  }

  Future<String?> signIn(String email,String password)
  async {
    try
        {
          await auth.signInWithEmailAndPassword(email: email, password: password,);

          return "Success";
        }
        on FirebaseException catch (e) {
      return e.message;
        }
  }

  Future<void> signOut()
  async {
    await auth.signOut();
  }

  bool checkUser()
  {
    user = auth.currentUser;
    return user!=null;
  }

  Future<String> signInWithGoogleEmailAndPassword()
  async {
     GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

     GoogleSignInAuthentication? googleAuth = await googleAccount?.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken:googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCred =await auth.signInWithCredential(credential);

    user = userCred.user;
    if(user != null)
      {
        return "Success";
      }
    else
      {
        return "Failed";
      }
  }
}