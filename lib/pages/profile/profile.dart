import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nf_og/components/button.dart';
import 'package:nf_og/constant.dart';
import 'package:nf_og/model/article.dart';
import 'package:nf_og/pages/aboutus/aboutus_page.dart'; // Import the aboutus_page.dart file
import 'package:nf_og/pages/profile/components/edit_profile.dart';
import 'package:nf_og/pages/signup/components/default_button.dart';
import 'package:nf_og/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> data = {};

  // Add this method to fetch the profile picture URL from Firestore
  Future<String?> getProfilePictureUrl() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('${currUser?.uid}')
        .get();
    final data = snapshot.data();
    return data?['profileImageURL'];
  }

  // Sign out button
  DefaultButton signOutButton() {
    return DefaultButton(
      btnText: 'Sign Out',
      onPressed: FirebaseAuth.instance.signOut,
    );
  }

  // Edit button
  IconButton editInfoButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditProfileUI(
              user: currUser,
              refresh: () {
                setState(() {});
              },
            ),
          ),
        );
      },
      icon: Icon(
        Icons.mode_edit_outline_outlined,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  // Profile UI
  Container profileUI(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
                      offset: const Offset(0, 10),
                    )
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : NetworkImage(
                            'https://www.pngall.com/wp-content/uploads/5/Profile-PNG-File.png'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            'Username:',
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            data['username'],
            style: TextStyle(
              letterSpacing: 1.0,
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Email:',
            style: TextStyle(
              letterSpacing: 2.0,
              color: Colors.blue,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '${currUser?.email}',
            style: TextStyle(
              letterSpacing: 1.0,
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          signOutButton(),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
            child: Text("About Us"),
          ),
        ],
      ),
    );
  }

  // Get user info
  // Modify the getUserInfo method to use the fetched URL
  Widget getUserInfo(
      BuildContext context, AsyncSnapshot<DocumentSnapshot?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text("Error: ${snapshot.error}"));
    } else if (!snapshot.hasData ||
        snapshot.data == null ||
        snapshot.data!.data() == null) {
      // Handle case where data is not available
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No data available"),
            ElevatedButton(
              onPressed: () {
                // You can replace this with your desired navigation logic
                FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      );
    } else {
      data = snapshot.data!.data() as Map<String, dynamic>;

      // Your existing code for processing the data and returning the profile UI
      userGlbData = data;
      bmArticles = userGlbData['bookmark'] ??
          {}; // Use an empty map if 'bookmark' is null

      bm = [];

      bmArticles.forEach((key, value) {
        ArticleModel article = ArticleModel(
          title: key,
          author: value['author'],
          bookmark: value['bookmark'],
          content: value['content'],
          description: value['description'],
          url: value['url'],
          urlToImage: value['urlToImage'],
        );

        bm.add(article);
      });

      // Fetch profile picture URL and then display the profile UI
      return FutureBuilder<String?>(
        future: getProfilePictureUrl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final imageUrl =
                snapshot.data ?? ''; // Use an empty string if the URL is null
            return profileUI(imageUrl);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    IconData themeIcon;
    switch (themeProvider.themeMode) {
      case ThemeMode.light:
        themeIcon = Icons.wb_sunny;
        break;
      case ThemeMode.dark:
        themeIcon = Icons.nights_stay;
        break;
      case ThemeMode.system:
      default:
        themeIcon = Icons.settings;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading: PopupMenuButton<ThemeMode>(
          onSelected: (ThemeMode mode) {
            themeProvider.setThemeMode(mode);
          },
          icon: Icon(themeIcon, color: Theme.of(context).colorScheme.secondary),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: ThemeMode.light,
              child: Text('Light Mode'),
            ),
            PopupMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Mode'),
            ),
            PopupMenuItem(
              value: ThemeMode.system,
              child: Text('System Mode'),
            ),
          ],
        ),
        actions: [
          editInfoButton(context),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot?>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc('${currUser?.uid}')
            .get(),
        builder: getUserInfo,
      ),
    );
  }
}
