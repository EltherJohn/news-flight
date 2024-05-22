import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/forgot/forgot.dart';
import 'package:nf_og/pages/signup/components/clear_full_button.dart';
import 'package:nf_og/pages/signup/components/default_textfield.dart';

class SignInCTF extends StatefulWidget {
  const SignInCTF({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  _SignInCTFState createState() => _SignInCTFState();
}

class _SignInCTFState extends State<SignInCTF> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextField(
              validator: emailValidator,
              controller: widget.emailController,
              hintText: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            const SizedBox(
              height: kFixPadding,
            ),
            DefaultTextField(
              validator: passwordValidator,
              controller: widget.passwordController,
              hintText: 'Password',
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_isPasswordVisible,
              isObscure: _togglePasswordVisibility,
            ),
            const SizedBox(
              height: kFixPadding,
            ),
            ClearFullButton(
              whiteText: 'I forgot my ',
              colorText: 'Password',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Forgot();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
