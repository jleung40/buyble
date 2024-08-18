import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class PostModel {
  String? docId;
  List<File>? photoFiles;
  List<dynamic>? photoUrls;
  String? title;
  String? price;
  String? description;
  String? location;
  DateTime? createdTime;
  bool isFree;
  bool isNegotiable;
  String? userUid;

  PostModel({
    this.title,
    this.docId,
    this.photoUrls,
    this.photoFiles,
    this.price,
    this.description,
    this.location,
    this.createdTime,
    required this.isFree,
    required this.isNegotiable,
    this.userUid,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": this.title,
      "price": this.price,
      "photo_urls": this.photoUrls,
      "description": this.description,
      "location": this.location,
      "created_time": this.createdTime,
      "is_free" : this.isFree,
      "is_negotiable": this.isNegotiable,
      "user_uid" : this.userUid,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json["title"] == null ? "" : json["title"].toString(),
      docId: json["docId"] == null ? "" : json["docId"].toString(),
      price: json["price"] == null ? "" : json["price"].toString(),
      photoUrls: json["photo_urls"] == null ? <String>[] : json["photo_urls"] as List<String>,
      description:
          json["description"] == null ? "" : json["description"].toString(),
      location: json["location"] == null ? "" : json["location"].toString(),
      isFree: json["is_free"],
      isNegotiable: json["is_negotiable"],
      userUid: json["user_uid"],
    );
  }


  copyWith(
      {String? title,
      String? docId,
      String? price,
        List<String>? photoUrls,
        List<File>? photoFiles,
      String? location,
      String? description,
      DateTime? createdTime,
      required bool isFree,
        required bool isNegotiable,
        String? userUid,
      }) {
    return PostModel(
      title: title ?? this.title,
      docId: docId ?? this.docId,
      price: price ?? this.price,
      photoFiles: photoFiles ?? this.photoFiles,
      photoUrls: photoUrls ?? this.photoUrls,
      location: location ?? this.location,
      description: description ?? this.description,
      createdTime: createdTime ?? this.createdTime,
      isFree: this.isFree,
      isNegotiable: this.isNegotiable,
      userUid: this.userUid,
    );
  }




}
