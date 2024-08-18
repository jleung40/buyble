import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/controller/init_bindings.dart';
import 'package:buyble_real/src/pages/my_profile/settings.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:buyble_real/src/viewProfile/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class MyProfile extends GetView<AuthController> {
  const MyProfile({Key? key}) : super(key: key);

  Widget _myInfo() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child:
            // Obx(
            //   () =>
                  Container(
                width: 60,
                height: 60,
                child:controller.myUser.value.thumbnail.toString() == ""
                    ? Image.asset("assets/images/default_image.png", fit: BoxFit.cover,)
                    : Image.network(controller.myUser.value.thumbnail.toString(),fit: BoxFit.cover,),

              ),
            ),
          ),
        // ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      controller.myUser.value.nickname.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "#14173573",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  "this can be a long long description of myself that includes like... preferences"
                  "?? I dont even know ",
                  style:
                      TextStyle(overflow: TextOverflow.ellipsis, fontSize: 15),
                  maxLines: 3,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _profileSettingButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3)),
      child: Center(
        child: Text(
          "Profile settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _threeOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: BuybleColor.colorList[0]),
                child: Icon(
                  Icons.list_alt_sharp,
                  size: 35,
                ),
              ),
              Text("My Lists"),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: BuybleColor.colorList[0]),
                child: Icon(
                  Icons.list_alt_sharp,
                  size: 35,
                ),
              ),
              Text("Purchases"),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(23),
                margin: EdgeInsets.only(bottom: 5),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: BuybleColor.colorList[0]),
                child: SvgPicture.asset(
                  "assets/svg/heart_off.svg",
                ),
              ),
              Text("Favorites"),
            ],
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      width: Get.width,
      height: 1,
      color: Colors.grey.withOpacity(0.4),
    );
  }

  Widget _viewProfileButton() {
    return GestureDetector(
      onTap: (){
        InitBindings.additionalBindings();
        Get.to(()=> ViewProfile() , transition: Transition.downToUp );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3)),
        child: Center(
          child: Text(
            "View profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("My Profile"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => Settings(), transition: Transition.rightToLeft);
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        children: [
          _myInfo(),
          _profileSettingButton(),
          _threeOptions(),
          _line(),
          _viewProfileButton(),
        ],
      ),
    );
  }
}
