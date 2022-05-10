import 'package:at_coffee/screens/root_app/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:at_coffee/screens/on_boarding.dart';
import 'package:at_coffee/screens/login_page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/common/utils_common/utils_common.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class SignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(fontFamily: 'avenir'),
//       home: signupPage(),
//     );
//   }
// }

class SignUpPage extends StatefulWidget {
  @override
  _signupPageState createState() => _signupPageState();
}

class _signupPageState extends State<SignUpPage> {
  final userController = Get.put(UserController());

  final _email = TextEditingController();
  bool _validateEmail = false;
  final _name = TextEditingController();
  bool _validateName = false;
  String _msgValidateEmail = 'Email không đươc để trống';
  final _phone = TextEditingController();
  bool _validatePhone = false;
  final _password = TextEditingController();
  bool _validatePassword = false;
  final _passwordConfirm = TextEditingController();
  bool _validatePasswordConfirm = false;
  String _msgValidatePasswordConfirm = 'Xác nhận mật khẩu không đươc để trống';
  bool _isHidePasswordConfirm = true;
  bool _isHidestatePassword = true;
  var _gender = 0;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
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
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 30, bottom: 0, right: 30),
            child: Column(
              children: [
                Container(
                  // height: size.height * 0.55,
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
                                fit: BoxFit.contain,
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
                                Icons.person,
                                color: black.withOpacity(0.5),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  style: TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  controller: _name,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập tên',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: _validateName
                                        ? 'Tên không được để trống'
                                        : null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                              const SizedBox(
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
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: _validateEmail
                                        ? _msgValidateEmail
                                        : null,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
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
                                Icons.phone,
                                color: black.withOpacity(0.5),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  controller: _phone,
                                  style: const TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập số điện thoại',
                                    labelStyle: TextStyle(color: Colors.black),

                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText:
                                        _validatePhone ? 'Số điện thoại' : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  controller: _password,
                                  style: const TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  obscureText: _isHidestatePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập mật khẩu',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),

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
                                      _isHidestatePassword
                                          ? _isHidestatePassword = false
                                          : _isHidestatePassword = true;
                                    });
                                  },
                                  icon: _isHidestatePassword
                                      ? Icon(
                                          CupertinoIcons.eye_slash,
                                          color: black.withOpacity(0.5),
                                        )
                                      : Icon(
                                          CupertinoIcons.eye_solid,
                                          color: black.withOpacity(0.5),
                                        ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
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
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: TextField(
                                  cursorColor: black.withOpacity(0.5),
                                  controller: _passwordConfirm,
                                  style: const TextStyle(fontSize: 15),
                                  cursorHeight: 20,
                                  obscureText: _isHidePasswordConfirm,
                                  decoration: InputDecoration(
                                    labelText: 'Nhập lại mật khẩu',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),

                                    //hintText: "Email",
                                    border: InputBorder.none,
                                    errorText: _validatePasswordConfirm
                                        ? _msgValidatePasswordConfirm
                                        : null,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isHidePasswordConfirm
                                          ? _isHidePasswordConfirm = false
                                          : _isHidePasswordConfirm = true;
                                    });
                                  },
                                  icon: _isHidePasswordConfirm
                                      ? Icon(
                                          CupertinoIcons.eye_slash,
                                          color: black.withOpacity(0.5),
                                        )
                                      : Icon(
                                          CupertinoIcons.eye_solid,
                                          color: black.withOpacity(0.5),
                                        ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 00,
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 8.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: _gender,
                                      onChanged: (value) {
                                        setState(() {
                                          _gender = value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    const Text('Nam',
                                        style: TextStyle(fontSize: 18.0))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _gender,
                                      onChanged: (value) {
                                        setState(() {
                                          _gender = value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    const Text('Nữ',
                                        style: TextStyle(fontSize: 18.0))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: _gender,
                                      onChanged: (value) {
                                        setState(() {
                                          _gender = value;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    const Text('Khác',
                                        style: TextStyle(fontSize: 18.0))
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // login button and social login
                Container(
                    // height: (size.height - 30) * 0.5,
                    child: Column(
                  children: [
                    InkWell(
                      onTap: signUp,
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
                              "Đăng ký",
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
                    const SizedBox(
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
                              border:
                                  Border.all(color: black.withOpacity(0.1))),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/google_icon.svg",
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: black.withOpacity(0.1))),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/facebook_icon.svg",
                              width: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Bạn đã có tài khoản?",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                          onTap: openLoginPage,
                          child: const Text(
                            "Đăng nhập",
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

  void openLoginPage() {
    Get.off(() => LoginPage());
  }

  void signUp() async {
    bool _isValid = true;
    setState(() {
      if (_name.text.trim().isEmpty) {
        _validateName = true;
        _isValid = false;
      } else {
        _validateName = false;
      }
    });
    setState(() {
      if (_email.text.isEmpty) {
        _validateEmail = true;
        _msgValidateEmail = 'Email không đươc để trống';
        _isValid = false;
      } else {
        if (!UtilsCommon.isEmail(_email.text)) {
          _validateEmail = true;
          _msgValidateEmail = 'Email không hợp lệ';
          _isValid = false;
        } else {
          _validateEmail = false;
        }
      }
    });

    setState(() {
      if (_phone.text.isEmpty) {
        _validatePhone = true;
        _isValid = false;
      } else {
        _validatePhone = false;
      }
    });

    setState(() {
      if (_password.text.isEmpty) {
        _validatePassword = true;
        _isValid = false;
      } else {
        _validatePassword = false;
      }
    });

    setState(() {
      if (_passwordConfirm.text.isEmpty) {
        _validatePasswordConfirm = true;
        _msgValidatePasswordConfirm = 'Xác nhận mật khẩu không đươc để trống';
        _isValid = false;
      } else {
        if (_password.text != _passwordConfirm.text) {
          _validatePasswordConfirm = true;
          _msgValidatePasswordConfirm = 'Xác nhận mật khẩu không khớp';
          _isValid = false;
        } else {
          _validatePasswordConfirm = false;
        }
      }
    });
    if (_isValid) {
      User user = new User();
      user.code = _email.text;
      user.name = _name.text;
      user.email = _email.text;
      user.username = _email.text;
      user.phone = _phone.text;
      user.identityCard = _phone.text;
      user.password = _password.text;
      user.dob = DateTime.now().millisecondsSinceEpoch;
      user.address = '';
      user.gender = _gender == 0
          ? 'Nam'
          : _gender == 1
              ? 'Nữ'
              : 'Khác';

      String validateMsg = await userController.validateSignUp(user);
      if (validateMsg == '') {
        User userNew = await userController.signUp(user);

        if (userNew != null) {
          Fluttertoast.showToast(
              msg: 'Đăng kí thành công',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: primary,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.to(() => RootApp());
        } else {
          Fluttertoast.showToast(
              msg: 'Đăng kí thất bại',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: red2,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: validateMsg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: red2,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      //
      // Get.off(() => LoginPage());
    }
  }
}
