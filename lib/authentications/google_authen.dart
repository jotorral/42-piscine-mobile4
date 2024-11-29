import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleAuthen extends StatefulWidget{
  const GoogleAuthen({super.key});

  @override
  State<GoogleAuthen> createState() => _GoogleAuthenState();
}

class _GoogleAuthenState extends State<GoogleAuthen>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
//        Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen2(),));
      }
    }catch(e){
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al iniciar sesión: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: signInWithGoogle, child: const Text('Iniciar sesión con Google'));
  }
}
