

import 'package:buyble_real/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

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
      title: Text("Books"),
      actions: [Icon(Icons.search)],
    );
  }

  Widget _makeItemList() {
    return Column(
      children: List.generate(
          50,
              (index) =>
              Container(
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
              )),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: ListView(
        children: [
          _makeItemList(),
        ],
      ),
    );
  }
}
