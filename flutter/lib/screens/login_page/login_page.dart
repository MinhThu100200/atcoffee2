import 'package:at_coffee/screens/forget_password/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:at_coffee/screens/on_boarding.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/screens/signup_page/sign_up_page.dart';
import 'package:at_coffee/screens/root_app/root_app.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/user_controller.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: loginPage(),
//         onGenerateRoute: router.generateRoute);
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  bool _validateEmail = false;
  final _password = TextEditingController();
  bool _validatePassword = false;
  bool _statePassword = true;

  final UserController userController = Get.put(new UserController());

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _login(String email, String password) async {
    // Data Fixed - Change
    await userController.authUser('0346279377', '1234567890');
    if (userController.user.value.name != "" &&
        userController.user.value.name != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new RootApp(nameRoute: 'home')));
      // Get.off(() => new RootApp());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  height: (size.height - 30) * 0.5,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: Image.asset(
                                "assets/images/logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ]),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: bgTextField,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: black.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  style: TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: _validateEmail
                                        ? 'Email không đươc để trống'
                                        : null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: bgTextField,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                color: black.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  controller: _password,
                                  style: TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  obscureText: _statePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập mật khẩu',
                                    labelStyle: TextStyle(color: Colors.black),

                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: _validatePassword
                                        ? 'Mật khẩu không đươc để trống'
                                        : null,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _statePassword
                                          ? _statePassword = false
                                          : _statePassword = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: black.withOpacity(0.5),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: openForgetPassword,
                            child: Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                // login button and social login
                Container(
                    height: (size.height - 60) * 0.5,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _email.text.isEmpty
                                  ? _validateEmail = true
                                  : _validateEmail = false;
                            });
                            setState(() {
                              _password.text.isEmpty
                                  ? _validatePassword = true
                                  : _validatePassword = false;
                            });
                            if (!_password.text.isEmpty &&
                                !_email.text.isEmpty) {
                              _login(_email.text, _password.text);
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_forward_sharp,
                                  color: white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Divider(
                                thickness: 0.8,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Hoặc"),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Divider(
                                thickness: 0.8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: black.withOpacity(0.1))),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/google_icon.svg",
                                  width: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: black.withOpacity(0.1))),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/facebook_icon.svg",
                                  width: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có tài khoản?",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            InkWell(
                              onTap: openSignUp,
                              child: Text(
                                "Đăng ký",
                                style: TextStyle(
                                    fontSize: 13,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void openForgotPassword() {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => ForgotPassword()));
  // }

  void openSignUp() {
    Get.to(() => SignUpPage());
  }

  void openForgetPassword() {
    Get.to(() => ForgetPassword());
  }
}
