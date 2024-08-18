


import 'package:buyble_real/src/model/post_model.dart';
import 'package:buyble_real/src/repository/post_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxList<PostModel> postList = <PostModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    _loadPosts();
    super.onInit();
  }

  _loadPosts() async {


     List<PostModel> listOfPosts  = await PostRepository.loadPosts();
     postList(listOfPosts);


  }







}