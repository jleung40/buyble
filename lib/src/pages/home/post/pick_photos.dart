import 'package:buyble_real/src/component/icons_path.dart';
import 'package:buyble_real/src/component/image_data.dart';
import 'package:buyble_real/src/controller/upload_controller.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class PickPhotos extends GetView<UploadController> {
  const PickPhotos({Key? key}) : super(key: key);

  Widget _imageSelectList() {
    return Obx(() => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1),
          itemCount: UploadController.to.imageList.value.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.camera_alt_rounded), Text("Camera")],
                ),
              );
            } else {
              return _photoWidget(controller.imageList.value[index - 1]);
            }
          },
        ));
  }

  Widget _photoWidget(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("im usupposed to put up images");
          return GestureDetector(
            onTap: () {
              controller.setFirstImage(asset);
            },
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.selected(asset);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.transparent,
                      child: Obx(() => Center(
                            child: controller.isSelected(asset)
                                ? Container(
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: BuybleColor.colorList[2],
                                    ),
                                    child: Center(
                                        child: Text(
                                      controller
                                          .whichIndexIsSelected(asset)
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  )
                                : Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: BuybleColor.colorList[1],
                                          width: 2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          print("no snapshot data");
          return Container();
        }
      },
    );
  }

  // Widget _header() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         GestureDetector(
  //           onTap: () {
  //             showModalBottomSheet(
  //               context: Get.context!,
  //               shape: const RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20)),
  //               ),
  //               isScrollControlled:
  //                   controller.albums.length > 10 ? true : false,
  //               constraints: BoxConstraints(
  //                 maxHeight: MediaQuery.of(Get.context!).size.height -
  //                     MediaQuery.of(Get.context!).padding.top,
  //               ),
  //               builder: (_) => Container(
  //                 height: controller.albums.length > 10
  //                     ? Size.infinite.height
  //                     : controller.albums.length * 60,
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.stretch,
  //                     children: [
  //                       Center(
  //                         child: Container(
  //                           margin: const EdgeInsets.only(top: 7),
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: Colors.black54,
  //                           ),
  //                           width: 40,
  //                           height: 4,
  //                         ),
  //                       ),
  //                       Expanded(
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.stretch,
  //                             children: List.generate(
  //                               controller.albums.length,
  //                               (index) => GestureDetector(
  //                                 onTap: () {
  //                                   controller
  //                                       .changeAlbum(controller.albums[index]);
  //                                   Get.back();
  //                                 },
  //                                 child: Container(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 15, horizontal: 20),
  //                                   child: Text(controller.albums[index].name),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                     ]),
  //               ),
  //             );
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: Row(
  //               children: [
  //                 Obx(
  //                   () => Text(
  //                     controller.headerTitle.value,
  //                     style: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 18,
  //                     ),
  //                   ),
  //                 ),
  //                 const Icon(Icons.arrow_drop_down),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               padding:
  //                   const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //               decoration: BoxDecoration(
  //                   color: const Color(0xff808080),
  //                   borderRadius: BorderRadius.circular(30)),
  //               child: Row(
  //                 children: [
  //                   ImageData(
  //                     iconn: IconsPath.cameraIcon,
  //                   ),
  //                   const SizedBox(width: 7),
  //                   const Text(
  //                     '여러 항목 선택',
  //                     style: TextStyle(color: Colors.white, fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(width: 5),
  //             Container(
  //               padding: const EdgeInsets.all(6),
  //               decoration: const BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Color(0xff808080),
  //               ),
  //               child: ImageData(
  //                 iconn: IconsPath.cameraIcon,
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  PreferredSizeWidget _appbar() {
    return AppBar(
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios),
        onTap: () {
          Get.back();
        },
      ),
      title: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: Get.context!,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            isScrollControlled: controller.albums.length > 10 ? true : false,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(Get.context!).size.height -
                  MediaQuery.of(Get.context!).padding.top,
            ),
            builder: (_) => Container(
              height: controller.albums.length > 10
                  ? Size.infinite.height
                  : controller.albums.length * 60,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        width: 40,
                        height: 4,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(
                            controller.albums.length,
                            (index) => GestureDetector(
                              onTap: () {
                                controller
                                    .changeAlbum(controller.albums[index]);
                                Get.back();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Text(controller.albums[index].name),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Obx(
                () => Text(
                  controller.headerTitle.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              print("save the photos!");
              controller.saveSelectedList();

              Get.back();
            },
            child: Obx(() => Text(
                  controller.selectedList.value.length == 0
                      ? "Post"
                      : "Post ${controller.selectedList.value.length}",
                  style: TextStyle(color: BuybleColor.colorList[2]),
                )))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: ListView(
        children: [_imageSelectList()],
      ),
    );
  }
}
