import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String username;
  final String uid;
  final String id;
  final List likes;
  final int commentCount;
  final int sharedCount;
  final String songName;
  final String caption;
  final String thumbnail;
  final String videoUrl;
  final String profilePhoto;

  Video(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.sharedCount,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.thumbnail,
      required this.profilePhoto});
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "id": id,
        "commentCount": commentCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "likes": likes,
        "sharedCount": sharedCount
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot["username"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      likes: snapshot["likes"],
      commentCount: snapshot["commentCount"],
      sharedCount: snapshot["sharedCount"],
      songName: snapshot["songName"],
      caption: snapshot["caption"],
      videoUrl: snapshot["videoUrl"],
      thumbnail: snapshot["thumbnail"],
      profilePhoto: snapshot["profilePhoto"],
    );
  }
}
