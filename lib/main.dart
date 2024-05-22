import 'package:firebase_core/firebase_core.dart';
import 'package:nf_og/services/auth.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/firebase_options.dart';
import 'package:nf_og/pages/intro/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nf_og/pages/onboard/onboard.dart';
import 'package:nf_og/pages/signin/signin.dart';
import 'package:nf_og/pages/signup/signup.dart';
import 'package:nf_og/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //* Setting statusbarcolor to kTransparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kTransparent,
  ));
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'news_flights',

          //* Removing the debug banner
          debugShowCheckedModeBanner: false,

          //* Setting up themedata of the app
          theme: themeProvider.themeData,
          home: const AuthStateChange(),

          //* App routes
          routes: {
            '/intro': (context) => const Intro(),
            '/auth': (context) => const AuthStateChange(),
            '/onboard': (context) => const Onboard(),
            '/onboard/signin': (context) => const SignIn(),
            '/onboard/signup': (context) => const SignUp(),
          },
        );
      },
    );
  }
}
