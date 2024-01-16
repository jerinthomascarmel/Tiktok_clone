// ignore: empty_constructor_bodies
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username; //who posted the comment
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid; //posted video user
  String id; // id of the comment

  Comment(
      {required this.username,
      required this.comment,
      required this.datePublished,
      required this.likes,
      required this.profilePhoto,
      required this.uid,
      required this.id});

      Map<String,dynamic> toJson()=>{
        'username':username,
        'comment':comment,
        'datePublished':datePublished,
        'likes':likes,
        'profilePhoto':profilePhoto,
        'uid':uid,
        'id':id
      };

      static Comment fromSnap(DocumentSnapshot snap){
        var snapshot=snap.data() as Map<String, dynamic>;
        return Comment(
          username: snapshot['username'], 
          comment: snapshot['comment'],
           datePublished: snapshot['datePublished'],
            likes: snapshot['likes'], 
            profilePhoto:snapshot['profilePhoto'] , 
            uid: snapshot['uid'],
             id: snapshot['id']);
      }

}
