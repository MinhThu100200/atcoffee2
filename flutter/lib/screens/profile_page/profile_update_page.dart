import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({Key key}) : super(key: key);
  _ProfileUpdatePage createState() => _ProfileUpdatePage();
}

class _ProfileUpdatePage extends State<ProfileUpdatePage> {
  final userController = Get.put(new UserController());
  bool isSaving = false;
  var _name = TextEditingController();
  bool _validateName = false;
  var _dob = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  var _phone = TextEditingController();
  bool _validatePhone = false;
  var _address = TextEditingController();
  bool _validateAddress = false;
  var _email = TextEditingController();
  bool _validateEmail = false;
  var _gender = -1;
  @override
  void initState() {
    _name = TextEditingController(text: userController.user.value.name);
    _selectedDate =
        DateTime.fromMillisecondsSinceEpoch(userController.user.value.dob);

    _dob = TextEditingController(
        text: new DateFormat('dd/MM/yyyy')
            .format(DateTime.fromMillisecondsSinceEpoch(
                (userController.user.value.dob).toInt()))
            .toString());

    _phone = TextEditingController(text: userController.user.value.phone);

    _address = TextEditingController(text: userController.user.value.address);

    _email = TextEditingController(text: userController.user.value.email);

    _gender = userController.user.value.gender == 'Nam'
        ? 0
        : userController.user.value.gender == 'Nữ'
            ? 1
            : 2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Container(
              alignment: Alignment.centerLeft,
              child: Row(children: [
                const Expanded(child: Text("Cập nhật thông tin cá nhân")),
                GestureDetector(
                  onTap: () {
                    _updateUser();
                  },
                  child: const Text("Lưu", style: const TextStyle(color: Colors.white)),
                )
              ])),
          elevation: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                cursorColor: black.withOpacity(0.5),
                                style: const TextStyle(fontSize: 18),
                                cursorHeight: 20,
                                controller: _name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Nhập tên',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  hintText: "Tên",
                                  // border: InputBorder.none,
                                  errorText: _validateName
                                      ? 'Tên không đươc để trống'
                                      : null,
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {},
                                child: TextField(
                                  readOnly: true,
                                  cursorColor: black.withOpacity(0.5),
                                  style: const TextStyle(fontSize: 18),
                                  cursorHeight: 20,
                                  controller: _dob,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    labelText: 'Nhập ngày sinh',
                                    labelStyle:
                                        TextStyle(color: Colors.black),
                                    hintText: "Ngày sinh",
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: black.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                }),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                cursorColor: black.withOpacity(0.5),
                                style: const TextStyle(fontSize: 18),
                                cursorHeight: 20,
                                controller: _phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Nhập số điện thoại',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  hintText: "Số điện thoại",
                                  // border: InputBorder.none,
                                  errorText: _validatePhone
                                      ? 'Số điện thoại không đươc để trống'
                                      : null,
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                cursorColor: black.withOpacity(0.5),
                                style: const TextStyle(fontSize: 18),
                                cursorHeight: 20,
                                controller: _address,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Nhập địa chỉ',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  hintText: "Địa chỉ",
                                  // border: InputBorder.none,
                                  errorText: _validateAddress
                                      ? 'Địa chỉ không đươc để trống'
                                      : null,
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                cursorColor: black.withOpacity(0.5),
                                style: const TextStyle(fontSize: 18),
                                cursorHeight: 20,
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Nhập email',
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  hintText: "Email",
                                  // border: InputBorder.none,
                                  errorText: _validateEmail
                                      ? 'Email không đươc để trống'
                                      : null,
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
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
                                const Text('Nữ', style: TextStyle(fontSize: 18.0))
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
                        )),
                  ],
                ),
              ),
              if (isSaving == true) ...[
                Positioned(
                  child: Container(
                    width: size.width,
                    height: size.height - 86.0,
                    color: Colors.grey.withOpacity(0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ]
            ],
          ),
        )));
  }

  void _updateUser() async {
    // start loading
    setState(() => isSaving = true);
    // validate name not empty
    setState(() {
      _validateName = _name.text.trim().isEmpty;
    });
    // validate phone not empty
    setState(() {
      _validatePhone = _phone.text.trim().isEmpty;
    });
    // validate address not empty
    setState(() {
      _validateAddress = _address.text.trim().isEmpty;
    });

    // validated
    if (!_validateName && !_validatePhone && !_validateAddress) {
      var user = userController.user.value;
      user.name = _name.text;
      user.gender = _gender == 0
          ? 'Nam'
          : _gender == 1
              ? 'Nữ'
              : 'Khác';
      user.phone = _phone.text;
      user.address = _address.text;
      user.email = _email.text;
      user.dob = _selectedDate.millisecondsSinceEpoch;
      // save User
      bool isUpdated = await userController.updateUser(user);
      // close loading
      setState(() => isSaving = false);
      var message = 'Cập nhật thông tin thất bại';
      // success
      if (isUpdated) {
        message = 'Cập nhật thông tin thành công';
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primary,
            textColor: Colors.white,
            fontSize: 16.0);
        // go to previous screen
        Navigator.pop(context);
        // fail
      } else {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: googleColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      // close loading
      setState(() => isSaving = false);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
    );
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
        _dob = TextEditingController(
            text:
                DateFormat('dd/MM/yyyy').format(_selectedDate).toString());
      });
    }
  }
}
