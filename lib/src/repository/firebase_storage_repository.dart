


import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirestorageRepo {

  static UploadTask? uploadFile(File filee, int number, String uid ) {
    print(" file is " + filee.toString());

    UploadTask? uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('post_photos/$uid')
        .child('/post_photo__$number.jpg');

    uploadTask = ref.putFile(filee);
    return uploadTask;

  }





}