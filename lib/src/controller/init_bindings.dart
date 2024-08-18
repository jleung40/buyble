import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/controller/bottom_controller.dart';
import 'package:buyble_real/src/controller/home_controller.dart';
import 'package:buyble_real/src/controller/upload_controller.dart';
import 'package:buyble_real/src/controller/view_profile_controller.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BottomController(), permanent: true);
    Get.put(AuthController(), permanent: true);
     //씨발 이거 ㅇ어디다가 넣음.
    Get.put(HomeController(), permanent: true);
    // Get.put( ViewProfileController(), permanent:  true);
  }

  static additionalBindings() {
    Get.lazyPut(() => ViewProfileController());
  }
}
