import 'package:buyble_real/src/user_verify.dart';
import 'package:buyble_real/src/login.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
       if (!snapshot.hasData) {
          return const Login();
        } else if (snapshot.hasData) {
          return UserVerify(data: snapshot.data);
        }


       if (snapshot.connectionState != ConnectionState.done) {
         return Container(
           color: BuybleColor.colorList[0],
           child: Center(
             child: Text(
               "Buyble",
               style: TextStyle(color: Colors.black),
             ),
           ),
         );
        }
       return Container(child: Center(child: Text("dewdwedw"),),);
       //




      },
    );
  }
}
