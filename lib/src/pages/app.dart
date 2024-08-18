import 'package:buyble_real/src/component/icons_path.dart';
import 'package:buyble_real/src/component/image_data.dart';
import 'package:buyble_real/src/controller/bottom_controller.dart';
import 'package:buyble_real/src/pages/home/home.dart';
import 'package:buyble_real/src/pages/my_profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class App extends GetView<BottomController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
      onWillPop: controller.willPopAction,
      child: Scaffold(
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                const Home(),
                Container(
                  child: Center(
                    child: Text("Hii"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("Hiii"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("Hiiii"),
                  ),
                ),
                const MyProfile(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              currentIndex: controller.pageIndex.value,
              onTap: (value) => controller.changeBottom(value),
              items: [
                BottomNavigationBarItem(
                    icon: ImageData(
                      iconn: IconsPath.homeOff,
                    ),
                    activeIcon: ImageData(
                      iconn: IconsPath.homeOn,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: ImageData(
                      iconn: IconsPath.searchOff,
                    ),
                    activeIcon: ImageData(
                      iconn: IconsPath.searchOn,
                    ),
                    label: "Search"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    activeIcon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                    label: "Upload"),
                BottomNavigationBarItem(
                    icon: ImageData(
                      iconn: IconsPath.activeOff,
                    ),
                    activeIcon: ImageData(
                      iconn: IconsPath.activeOn,
                    ),
                    label: "My Page"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/user_off.svg", width: 23,),
                    activeIcon: SvgPicture.asset("assets/svg/user_on.svg",width: 23,),
                    label: "Profile"),
              ],
            ),
          ),
    ));
  }
}
