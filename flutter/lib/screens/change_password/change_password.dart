import 'package:at_coffee/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);
  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final UserController userController = Get.put(UserController());

  final _oldPassword = new TextEditingController();
  bool _validateOldPassword = false;
  String _msgValidateOldPassword = '';
  final _password = new TextEditingController();
  bool _validatePassword = false;
  String _msgValidatePassword = '';
  final _passwordConfirm = new TextEditingController();
  bool _validatePasswordConfirm = false;
  String _msgValidatePasswordConfirm = '';
  bool _isHideOldPassword = true;
  bool _isHidePassword = true;
  bool _isHidePasswordConfirm = true;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text("Đổi mật khẩu"),
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Stack(children: [
              Positioned(
                  child: Container(
                padding: const EdgeInsets.only(
                    top: 0, left: 30, bottom: 0, right: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
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
                                controller: _oldPassword,
                                style: const TextStyle(fontSize: 15),
                                cursorHeight: 20,
                                obscureText: _isHideOldPassword,
                                decoration: InputDecoration(
                                  labelText: 'Nhập mật khẩu cũ',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),

                                  //hintText: "Email",
                                  border: InputBorder.none,
                                  errorText: _validateOldPassword
                                      ? _msgValidateOldPassword
                                      : null,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isHideOldPassword
                                        ? _isHideOldPassword = false
                                        : _isHideOldPassword = true;
                                  });
                                },
                                icon: _isHideOldPassword
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
                                controller: _password,
                                style: const TextStyle(fontSize: 15),
                                cursorHeight: 20,
                                obscureText: _isHidePassword,
                                decoration: InputDecoration(
                                  labelText: 'Nhập mật khẩu mới',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),

                                  //hintText: "Email",
                                  border: InputBorder.none,
                                  errorText: _validatePassword
                                      ? _msgValidatePassword
                                      : null,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isHidePassword
                                        ? _isHidePassword = false
                                        : _isHidePassword = true;
                                  });
                                },
                                icon: _isHidePassword
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
                                  labelText: 'Xác nhận mật khẩu',
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
                      height: 40,
                    ),
                    InkWell(
                      onTap: _changePassword,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Đổi mật khẩu",
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
              )),
              if (_isSaving) ...[
                Positioned(
                  child: Container(
                    width: size.width,
                    height: size.height - 86.0,
                    color: Colors.grey.withOpacity(0.3),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ],
            ]),
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    bool _flag = true;
    setState(() {
      if (_oldPassword.text.trim().isEmpty) {
        _validateOldPassword = true;
        _msgValidateOldPassword = 'Mật khẩu cũ không được để trống';
        _flag = false;
      } else {
        _validateOldPassword = false;
        _msgValidateOldPassword = '';
      }
    });

    setState(() {
      if (_password.text.trim().isEmpty) {
        _validatePassword = true;
        _msgValidatePassword = 'Mật khẩu mới không được để trống';
        _flag = false;
      } else {
        _validatePassword = false;
        _msgValidatePassword = '';
      }
    });

    setState(() {
      if (_passwordConfirm.text.trim().isEmpty) {
        _validatePasswordConfirm = true;
        _msgValidatePasswordConfirm = 'Xác nhận mật khẩu không được để trống';
        _flag = false;
      } else {
        _validatePasswordConfirm = false;
        _msgValidatePasswordConfirm = '';
      }
    });

    setState(() {
      if (_flag) {
        if (_passwordConfirm.text.compareTo(_password.text) != 0) {
          _validatePasswordConfirm = true;
          _msgValidatePasswordConfirm = 'Xác nhận mật khẩu không khớp';
          _flag = false;
        } else {
          _validatePasswordConfirm = false;
          _msgValidatePasswordConfirm = '';
        }
      }
    });

    if (_flag) {
      setState(() {
        _isSaving = true;
      });

      bool _isSaved = await userController.changePassword(
          _oldPassword.text, _password.text);

      if (_isSaved != null && _isSaved == true) {
        Fluttertoast.showToast(
            msg: 'Đổi mật khẩu thành công',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primary,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.to(() => ProfilePage());
      } else {
        Fluttertoast.showToast(
            msg: 'Mật khẩu cũ không đúng',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: red2,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
