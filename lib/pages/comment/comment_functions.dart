import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentFunctions {
  static Future<String> replyToComment(String articleTitle, String commentId,
      String userId, String username, String text) async {
    final DocumentReference commentRef = FirebaseFirestore.instance
        .collection('article_comments')
        .doc(articleTitle);

    final DocumentSnapshot commentSnapshot = await commentRef.get();
    final Map<String, dynamic>? commentData =
        commentSnapshot.data() as Map<String, dynamic>?;

    if (commentData != null && commentData.containsKey('comments')) {
      final List<dynamic> comments = commentData['comments'] ?? [];
      for (var comment in comments) {
        if (comment is Map<String, dynamic> && comment['id'] == commentId) {
          final List<dynamic> replies = List.from(comment['replies'] ?? []);
          final String replyId =
              FirebaseFirestore.instance.collection('replies').doc().id;
          replies.add({
            'id': replyId,
            'userId': userId,
            'username': username,
            'text': text,
            'timestamp': DateTime.now(),
          });
          await commentRef.update({
            'comments': comments.map((c) {
              if (c is Map<String, dynamic> && c['id'] == commentId) {
                return {
                  ...c,
                  'replies': replies,
                };
              }
              return c;
            }).toList(),
          });
          return 'success';
        }
      }
    }
    return 'comment_not_found';
  }

  static Future<String> reportComment(
    String articleTitle, String commentId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return 'user_not_logged_in'; // User not logged in
  }

  final reportsCollection = FirebaseFirestore.instance.collection('reports');

  // Retrieve the comment's data
  final commentSnapshot = await FirebaseFirestore.instance
      .collection('article_comments')
      .doc(articleTitle)
      .get();
  final Map<String, dynamic>? commentData = commentSnapshot.data();

  if (commentData == null || !commentData.containsKey('comments')) {
    return 'comment_not_found'; // Comment not found
  }

  final List<dynamic> comments = commentData['comments'] ?? [];
  final comment = comments.firstWhere(
    (comment) => comment['id'] == commentId,
    orElse: () => null,
  );

  if (comment == null) {
    return 'comment_not_found'; // Comment not found
  }

  final String commentUserId = comment['userId'] as String; // Retrieve userId from comment data

  // Check if the user is trying to report their own comment
  if (commentUserId == user.uid) {
    return 'cannot_report_own_comment'; // Cannot report own comment
  }

  // Check if the comment has already been reported by the user
  final existingReportQuery = await reportsCollection
      .where('articleTitle', isEqualTo: articleTitle)
      .where('commentId', isEqualTo: commentId)
      .where('reportedBy', isEqualTo: user.uid)
      .get();

  if (existingReportQuery.docs.isNotEmpty) {
    return 'already_reported'; // Comment already reported by the user
  }

  // Record the report in Firebase
  await reportsCollection.add({
    'articleTitle': articleTitle,
    'commentId': commentId, // Save the commentId
    'commentUserId': commentUserId, // Save the userId of the commenter
    'reportedBy': user.uid,
    'reportedAt': DateTime.now(),
  });

  return 'success'; // Report successful
}

}
