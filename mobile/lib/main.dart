import 'dart:async';
import 'package:at_coffee/controllers/category_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'avenir'),
      initialRoute: "/",
      getPages: [GetPage(name: '/', page: () => MyHomePage())],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: primary,
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
              )),
        ),
      ),
    );
  }

  void openOnBoard() {
    Get.off(() => Onboarding());
  }
}
