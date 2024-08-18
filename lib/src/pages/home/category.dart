import 'package:buyble_real/src/pages/home/category_list.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

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
      title: Text("Categories"),
    );
  }

  Widget _popularItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            "Popular Items",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                5,
                (index) => Column(children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CategoryList(), transition: Transition.downToUp);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      margin: EdgeInsets.all(8),
                      width: 70,
                      height: 70,
                      child: SvgPicture.asset("assets/svg/bell.svg"),
                    ),
                  ),
                  Text("Most Liked")
                ]),
              ),
            )),
      ],
    );
  }

  Widget _allCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0),
          child: Text(
            "All Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              mainAxisExtent: 60),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(() => const CategoryList(), transition: Transition.downToUp);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: const Row(
                children: [Icon(Icons.book_outlined), Text("Books")],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          _popularItems(),
          _allCategories(),
        ],
      ),
    );
  }
}
