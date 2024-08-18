import 'dart:ffi';
import 'dart:io';

import 'package:buyble_real/src/component/icons_path.dart';
import 'package:buyble_real/src/component/image_data.dart';
import 'package:buyble_real/src/component/message_popup.dart';
import 'package:buyble_real/src/controller/home_controller.dart';
import 'package:buyble_real/src/controller/upload_controller.dart';
import 'package:buyble_real/src/pages/home/category.dart';
import 'package:buyble_real/src/pages/home/detail.dart';
import 'package:buyble_real/src/pages/home/keyword.dart';
import 'package:buyble_real/src/pages/home/post/post.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:buyble_real/src/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: PopupMenuButton(
        shape: ShapeBorder.lerp(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            1),
        onSelected: (String value) {
          //메뉴 뜨는걸 바꿈
        },
        offset: Offset(0, 25),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                child: Text(
                  "Manhattan",
                ),
                value: "Manh"),
            PopupMenuItem(
              child: Text("Queens"),
              value: "Quee",
            ),
            PopupMenuItem(
              child: Text("Long Island"),
              value: "Long",
            ),
          ];
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [

              Text("Columbia U"),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Get.to(() => Keyword(), transition: Transition.rightToLeft);
          },
        ),
        IconButton(
          icon: Icon(Icons.format_line_spacing),
          onPressed: () {
            Get.to(() => const Category(), transition: Transition.downToUp);
          },
        ),
      ],
      elevation: 0.2,
    );
  }

  Widget _makeItemList() {
    return Obx(() => Column(
          children: List.generate(
              controller.postList.value.length,
              (index) => GestureDetector(
                    onTap: () {
                      Get.to(() => Detail(postInfo: controller.postList.value[index]), transition: Transition.downToUp);
                    },
                    child: Container(
                      height: 130,
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                  color: Colors.grey,
                                  width: 100,
                                  height: 100,
                                  child: controller.postList.value[index]
                                              .photoUrls?.length ==
                                          0
                                      ? Image.network(
                                          "https://t1.daumcdn.net/cfile/tistory/2513B53E55DB206927")
                                      : Image.network(controller
                                          .postList.value[index].photoUrls![0]
                                          .toString(), fit: BoxFit.cover,)
                                  // Image.memory(
                                  //     controller.postList.value[0].photos![0].
                                  //     thumbnailDataWithSize(ThumbnailSize(200, 200)))

                                  // Image.memory(
                                  //   snapshot.data!,
                                  //   fit: BoxFit.cover,
                                  // )
                                  // asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                                  )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.postList.value[index].title
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "121 Street" + "ㆍ4m",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF868181),
                                        fontSize: 11),
                                  ),
                                  Text(
                                    Util.numToDol(controller
                                        .postList.value[index].price.toString()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/svg/heart_off.svg",
                                            width: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text("3"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),

        // AppBar(
        //   elevation: 0,
        //   title: ImageData(iconn: IconsPath.logo, width: 270),
        //   actions: [
        //     GestureDetector(
        //       onTap: () {
        //         showDialog(
        //           context: Get.context!,
        //           builder: (context) => MessagePopup(
        //             title: "System",
        //             message: "Sure you want to leave?",
        //             okCallback: () {
        //               FirebaseAuth.instance.signOut();
        //               Get.back();
        //             },
        //             cancelCallback: () {
        //               Get.back();
        //             },
        //           ),
        //         );
        //       } ,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ImageData(
        //           iconn: IconsPath.directMessage,
        //           width: 50,
        //         ),
        //       ),
        //     ),
        //
        //   ],
        // ),

        body: ListView(
          children: [
            _makeItemList(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: BuybleColor.colorList[2],
          onPressed: () {
            Get.to(() => Post(), transition: Transition.downToUp,
                binding: BindingsBuilder(() {
              Get.put(UploadController());
            }));
          },
          label: Text("Post"),
          icon: Icon(Icons.add),
        ));
  }
}
