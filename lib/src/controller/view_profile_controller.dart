

import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/model/b_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProfileController extends GetxController with GetTickerProviderStateMixin{



  late TabController tabCon;
  Rx<BUser> targetUser = BUser(numberOfPhotos: 0).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    tabCon = TabController(length: 3, vsync: this);
    _loadData();
    super.onInit();
  }

  void setTargetUser(){
    var uid = Get.parameters['targetUid'];
    if( uid == null ){


      targetUser(AuthController.to.myUser.value);
    }else{
      //todo : 상대 uid로 조회

    }
    print(targetUser.value.thumbnail.toString() == "");

  }


  void _loadData(){
    //포스트 정보 로드
    //사용자 정보로드

    setTargetUser();

  }





}