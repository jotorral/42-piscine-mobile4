import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_sign_in/github_sign_in.dart';


class GitHubAuthen extends StatefulWidget{
  const GitHubAuthen({super.key});

  @override
  State<GitHubAuthen> createState() => _GitHubAuthenState();
}

class _GitHubAuthenState extends State<GitHubAuthen>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GitHubSignIn gitHubSignIn = GitHubSignIn(clientId: "621645718668-jf7ua52jok73rfn2n0g39mqjuo2u0s6t.apps.googleusercontent.com");

  Future<void> signInWithGitHub() async {
    try{
      final GitHubSignInAccount? gitHubSignInAccount = await gitHubSignIn.signIn();
      if(gitHubSignInAccount != null){
        final GitHubSignInAuthentication gitHubSignInAuthentication = await gitHubSignInAccount.authentication;
        final AuthCredential credential = GitHubAuthProvider.credential(
          accessToken: gitHubSignInAuthentication.accessToken,
          idToken: gitHubSignInAuthentication.idToken,
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
    return ElevatedButton(onPressed: signInWithGitHub, child: const Text('Iniciar sesión con GitHub'));
  }
}
