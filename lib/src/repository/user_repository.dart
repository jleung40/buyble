import 'package:buyble_real/src/model/b_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static Future<BUser?> loginByUid(String uid) async {
    print("uid is " + uid);

    var user = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();

    if (user.size == 0) {
      return null;
    } else {
      print(" user is " + user.toString());
      return (BUser.fromJson(user.docs.first.data()))
          .copyWith(docId: user.docs.first.id.toString());
    }
  }

  static Future<String> signup(BUser newUser) async {
    try {
      DocumentReference drf = await FirebaseFirestore.instance
          .collection("users")
          .add(newUser.toMap());
      return drf.id;
    } catch (e) {
      print(e);
      return "fail";
    }
  }

  static Future<int> getNumberOfPhotos(String uid) async {
    var user = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();

    return user.docs.first.data()["number_of_photos"];
  }

  static void updateNumberOfPhotos(String? docId, int number) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({
      "number_of_photos": number,
    });
  }

  static void updateLastLoginDate(String? docId, DateTime time) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    users.doc(docId).update({"date_last_login": time});
  }
}
