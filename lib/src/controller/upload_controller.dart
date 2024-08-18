import 'dart:io';
import 'dart:typed_data';

import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/model/post_model.dart';
import 'package:buyble_real/src/pages/home/post/post.dart';
import 'package:buyble_real/src/repository/firebase_storage_repository.dart';
import 'package:buyble_real/src/repository/post_repository.dart';
import 'package:buyble_real/src/repository/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadController extends GetxController {
  Rx<TextEditingController> titleController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  static UploadController get to => Get.find();
  var albums = <AssetPathEntity>[];
  RxList imageList = <AssetEntity>[].obs;
  RxList selectedList = <AssetEntity>[].obs;

  RxList viewList = <AssetEntity>[].obs;

  RxString headerTitle = ''.obs;
  Rx<AssetEntity?> firstImage =
      AssetEntity(id: "", typeInt: 0, width: 0, height: 0).obs;
  RxBool isFree = false.obs;
  RxBool isNegotiable = false.obs;
  RxBool textVal = false.obs;
  RxBool priceVal = false.obs;
  RxBool descriptionVal = false.obs;

  // FirestorageRepo _firestorageRepo = FirestorageRepo();
  RxList photoFileList = <File>[].obs;
  List urlList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadPhotos();
  }

  selected(AssetEntity asset) {
    if (selectedList.contains(asset)) {
      selectedList.remove(asset);
    } else {
      selectedList.add(asset);
    }
  }

  bool isSelected(AssetEntity asset) {
    return selectedList.contains(asset);
  }

  int whichIndexIsSelected(AssetEntity asset) {
    return selectedList.indexOf(asset) + 1;
  }

  void deleteSelected(AssetEntity asset) {
    selectedList.remove(asset);
  }

  void setFirstImage(AssetEntity asset) {
    firstImage(asset);
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
            imageOption: FilterOption(
              sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
            ),
            orders: [
              OrderOption(type: OrderOptionType.createDate, asc: false)
            ]),
      );
      _loadData();
    } else {
      print("it is not auth");
      //message 권한 요청
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);

    // update();
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 20);
    // for( var i in photos ){
    //   imageList.add(i);
    // }
    // setState(() {
    print(photos);
    imageList.addAll(photos);
    // });

    firstImage(imageList.first);
    print(imageList);
  }

  void saveSelectedList() {
    viewList(selectedList);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void setPriceToFree() {
    if (priceController.value.text == "0") {
      priceController.value.text = "";
    } else {
      priceController.value.text = "0";
    }
  }

  void setPrice(String value) {
    priceController.value.text = value;
  }

  Future<String> post(PostModel newPost) async {
    print("is this wrong1");
    String postDocId = await PostRepository.postNewPost(newPost);
    print("is this wrong2");
    return postDocId;
  }

  Future<List<File>> convertViewListToPhotoFileList() async {
    List<File> output = [];
    for (AssetEntity element in viewList) {
      File? filee = await element.file;
      output.add(filee!);
    }
    return output;
  }

  void entirePostingProcess() async {
    if (!titleController.value.text.isNotEmpty ||
        titleController.value.text.length <= 5) {
      textVal.value = true;
    } else {
      textVal.value = false;
    } //verify title

    if (!priceController.value.text.isNotEmpty) {
      priceVal.value = true;
    } else {
      priceVal.value = false;
    } //vertify price

    List? desc = descriptionController.value.text.toString().split("\n");
    if (desc[0].length == 0) {
      descriptionVal.value = true;
    } else {
      descriptionVal.value = false;
    } // description price

    if (!textVal.value && !priceVal.value && !descriptionVal.value) {
      List<File> output = <File>[];
      if (viewList.value.length != 0) {
        output = await convertViewListToPhotoFileList();
        _updateNumberOfPhotos();
      }

      print("OUTPUT IS " + output.toString());

      PostModel newPost = PostModel(
        photoUrls: <String>[],
        photoFiles: output,
        title: titleController.value.text.toString(),
        price: priceController.value.text.toString(),
        description: descriptionController.value.text.toString(),
        createdTime: DateTime.now(),
        isFree: isFree.value,
        isNegotiable: isNegotiable.value,
        userUid: AuthController.to.myUser.value.uid.toString(),
      );

      // if( original.backgroundFile?.path != null ){
      //   UploadTask? task2 = await _firestorageRepo.uploadFile(original.uid!, "background", original.backgroundFile);
      //   task2?.snapshotEvents.listen((event) async {
      //     if (event.bytesTransferred == event.totalBytes )  {
      //       String downloadUrl = await event.ref.getDownloadURL();
      //       _updateBackgroundImageUrl( downloadUrl);
      //       FirebaseUserRepo.updateImageUrl( original.docId, downloadUrl, "background_url");
      //     }
      //   });
      // }


      _convertAndPost(newPost);


      // newPost.photoUrls = urlList;
      // post(newPost);
      Get.back(); // we need to show snackbar?? or something
    }
  }

  _updateNumberOfPhotos() async {
    int oldNumber = await UserRepository.getNumberOfPhotos(
        AuthController.to.myUser.value.uid.toString());
    print("old number is" + oldNumber.toString());

    int newNumber = oldNumber + viewList.value.length;
    print("new number is" + newNumber.toString());
    print("docId is " + AuthController.to.myUser.value.docId.toString() );//이게 없음.
    UserRepository.updateNumberOfPhotos(AuthController.to.myUser.value.docId, newNumber);
    AuthController.to.setNumberOfPhotos( newNumber );

  }

  _convertAndPost(PostModel newPost) async {
    String docId = await post(newPost);
    int num = AuthController.to.myUser.value.numberOfPhotos - newPost.photoFiles!.length;


    for (File element in newPost.photoFiles!) {
      num = num + 1;
      UploadTask? task = FirestorageRepo.uploadFile(
          element,num , AuthController.to.myUser.value.uid!);
      print( "NUM is " + num.toString() + "Is Task Null? : " + (task == null).toString());
      if (task != null) {
        task.snapshotEvents.listen((event) async {
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            String downloadUrl = await (event.ref.getDownloadURL()); //CHANGE THIS TO FUTURE WAIT
            //
            //
            //
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            PostRepository.addPhotoUrl(docId, downloadUrl, "photo_urls");
            newPost.photoUrls?.add(downloadUrl);
            print("DURATION STARTS");
            Duration(seconds: 3);
            print("DURATION ENDS");

            // _updateUrlList(downloadUrl);
            // print("download url is " + downloadUrl);
            // urlList.add(downloadUrl);
            // print("urlList added is " + urlList.toString());
          }
        });
      }
    }
  }
}
