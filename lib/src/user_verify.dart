import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/controller/bottom_controller.dart';
import 'package:buyble_real/src/controller/init_bindings.dart';
import 'package:buyble_real/src/model/b_user.dart';
import 'package:buyble_real/src/pages/app.dart';
import 'package:buyble_real/src/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserVerify extends StatefulWidget {
  User? data;

  UserVerify({Key? key, required this.data}) : super(key: key);

  @override
  State<UserVerify> createState() => _UserVerifyState();
}

class _UserVerifyState extends State<UserVerify> {
  late AuthController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BUser?>(
      future: controller.login(widget.data!.uid),
      builder: (context, snapshot) {
        if( snapshot.connectionState != ConnectionState.done){
          return Center(child: CircularProgressIndicator() ,);
        }
        if (snapshot.hasData) {
          return const App();
        } else {
          return Obx(() => controller.myUser.value.uid != null
              ? const App()
              : Signup(uid: widget.data!.uid));
        }

        // if( snapshot.data == null ){
        //   print(" user verify snapshot data is null ");
        //   //sign up 을 해야함.
        //   return Container( child: Center(child: Text("snapshot data is null"),));
        // }
        //   print(" user verify snapshot data is not null ");
        //   print(snapshot.data!.thumbnail);
        //   // user controller 에서 유저 정보를 업데이트 해야지.
        // //app 은 스테이트 리스 상태로 계속 가는거야;;;;
        //   return App();
      },
    );
  }
}
