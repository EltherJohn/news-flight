import 'package:firebase_auth/firebase_auth.dart';
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
  
  //* 1
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  //* sign in button nga function
  Future signIn() async {
    
    try {
      //* gi sign in ang imong account gamit ang details nga naa sa textfield
      //* e verify ang details if na exist ba  sa database
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //* IMPORTANTE NI IF MAG LOG IN
      
      //* mo navigate siya sa home page
      Navigator.of(context).pushNamedAndRemoveUntil('/auth', (route) => false);
      
      
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
              // SigninCTF(emailController: _emailController, passwordController: _passwordController),
              SignInCTF(formKey: formKey, emailController: _emailController, passwordController: _passwordController),
              BottomWidgets(
                cfbText1: 'Sign Up',
                cfbText2: 'Don\'t have an account? ',
                btnText: 'Sign In',
                onPressed1: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return SignUp();
                  //   },
                  //                  ));
                  
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