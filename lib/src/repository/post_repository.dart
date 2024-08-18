import 'package:buyble_real/src/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PostRepository {
  static Future<List<PostModel>> loadPosts() async {
    //지금은 empty ()인데 나중에는 category 값을 받겠지
    //initial category would be "recent"

    // static Future<BUser?> loginByUid(String uid) async {
    //   print("uid is " + uid);
    //
    //   var user = await FirebaseFirestore.instance
    //       .collection("users")
    //       .where("uid", isEqualTo: uid)
    //       .get();
    //
    //   if (user.size == 0) {
    //     return null;
    //   } else {
    //     print(" user is " + user.toString());
    //     return BUser.fromJson(user.docs.first.data());
    //   }
    // }
    List<PostModel> output = <PostModel>[];

    // StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection('posts').snapshots(),
    //   builder: (context, snapshot) {
    //     if( snapshot.hasData ){
    //
    //       final posts = snapshot.data?.docs.reversed.toList();
    //       for( var post in posts!  ){
    //
    //         // PostModel a = PostModel( title: post["title"])
    //
    //       }
    //
    //     }
    //   },
    // )

    QuerySnapshot posts =
        await FirebaseFirestore.instance.collection("posts").get();
    print(posts);
    if (posts.size == 0) {
      return [];
    } else {
      final pposts = posts.docs.reversed.toList();

      for (var post in pposts!) {
        PostModel a = PostModel(
          photoUrls: post["photo_urls"],
          title: post["title"],
          isNegotiable: post["is_negotiable"],
          isFree: post["is_free"],
          createdTime: (post["created_time"] as Timestamp).toDate(),
          description: post["description"],
          price: post["price"],
        );

        // output?.add(PostModel.fromJson(post as Map<String, dynamic> ));
        output.add(a);
      }
    }

    return output;
  }

  static Future<String> postNewPost(PostModel newPost) async {
    try {
      DocumentReference drf = await FirebaseFirestore.instance
          .collection("posts")
          .add(newPost.toMap());
      return drf.id;
    } catch (e) {
      print("thisdis worng");
      return "fail";
    }
  }

  static void addPhotoUrl (
      String? docId, String url, String fieldName) async {
    List wow = [];
    QuerySnapshot la =
        await FirebaseFirestore.instance.collection("posts").get();
    var posts = FirebaseFirestore.instance.collection("posts");
    for (var each in la.docs) {
      if (each.id == docId) {
        Map<String, dynamic> yo = each.data() as Map<String, dynamic>;
        wow = yo["photo_urls"];
      }
    }
    wow.add(url);

    posts.doc(docId).update({fieldName: wow});
  }
}
