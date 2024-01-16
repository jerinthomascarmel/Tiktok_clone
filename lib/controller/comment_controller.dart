import "dart:developer";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";
import "package:tiktok_clone/constants.dart";

import "../models/comment_model.dart";

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = ""; // id of the video

  updatePosId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for (var element in query.docs) {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }));
  }

  postComment(String commentText) async {
    log(commentText);
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        // log(userDoc.data().toString());
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        // log(allDocs.toString());

        int len = allDocs.docs.length;
        // log(len.toString());
        var userdata = (userDoc.data()! as dynamic);
        // log(userdata.toString());

        try {
          Comment comment = Comment(
              username: userdata['name'],
              comment: commentText.trim(),
              datePublished: DateTime.now(),
              likes: [],
              profilePhoto: userdata['profilePhoto'],
              uid: userdata['uid'],
              id: 'Comment $len');

          await firestore
              .collection('videos')
              .doc(_postId)
              .collection('comments')
              .doc('Comment $len')
              .set(comment.toJson());
        } catch (e) {
          Get.snackbar('error', e.toString());
        }
        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        await firestore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error while commenting', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
