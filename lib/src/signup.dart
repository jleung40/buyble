import 'dart:io';

import 'package:buyble_real/src/controller/auth_controller.dart';
import 'package:buyble_real/src/model/b_user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  String uid;

  Signup({Key? key, required this.uid}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

//we are using setstate method instead of Getx for this section
//using GetxController for every single things might not be as effectively

class _SignupState extends State<Signup> {
  TextEditingController _nicknameCon = TextEditingController();
  TextEditingController _descriptionCon = TextEditingController();
  ImagePicker _imagePicker = ImagePicker();
  XFile? image;

  Widget _nickname() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: _nicknameCon,
        decoration: InputDecoration(
            hintText: "nickname", contentPadding: EdgeInsets.all(10)),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        controller: _descriptionCon,
        decoration: InputDecoration(
            hintText: "description", contentPadding: EdgeInsets.all(10)),
      ),
    );
  }

  void update()=> setState(() {});

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: image == null ? Image.asset(
              "assets/images/default_image.png",
              fit: BoxFit.cover,
            ) : Image.file(File(image!.path), fit: BoxFit.cover,),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        ElevatedButton(
            onPressed: () async {
               image = await _imagePicker.pickImage(
                  source: ImageSource.gallery, imageQuality: 10);
               //max width 설정해서 고용량 8k사진은 사용불가로 하기
               update();
            },
            child: Text("Change Profile"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            _avatar(),
            SizedBox(
              height: 30,
            ),
            _nickname(),
            SizedBox(
              height: 30,
            ),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: ElevatedButton(
          onPressed: () {
            print(_nicknameCon.text);
            print(_descriptionCon.text);
//조건문을 달아얗ㅁ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            BUser newUser = BUser(
              nickname: _nicknameCon.text,
              description: _descriptionCon.text,
              uid: widget.uid,
              createdTime: DateTime.now(),
              lastLoginTime: DateTime.now(),
              numberOfPhotos: 0,
            );

            AuthController.to.signup(newUser, image );
          },
          child: Text("Sign up"),
        ),
      ),
    );
  }
}
