import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar.dart';
import 'comment_functions.dart'; // Importing CommentFunctions class

class Comment extends StatefulWidget {
  final String title;

  const Comment({
    super.key,
    required this.title,
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for ${widget.title}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('article_comments')
                  .doc(widget.title)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final Map<String, dynamic>? data =
                      snapshot.data?.data() as Map<String, dynamic>?;

                  if (data == null || !data.containsKey('comments')) {
                    return const Center(child: Text('No comments yet.'));
                  }

                  final List<Map<String, dynamic>> commentsData =
                      List<Map<String, dynamic>>.from(
                          data['comments'] as List<dynamic>);

                  return ListView.builder(
                    itemCount: commentsData.length,
                    itemBuilder: (context, index) {
                      final comment = commentsData[index];
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(comment['userId'] as String)
                            .get(),
                        builder: (context, userSnapshot) {
                          final userData = userSnapshot.data?.data()
                              as Map<String, dynamic>?;

                          final profileImageUrl =
                              userData?['profileImageURL'] as String?;

                          return ListTile(
                            title: Text(comment['username'] ?? 'Unknown User'),
                            subtitle: Text(comment['text'] ?? ''),
                            leading: CircleAvatar(
                              // Display profile image if available, otherwise use placeholder
                              backgroundImage: profileImageUrl != null
                                  ? NetworkImage(profileImageUrl)
                                  : const AssetImage(
                                          'assets/default_profile_image.png')
                                      as ImageProvider<Object>,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.reply),
                                  onPressed: () {
                                    // Add functionality to handle replying to the comment
                                    // For example, you could show a dialog or navigate to a new screen to compose the reply
                                  },
                                ),
                                SizedBox(
                                  width: 40, // Adjust the width as needed
                                  child: IconButton(
                                    icon: const Icon(Icons.flag),
                                    onPressed: () async {
                                      final currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      // Check if the current user is the author of the comment
                                      if (currentUser!.uid ==
                                          comment['userId']) {
                                        Flushbar(
                                          message: 'Cannot report own comment',
                                          icon: const Icon(Icons.warning,
                                              size: 28.0, color: Colors.red),
                                          duration: const Duration(seconds: 2),
                                        ).show(context);
                                        return;
                                      }
                                      // Add functionality to report the comment
                                      final String result =
                                          await CommentFunctions.reportComment(
                                              widget.title, comment['id']);
                                      if (result == 'success') {
                                        Flushbar(
                                          message:
                                              'Comment reported successfully',
                                          icon: const Icon(Icons.flag,
                                              size: 28.0, color: Colors.yellow),
                                          duration: const Duration(seconds: 2),
                                        ).show(context);
                                      } else if (result == 'already_reported') {
                                        Flushbar(
                                          message:
                                              'You have already reported this comment',
                                          icon: const Icon(Icons.warning,
                                              size: 28.0, color: Colors.red),
                                          duration: const Duration(seconds: 2),
                                        ).show(context);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    final commentText = _commentController.text.trim();
                    if (commentText.isNotEmpty && currentUser != null) {
                      // Generate a unique ID for the comment
                      final String commentId = FirebaseFirestore.instance
                          .collection('article_comments')
                          .doc()
                          .id;

                      FirebaseFirestore.instance
                          .collection('article_comments')
                          .doc(widget.title)
                          .set({
                        'title': widget.title,
                        'comments': FieldValue.arrayUnion([
                          {
                            'id': commentId, // Save the comment ID
                            'userId': currentUser.uid,
                            'username':
                                currentUser.displayName ?? currentUser.email,
                            'text': commentText,
                            'timestamp': DateTime.now(),
                          }
                        ])
                      }, SetOptions(merge: true)).then((_) {
                        Flushbar(
                          message: 'Comment posted successfully',
                          icon: const Icon(Icons.check_circle_outline,
                              size: 28.0, color: Colors.green),
                          duration: const Duration(seconds: 2),
                        ).show(context);
                        _commentController.clear();
                      }).catchError((error) {
                        print('Failed to post comment: $error');
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
