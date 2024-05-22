import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/intro/components/empty_appbar.dart';
import 'package:nf_og/pages/onboard/components/top_logo.dart';
import 'package:nf_og/pages/signin/components/signin_ctf.dart';
import 'package:nf_og/pages/signup/components/bottom_widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check the user's report count
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        final userData = userDoc.data();

        if (userData != null && userData['reportCount'] >= 3) {
          // Show account disabled message and sign out the user
          await FirebaseAuth.instance.signOut();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Account Disabled'),
                content: const Text('Your account has been disabled due to multiple reports.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          return;
        }

        // Navigate to the home page if the account is not disabled
        Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      formKey.currentState!.validate();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EmptyAppBar(),
      backgroundColor: kDarkColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const TopLogo(),
              SignInCTF(formKey: formKey, emailController: _emailController, passwordController: _passwordController),
              BottomWidgets(
                cfbText1: 'Sign Up',
                cfbText2: 'Don\'t have an account? ',
                btnText: 'Sign In',
                onPressed1: () {
                  Navigator.of(context).pushReplacementNamed('/onboard/signup');
                },
                onPressed2: signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
