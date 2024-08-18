import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  static BottomController get to => Get.find();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  renewalHistory(){
    bottomHistory = [0];
    print(bottomHistory);
  }

  changeBottom(int number,{bool hasGesture = true}) {
    pageIndex(number);
    if (!hasGesture) {
      return;
    }
    if( number == 0 && bottomHistory.length == 1 ){
      return;
    }
    if (bottomHistory.contains(number)) {
      if (number != 0) {
        bottomHistory.remove(number);
      } else if (bottomHistory.sublist(1).contains(0)) {
        var sublist = bottomHistory.sublist(1);
        sublist.remove(0);
        bottomHistory = [0] + sublist;
      }
    }

    bottomHistory.add(number);
    print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) => MessagePopup(
      //     title: "System",
      //     message: "Sure you want to leave?",
      //     okCallback: () {
      //       exit(0);
      //     },
      //     cancelCallback: () {
      //       Get.back();
      //     },
      //   ),
      // );
      return true;
    } else {
      bottomHistory.removeLast();
      int val = bottomHistory.last;
      print(bottomHistory.toString() + " removed ");
      changeBottom(val, hasGesture: false);
      return false;
    }
    // else {
    //   var page = PageName.values[bottomHistory.last];
    //   if (page == PageName.SEARCH) {
    //     var value = await searchNavKey.currentState!.maybePop();
    //     if (value) {
    //       return false;
    //     }
    //   }
  }
}
