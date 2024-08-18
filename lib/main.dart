import 'package:buyble_real/firebase_options.dart';
import 'package:buyble_real/root.dart';
import 'package:buyble_real/src/controller/init_bindings.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:buyble_real/src/utils/buyble_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBindings(),
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 30,

            ),
            titleTextStyle: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor:  Colors.white ,

          elevation: 0,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          splashColor: Colors.white.withOpacity(0.1),





        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),

      ),
      home: Root(),
    );
  }
}
