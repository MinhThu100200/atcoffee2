import 'package:at_coffee/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  _ForgetPassword createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  final UserController userController = Get.put(UserController());

  final _email = new TextEditingController();
  bool _validateEmail = false;
  String _msgValidateEmail = '';
  bool _isSending = false;

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
      body: SafeArea(
        child: SingleChildScrollView(
            child: Stack(
          children: [
            Positioned(
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        // height: (size.height - 30) * 0.5,
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
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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
                                        style: const TextStyle(fontSize: 15),
                                        cursorHeight: 20,
                                        controller: _email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Nhập email',
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          hintText: "Email",
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
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: resetPassword,
                            child: Container(
                              height: 50,
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Reset mật khẩu",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            if (_isSending == true) ...[
              Positioned(
                child: Container(
                  width: size.width,
                  height: size.height - 86.0,
                  color: Colors.grey.withOpacity(0.3),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ]
          ],
        )),
      ),
    );
  }

  void resetPassword() async {
    bool flag = true;
    setState(() {
      if (_email.text.trim().isEmpty) {
        _validateEmail = true;
        _msgValidateEmail = 'Email không được để trống';
        flag = false;
      } else {
        _validateEmail = false;
      }
    });

    if (flag == true) {
      setState(() {
        _isSending = true;
      });
      bool isSuccess = await userController.resetPassword(_email.text);
      if (isSuccess) {
        Fluttertoast.showToast(
            msg: 'Reset mật khẩu thành công',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primary,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.off(() => LoginPage());
      } else {
        setState(() {
          _validateEmail = true;
          _msgValidateEmail = 'Email chưa được đăng kí';
          _isSending = false;
        });
      }
    }
  }
}
