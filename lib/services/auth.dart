import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/intro/intro.dart';
import 'package:nf_og/pages/onboard/onboard.dart';
import 'package:nf_og/widgets/navbar/navbar.dart';

class AuthStateChange extends StatefulWidget {
  const AuthStateChange({super.key});

  @override
  State<AuthStateChange> createState() => _Auth();
}

class _Auth extends State<AuthStateChange> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        } else if (snapshot.hasData) {
          return const NavBar();
        } else {
          if(!introShowOnce){
            introShowOnce = !introShowOnce;
            return const Intro();
          }
          else {
            return const Onboard();
          }
        }
      },
    );
  }
}
