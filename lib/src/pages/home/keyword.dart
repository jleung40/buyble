import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Keyword extends StatefulWidget {
  const Keyword({Key? key}) : super(key: key);

  @override
  State<Keyword> createState() => _KeywordState();
}

class _KeywordState extends State<Keyword> {
  late TextEditingController _keywordController;

  @override
  void initState() {
    // TODO: implement initState
    _keywordController = TextEditingController();
    super.initState();
  }

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
      title: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextField(
                autofocus: true ,
                controller: _keywordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: "Search near Columbia U",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
    );
  }
}
