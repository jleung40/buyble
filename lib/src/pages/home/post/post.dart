import 'dart:io';

import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/controller/upload_controller.dart';
import 'package:buyble_real/src/model/post_model.dart';
import 'package:buyble_real/src/pages/home/post/pick_photos.dart';
import 'package:buyble_real/src/repository/firebase_storage_repository.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:photo_manager/photo_manager.dart';

class Post extends GetView<UploadController> {
  const Post({Key? key}) : super(key: key);

  PreferredSizeWidget _appbar() {
    return AppBar(
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
      title: Text("Post For Sale"),
      actions: [
        TextButton(
            onPressed: () {
              controller.entirePostingProcess();
            },
            child: Text(
              "Done",
              style: TextStyle(color: BuybleColor.colorList[0], fontSize: 18),
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget _imageSection() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => PickPhotos(), transition: Transition.downToUp);
                },
                child: Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.4), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) // POINT
                        ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black,
                      ),
                      Text("${UploadController.to.viewList.value.length}/8")
                    ],
                  ),
                ),
              ),
              ...List.generate(
                  UploadController.to.viewList.value.length,
                  (index) => _photoWidget(
                      UploadController.to.viewList.value[index])).toList()
            ],
          ),
        ));
  }

  Widget _line() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      width: Get.width,
      height: 1,
      color: Colors.grey.withOpacity(0.4),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text("Title"),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 40),
          width: Get.width,
          child: Obx(
            () => TextField(
              onChanged: (value) {
                if (controller.textVal.value) {
                  if (value.length >= 4) {
                    controller.textVal.value = false;
                  }
                }
              },
              controller: controller.titleController.value,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  errorText: controller.textVal.value
                      ? "Title should contain more than 5 characters"
                      : null,
                  border: OutlineInputBorder(),
                  focusColor: BuybleColor.colorList[2]),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _price() {
  //   return Container(
  //     width: Get.width,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //               child: Text(
  //                 "\$",
  //                 style: TextStyle(fontSize: 16, color: Colors.grey),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 200,
  //               child:Obx(()=> TextField(
  //
  //                 // onChanged: (value) {
  //                 //   print(value);
  //                 //   controller.setPrice(value);
  //                 //   //이거 전부다 컨트롤러 사용해야겠다
  //                 // },
  //                 controller: controller.priceController.value,
  //                 decoration: InputDecoration(
  //                   hintText: "Set to 0 to give away",
  //                   hintStyle: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w500,
  //                     color: Colors.grey,
  //                   ),
  //                   border: InputBorder.none,
  //                   focusedBorder: InputBorder.none,
  //                 ),
  //                 keyboardType: TextInputType.number,
  //               ),),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Obx(()=>Container(
  //               margin: EdgeInsets.symmetric(horizontal: 12),
  //               width: 23,
  //               height: 23,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.grey, width: 1),
  //                   borderRadius: BorderRadius.circular(4)),
  //               child: controller.priceController.value.text == "0"
  //                   ? GestureDetector(
  //                       onTap: () {
  //                         print("color check box is clicked");
  //                         //이거 전부다 컨트롤러 사용해야겠다
  //                       },
  //                       child: Container(
  //                         color: BuybleColor.colorList[2],
  //                         child: Center(
  //                             child: Icon(
  //                           Icons.check,
  //                           color: Colors.white,
  //                           size: 20,
  //                         )),
  //                       ),
  //                     )
  //                   : GestureDetector(
  //                       onTap: () {
  //                         controller.setPriceToFree();
  //                       },
  //                       child: Container()),
  //               // child: Container(color: Colors.red,),
  //             ),),
  //             Text(
  //               "Free",
  //               style:
  //                   TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _price() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Listing type"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: !controller.isFree.value
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            child: Text(
                              "For sale",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.priceController.value =
                                TextEditingController(text: "0");
                            controller.isFree.value = !controller.isFree.value;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: Text(
                                "Free",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.priceController.value =
                                TextEditingController();
                            controller.isFree.value = !controller.isFree.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: Text(
                                "For sale",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            child: Text(
                              "Free",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            !controller.isFree.value
                ? Container(
                    width: Get.width,
                    child: TextField(
                      onChanged: (value) {
                        if (controller.priceVal.value) {
                          if (value.length >= 1) {
                            controller.priceVal.value = false;
                          }
                        }
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      controller: controller.priceController.value,
                      decoration: InputDecoration(
                          errorText: controller.priceVal.value
                              ? "Price cannot be empty"
                              : null,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "\$ Price",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(),
                          focusColor: BuybleColor.colorList[2]),
                    ),
                  )
                : Container(
                    width: Get.width,
                    child: TextField(
                      controller: controller.priceController.value,
                      decoration: InputDecoration(
                          enabled: false,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "\$ 0",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(),
                          focusColor: BuybleColor.colorList[2]),
                    ),
                  ),
            !controller.isFree.value //this is negoatiable part
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      children: [
                        !controller.isNegotiable.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.isNegotiable.value =
                                      !controller.isNegotiable.value;
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 23,
                                  height: 23,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.isNegotiable.value =
                                      !controller.isNegotiable.value;
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  width: 23,
                                  height: 23,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: BuybleColor.colorList[2],
                                          width: 1),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Container(
                                    color: BuybleColor.colorList[2],
                                    child: Center(
                                        child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                  ),
                                ),
                              ),
                        GestureDetector(
                          onTap: () {
                            controller.isNegotiable.value =
                                !controller.isNegotiable.value;
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Negotiable"),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Negotiable"),
                        ),
                      ],
                    ),
                  )
          ],
        ));
  }

  Widget _description() {
    return Obx(() => Container(
          margin: EdgeInsets.only(bottom: 40),
          width: Get.width,
          child: TextField(
            onChanged: (value) {
              if (controller.descriptionVal.value) {
                if (value.length >= 1) {
                  controller.descriptionVal.value = false;
                }
              }
            },
            controller: controller.descriptionController.value,
            maxLines: 6,
            decoration: InputDecoration(
                hintText: "Describe your item in as much detail as you can",
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                errorText: controller.descriptionVal.value
                    ? "Please describe your product in detail"
                    : null,
                border: OutlineInputBorder(),
                focusColor: BuybleColor.colorList[2]),
          ),
        ));
  }

  Widget _location() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Where to meet",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          GestureDetector(
            onTap: () {
              print("location 정하는걸로 넘어가야댐");
            },
            child: Row(
              children: [
                Text(
                  "Select",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Colors.black87,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(() => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1),
          itemCount: UploadController.to.viewList.value.length,
          itemBuilder: (BuildContext context, int index) {
            return _photoWidget(UploadController.to.viewList.value[index]);
          },
        ));
  }

  Widget _photoWidget(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("im usupposed to put up images");
          return Opacity(
            opacity:
                // asset == UploadController.to.firstImage.value ? 0.4 :
                1,
            child: GestureDetector(
              onTap: () {
                print("사진 확대");
              },
              child: Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.all(1),
                child: Stack(children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 65,
                        height: 65,
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          UploadController.to.deleteSelected(asset);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              color: Colors.white,
                              child: Icon(
                                Icons.dangerous,
                                color: Colors.black,
                              )),
                        ),
                      )),
                ]),
              ),
            ),
          );
        } else {
          print("no snapshot data");
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: KeyboardDismisser(
        gestures: [
          GestureType.onVerticalDragDown,
          GestureType.onVerticalDragStart,
          GestureType.onTap
        ],
        child: GestureDetector(
          // onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              _imageSection(),

              _title(),

              _price(), // 이거 컨트롤러 달아서 Obx 처리 해야겠다.

              _description(),
              _line(),
              _location(),
              _line(),
              _line(),
              _line(),
              _imageSelectList(),
            ],
          ),
        ),
      ),
    );
  }
}
