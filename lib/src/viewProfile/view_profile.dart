import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/controller/view_profile_controller.dart';
import 'package:buyble_real/src/pages/home/detail.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:buyble_real/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ViewProfile extends GetView<ViewProfileController> {
  const ViewProfile({Key? key}) : super(key: key);

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
      title: Text("Profile"),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        PopupMenuButton(
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                1),
            onSelected: (String value) {
              //메뉴 뜨는걸 바꿈
              print(value);
            },
            offset: Offset(0, 0),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: Text(
                      "Report",
                    ),
                    value: "Report"),
                PopupMenuItem(
                  child: Text("Disapprove"),
                  //thisdhas to be conditional (location)
                  value: "Disapprove",
                ),
                PopupMenuItem(
                  child: Text("Block"),
                  value: "Block",
                ),
                PopupMenuItem(
                  child: Text("Hide this user"),
                  value: "Hide",
                ),
              ];
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert_sharp),
            ))
      ],
    );
  }

  _body() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Container(
                width: 100,
                height: 100,
                // child: Image.network(
                //   controller.myUser.value.thumbnail!,
                //   fit: BoxFit.cover,
                // )

                child: controller.targetUser.value.thumbnail.toString() == ""
                    ? Image.asset("assets/images/default_image.png", fit: BoxFit.cover,)
                    : Image.network(controller.targetUser.value.thumbnail.toString(),fit: BoxFit.cover,),
              ),),
            ),

          Text(
            controller.targetUser.value.nickname!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              controller.targetUser.value.description!,
              style: TextStyle(fontSize: 17),
            ),
          ),
          // TabBar(tabs: tabs)
        ],
      ),
    );
  }

  Widget _tabMenu() {
    return TabBar(
        indicatorColor: Colors.black,
        controller: controller.tabCon,
        tabs: [
          Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Icon(
              Icons.list_alt_outlined,
              color: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Icon(
              Icons.reviews_outlined,
              color: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Icon(
              Icons.chat_bubble_outline_sharp,
              color: Colors.black,
            ),
          ),
        ]);
  }

  Widget _line() {
    return Container(
      height: 1,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _itemList() {
    return SizedBox(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(
            10,
            (index) => GestureDetector(
                  onTap: () {
                    // Get.to(() => Detail(), transition: Transition.downToUp);
                  },
                  child: Container(
                    height: 130,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              color: Colors.grey,
                              width: 100,
                              height: 100,
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
                                  "Title",
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
                                  Util.numToDol("45"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
      ),
    );
  }

  Widget _feedback() {
    return SizedBox(
      child: ListView(physics: NeverScrollableScrollPhysics(), children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(
                Icons.tag_faces_rounded,
                color: BuybleColor.colorList[2],
              ),
              Text("Praises")
            ],
          ),
        ),
        ...List.generate(
          9,
          (index) => Container(
            alignment: Alignment.centerLeft,
            height: 80,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text((index + 1).toString() + " . "),
                    Text("Price was good"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(
                      width: 5,
                    ),
                    Text((20 - index).toString()),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _reviews() {
    return SizedBox(
      child: ListView(physics: NeverScrollableScrollPhysics(), children: [
        Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text("6 Reviews")),
        ...List.generate(
          9,
          (index) => _reviewBox(index),
        )
      ]),
    );
  }

  Widget _reviewBox(int index) {
    return Container(
        alignment: Alignment.centerLeft,
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey, border: Border()),
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "abdul abdul",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      "lincoln Street  3 yrs",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Text(
                    "he was a cool guyhe was a cool guy,he was a cool guyhe was a cool guy,he was a cool guyhe was a cool guy,he was a cool guyhe was a cool guy,he was a cool guyhe was a cool guy,",
                    style: TextStyle(fontSize: 17),
                    maxLines: 3,
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget _tabItems() {
    return Expanded(
      child: TabBarView(controller: controller.tabCon, children: [
        _itemList(),
        _feedback(),
        _reviews(),
      ]),
    );
  }

  Widget _profileHeader() {
    return Column(
      children: [
        _body(),
        _line(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([_profileHeader()]),
              )
            ];
          },
          body: Column(
            children: [
              Material(
                child: _tabMenu(),
              ),
              _tabItems()
            ],
          ),
        )
        // SingleChildScrollView(
        //
        //     child: ListView(
        //       physics: NeverScrollableScrollPhysics(),
        //       children: [_body(), _line(), _tabMenu(), _tabItems(), ],
        //     ),
        // ),

        );
  }
}
