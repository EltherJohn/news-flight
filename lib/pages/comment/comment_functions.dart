import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentFunctions {
  static Future<String> replyToComment(
    String articleTitle,
    String commentId,
    String userId,
    String username,
    String profileImageUrl,
    String replyText,
  ) async {
    try {
      final reply = {
        'userId': userId,
        'username': username,
        'profileImageUrl': profileImageUrl,
        'text': replyText,
        'timestamp': DateTime.now(),
      };

      final docRef = FirebaseFirestore.instance
          .collection('article_comments')
          .doc(articleTitle);

      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>;
      final comments = List<Map<String, dynamic>>.from(data['comments'] ?? []);

      for (var comment in comments) {
        if (comment['id'] == commentId) {
          if (comment.containsKey('replies')) {
            comment['replies'].add(reply);
          } else {
            comment['replies'] = [reply];
          }
          break;
        }
      }

      await docRef.update({'comments': comments});

      return 'success';
    } catch (e) {
      print('Failed to post reply: $e');
      return 'failure';
    }
  }

  static Future<String> reportComment(
      String articleTitle, String commentId, String reportingUserId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('article_comments')
          .doc(articleTitle);

      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>;
      final comments = List<Map<String, dynamic>>.from(data['comments'] ?? []);

      for (var comment in comments) {
        if (comment['id'] == commentId) {
          final userId = comment['userId'];

          // Check if the reporting user has already reported this comment
          final reportDocRef = FirebaseFirestore.instance
              .collection('reported_comments')
              .doc(commentId);

          final reportSnapshot = await reportDocRef.get();
          final reportData = reportSnapshot.data();

          if (reportData != null &&
              reportData['reportingUsers'].contains(reportingUserId)) {
            return 'already_reported';
          }

          // Add the report details
          await reportDocRef.set({
            'articleTitle': articleTitle,
            'commentId': commentId,
            'commentText': comment['text'],
            'userId': userId,
            'reportingUsers': FieldValue.arrayUnion([reportingUserId]),
          }, SetOptions(merge: true));

          final userDocRef =
              FirebaseFirestore.instance.collection('users').doc(userId);
          final userSnapshot = await userDocRef.get();
          final userData = userSnapshot.data() as Map<String, dynamic>;

          final int reportCount = (userData['reportCount'] ?? 0) + 1;

          if (reportCount >= 3) {
            await userDocRef.update({'isDisabled': true});
          }

          await userDocRef.update({'reportCount': reportCount});

          return 'success';
        }
      }

      return 'failure';
    } catch (e) {
      print('Failed to report comment: $e');
      return 'failure';
    }
  }

  static Future<String> deleteComment(
      String articleTitle, String commentId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'user_not_logged_in'; 
    }

    final DocumentReference commentRef = FirebaseFirestore.instance
        .collection('article_comments')
        .doc(articleTitle);

    final DocumentSnapshot commentSnapshot = await commentRef.get();
    final Map<String, dynamic>? commentData =
        commentSnapshot.data() as Map<String, dynamic>?;

    if (commentData == null || !commentData.containsKey('comments')) {
      return 'comment_not_found'; 
    }

    final List<dynamic> comments = commentData['comments'] ?? [];
    final commentIndex = comments.indexWhere(
      (comment) => comment['id'] == commentId && comment['userId'] == user.uid,
    );

    if (commentIndex == -1) {
      return 'comment_not_found_or_not_authorized'; 
    }

    comments.removeAt(commentIndex);

    await commentRef.update({
      'comments': comments,
    });

    return 'success'; // Comment deleted successfully
  }

}
