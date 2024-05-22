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

  void _showReplyDialog(String commentId) {
    final TextEditingController _replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reply to Comment'),
        content: TextField(
          controller: _replyController,
          decoration: const InputDecoration(hintText: 'Write your reply here...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final currentUser = FirebaseAuth.instance.currentUser;
              final replyText = _replyController.text.trim();
              if (replyText.isNotEmpty && currentUser != null) {
                // Get the user's profile image URL
                final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
                final profileImageUrl = userDoc.data()?['profileImageURL'] as String? ?? '';

                final result = await CommentFunctions.replyToComment(
                  widget.title,
                  commentId,
                  currentUser.uid,
                  currentUser.displayName ?? currentUser.email!,
                  profileImageUrl,
                  replyText,
                );
                if (result == 'success') {
                  Flushbar(
                    message: 'Reply posted successfully',
                    icon: const Icon(Icons.check_circle_outline, size: 28.0, color: Colors.green),
                    duration: const Duration(seconds: 2),
                  ).show(context).then((_) {
                    Navigator.of(context).pop();
                  });
                } else {
                  Flushbar(
                    message: 'Failed to post reply',
                    icon: const Icon(Icons.error, size: 28.0, color: Colors.red),
                    duration: const Duration(seconds: 2),
                  ).show(context).then((_) {
                    Navigator.of(context).pop();
                  });
                }
              }
            },
            child: const Text('Reply'),
          ),
        ],
      ),
    );
  }

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
                  final Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;

                  if (data == null || !data.containsKey('comments')) {
                    return const Center(child: Text('No comments yet.'));
                  }

                  final List<Map<String, dynamic>> commentsData =
                      List<Map<String, dynamic>>.from(data['comments'] as List<dynamic>);

                  return ListView.builder(
                    itemCount: commentsData.length,
                    itemBuilder: (context, index) {
                      final comment = commentsData[index];
                      final List<dynamic> replies = comment['replies'] ?? [];

                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(comment['userId'] as String)
                            .get(),
                        builder: (context, userSnapshot) {
                          final userData = userSnapshot.data?.data() as Map<String, dynamic>?;

                          final profileImageUrl = userData?['profileImageURL'] as String?;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(comment['username'] ?? 'Unknown User'),
                                  subtitle: Text(comment['text'] ?? ''),
                                  leading: CircleAvatar(
                                    backgroundImage: profileImageUrl != null
                                        ? NetworkImage(profileImageUrl)
                                        : const AssetImage('assets/default_profile_image.png')
                                            as ImageProvider<Object>,
                                  ),
                                  trailing: PopupMenuButton<int>(
                                    onSelected: (item) async {
                                      final currentUser = FirebaseAuth.instance.currentUser;
                                      switch (item) {
                                        case 0: // Reply
                                          _showReplyDialog(comment['id']);
                                          break;
                                        case 1: // Report
                                          if (currentUser!.uid == comment['userId']) {
                                            Flushbar(
                                              message: 'Cannot report own comment',
                                              icon: const Icon(Icons.warning, size: 28.0, color: Colors.red),
                                              duration: const Duration(seconds: 2),
                                            ).show(context);
                                            return;
                                          }
                                          final String result = await CommentFunctions.reportComment(
                                              widget.title, comment['id'], currentUser.uid);
                                          if (result == 'success') {
                                            Flushbar(
                                              message: 'Comment reported successfully',
                                              icon: const Icon(Icons.flag, size: 28.0, color: Colors.yellow),
                                              duration: const Duration(seconds: 2),
                                            ).show(context);
                                          } else if (result == 'already_reported') {
                                            Flushbar(
                                              message: 'You have already reported this comment',
                                              icon: const Icon(Icons.warning, size: 28.0, color: Colors.red),
                                              duration: const Duration(seconds: 2),
                                            ).show(context);
                                          }
                                          break;
                                        case 2: // Delete
                                          if (currentUser != null && currentUser.uid == comment['userId']) {
                                            final String result = await CommentFunctions.deleteComment(
                                                widget.title, comment['id']);
                                            if (result == 'success') {
                                              Flushbar(
                                                message: 'Comment deleted successfully',
                                                icon: const Icon(Icons.check, size: 28.0, color: Colors.green),
                                                duration: const Duration(seconds: 2),
                                              ).show(context);
                                            } else if (result == 'comment_not_found_or_not_authorized') {
                                              Flushbar(
                                                message: 'Comment not found or you are not authorized to delete it',
                                                icon: const Icon(Icons.error, size: 28.0, color: Colors.red),
                                                duration: const Duration(seconds: 2),
                                              ).show(context);
                                            }
                                          } else {
                                            Flushbar(
                                              message: 'You are not authorized to delete this comment',
                                              icon: const Icon(Icons.error, size: 28.0, color: Colors.red),
                                              duration: const Duration(seconds: 2),
                                            ).show(context);
                                          }
                                          break;
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem<int>(
                                        value: 0,
                                        child: Text('Reply'),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Report'),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 2,
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 56.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: replies.map<Widget>((reply) {
                                      final replyProfileImageUrl = reply['profileImageUrl'] as String?;
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 12,
                                              backgroundImage: replyProfileImageUrl != null
                                                  ? NetworkImage(replyProfileImageUrl)
                                                  : const AssetImage('assets/default_profile_image.png')
                                                      as ImageProvider<Object>,
                                            ),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    reply['username'] ?? 'Unknown User',
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(reply['text'] ?? ''),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
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
                            'id': commentId,
                            'userId': currentUser.uid,
                            'username': currentUser.displayName ?? currentUser.email,
                            'text': commentText,
                            'timestamp': DateTime.now(),
                          }
                        ])
                      }, SetOptions(merge: true)).then((_) {
                        _commentController.clear();
                        Flushbar(
                          message: 'Comment posted successfully',
                          icon: const Icon(Icons.check_circle_outline, size: 28.0, color: Colors.green),
                          duration: const Duration(seconds: 2),
                        ).show(context);
                      }).catchError((error) {
                        Flushbar(
                          message: 'Failed to post comment',
                          icon: const Icon(Icons.error, size: 28.0, color: Colors.red),
                          duration: const Duration(seconds: 2),
                        ).show(context);
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
