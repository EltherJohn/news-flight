import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/onboard/components/outlined_default_button.dart';
import 'package:nf_og/pages/signin/signin.dart';
import 'package:nf_og/pages/signup/signup.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedDefaultButton(
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return const SignUp();
              }));
            },
            btnText: 'Sign Up',
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          OutlinedDefaultButton(
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return const SignIn();
              }));
            },
            btnText: 'Sign in',
          ),
        ],
      ),
    );
  }
}
