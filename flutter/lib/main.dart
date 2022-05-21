import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/screens/root_app/root_app.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
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
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    authUserByToken();
    super.initState();
  }

  void authUserByToken() async {
    User user = await userController.authUserByToken();
    print(user);
    if (user != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new RootApp(
                    nameRoute: "home",
                  )));
      // Get.off(() => RootApp());
    } else {
      // Timer(Duration(seconds: 3), openOnBoard);
      openOnBoard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
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
