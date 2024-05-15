import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/forgot/forgot.dart';
import 'package:nf_og/pages/signup/components/clear_full_button.dart';
import 'package:nf_og/pages/signup/components/default_textfield.dart';

class SignInCTF extends StatelessWidget {
  const SignInCTF({
    super.key,
    required this.formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) : _emailController = emailController, _passwordController = passwordController;

  final GlobalKey<FormState> formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextField(
              validator: emailValidator,
              controller: _emailController,
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
              controller: _passwordController,
              hintText: 'Password',
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
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
