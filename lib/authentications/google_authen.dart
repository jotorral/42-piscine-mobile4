import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:piscine_mobile_4/main.dart';

class GoogleAuthen extends StatefulWidget {
  const GoogleAuthen({super.key});

  @override
  State<GoogleAuthen> createState() => _GoogleAuthenState();
}

class _GoogleAuthenState extends State<GoogleAuthen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      userName = FirebaseAuth.instance.currentUser?.displayName;
      debugPrint(userName);
      (context.findAncestorStateOfType<PantallaPrincipalState>()!)
          .cambiarPantalla(2);
    } else {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn(); //await googleSignIn.signOut();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await _auth.signInWithCredential(credential);

          if (FirebaseAuth.instance.currentUser?.displayName != null) {
            userName = FirebaseAuth.instance.currentUser?.displayName;
            debugPrint(userName);
          }
          if (mounted) {
            (context.findAncestorStateOfType<PantallaPrincipalState>()!)
                .cambiarPantalla(2);
          }
//        Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen2(),));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al iniciar sesión: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: signInWithGoogle,
        child: const Text('Iniciar sesión con Google'));
  }
}
