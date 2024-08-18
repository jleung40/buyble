import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopup extends StatelessWidget {
  final String title;
  final String message;
  final Function() okCallback;
  final Function()? cancelCallback;

  MessagePopup(
      {Key? key,
      required this.title,
      required this.message,
      required this.okCallback,
      this.cancelCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,

        child: Stack(
          children: [
            Positioned(top: 0,bottom: 0,left: 0,right: 0, child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(color: Colors.transparent,),
            ),),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: Get.mediaQuery.size.width * 0.7,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            message,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: cancelCallback,
                              child: Container(
                                margin :EdgeInsets.only(top: 9),
                                padding: EdgeInsets.symmetric(vertical:7),
                                alignment: Alignment.center,
                                width: Get.mediaQuery.size.width * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: okCallback,
                              child: Container(
                                margin :EdgeInsets.only(top: 9),
                                padding: EdgeInsets.symmetric(vertical:7),
                                alignment: Alignment.center,
                                width: Get.mediaQuery.size.width * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: BuybleColor.colorList[2],
                                ),
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )



        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       width: Get.mediaQuery.size.width * 0.7,
        //       padding: EdgeInsets.all(20),
        //       color: Colors.white,
        //       child: Column(
        //         children: [
        //           Text(
        //             title,
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 20,
        //                 color: Colors.black),
        //           ),
        //           Text(
        //             message,
        //             style: TextStyle(fontSize: 16, color: Colors.black),
        //           ),
        //         ],
        //       ),
        //     ),
        //
        //   ],
        // ),
        );
  }
}
