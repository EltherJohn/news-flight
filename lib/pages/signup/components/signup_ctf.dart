import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/signup/components/default_textfield.dart';

class SignUpCTF extends StatefulWidget {
  const SignUpCTF({
    super.key,
    required this.formKey,
    required TextEditingController userController,
    required TextEditingController emailController,
    required TextEditingController passwordController1,
    required TextEditingController passwordController2,
  })  : _userController = userController,
        _emailController = emailController,
        _passwordController1 = passwordController1,
        _passwordController2 = passwordController2;

  final GlobalKey<FormState> formKey;
  final TextEditingController _userController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController1;
  final TextEditingController _passwordController2;

  @override
  State<SignUpCTF> createState() => _SignUpCTFState();
}

class _SignUpCTFState extends State<SignUpCTF> {
  bool _isObscure = true;
  bool _isObscure1 = true;

  void _validatePasswords() {
    if (widget._passwordController1.text != widget._passwordController2.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match. Please make sure both passwords are the same.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Passwords match, you can proceed with further actions here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DefaultTextField(
              validator: (value) {
                return null;
              },
              controller: widget._userController,
              hintText: 'Username',
              icon: Icons.person,
              keyboardType: TextInputType.text,
              obscureText: false,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            DefaultTextField(
              validator: emailValidator,
              controller: widget._emailController,
              hintText: 'Email Address',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            DefaultTextField(
              validator: passwordValidator,
              controller: widget._passwordController1,
              hintText: 'Password',
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscure,
              isObscure: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            DefaultTextField(
              validator: passwordValidator,
              controller: widget._passwordController2,
              hintText: 'Confirm Password',
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscure1,
              isObscure: () {
                setState(() {
                  _isObscure1 = !_isObscure1;
                });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            // ElevatedButton(
            //   onPressed: _validatePasswords,
            //   child: Text('Sign Up'),
            // ),
          ],
        ),
      ),
    );
  }
}
