import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok/constants.dart';
import 'package:tik_tok/model/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {}

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authControler.user!.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        Comment comment = Comment(
          username: (userDoc.data() as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
          uid: authControler.user!.uid,
          id: "Comment $len",
        );
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc("Comment $len")
            .set(
              comment.toJson(),
            );
      }
    } catch (e) {
      Get.snackbar(
        "Error comenting",
        e.toString(),
      );
    }
  }
}
