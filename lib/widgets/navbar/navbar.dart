import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/pages/accounts/accounts.dart';
import 'package:nf_og/pages/bookmark/bookmark.dart';
import 'package:nf_og/pages/home/home.dart';
import 'package:nf_og/pages/profile/profile.dart';
import 'package:nf_og/pages/report/report.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // Add initialization code here if needed
  }

  List<Widget> widgetOptions() {
    return (user?.email == "admin@gmail.com")
        ? [
            Home(articles: glbArticles),
            Bookmark(bm: bm),
            const Report(),
            const Accounts(),
            const Profile(),
          ]
        : [
            Home(articles: glbArticles),
            Bookmark(bm: bm),
            const Profile(),
          ];
  }

  // List of the pages titles
  List<String> titleList = [];

  void onTap(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = (user?.email == "admin@gmail.com")
        ? <Widget>[
            const Icon(Icons.home, size: 25),
            const Icon(Icons.bookmark, size: 25),
            const Icon(Icons.report, size: 25),
            const Icon(Icons.manage_accounts, size: 25),
            const Icon(Icons.person, size: 25),
          ]
        : <Widget>[
            const Icon(Icons.home, size: 25),
            const Icon(Icons.bookmark, size: 25),
            const Icon(Icons.person, size: 25),
          ];

    titleList = (user?.email == "admin@gmail.com")
        ? [
            'General',
            'Bookmark',
            'Report Logs',
            'Manage Accounts',
            'Profile',
          ]
        : [
            'General',
            'Bookmark',
            'Profile',
          ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              titleList[index],
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).colorScheme.primary,
        backgroundColor: kTransparent,
        items: items,
        index: index,
        height: 60,
        buttonBackgroundColor: Theme.of(context).colorScheme.background,
        onTap: onTap,
      ),
      body: IndexedStack(
        index: index,
        children: widgetOptions(),
      ),
    );
  }
}
