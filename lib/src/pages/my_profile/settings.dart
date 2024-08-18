import 'package:buyble_real/src/component/message_popup.dart';
import 'package:buyble_real/src/controller/bottom_controller.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget _oneItem(String itemName, Function() toWhere) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GestureDetector(
        onTap: toWhere,
        child: Text(
          itemName,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _userSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          child: Text(
            "User settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        _oneItem("Manage Account", () => null),
        _oneItem("Followed users", () => null),
        _oneItem("Manage blocked users", () => null),
        _oneItem("Manage hidden users", () => null),
        _oneItem("Other settings", () => null),
      ],
    );
  }

  Widget _other() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          child: Text(
            "Other",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        _oneItem("What's new", () => null),
        _oneItem("Change country", () => null),
        _oneItem("Language settings", () => null),
        _oneItem("Delete cache", () => null),
        _oneItem("Open source licenses", () => null),
        Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Version 23.22.0",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Using the latest version of Buyble",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  )
                ],
              ),
              Text("23.22.0(232200)",
                  style:
                      TextStyle(fontSize: 17, color: BuybleColor.colorList[1]))
            ],
          ),
        ),
        _oneItem("Log out", () {
          return showDialog(
            context: Get.context!,
            builder: (context) => MessagePopup(
              title: "Log out",
              message: "Sure you want to log out?",
              okCallback: () {

                FirebaseAuth.instance.signOut();
                BottomController.to.renewalHistory();
                Get.back();
                Get.back();
              },
              cancelCallback: () {
                Get.back();
              },
            ),
          );
        }),
        _oneItem("Delete account", () => null),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          _userSettings(),
          _line(),
          _other(),
        ],
      ),
    );
  }
}
