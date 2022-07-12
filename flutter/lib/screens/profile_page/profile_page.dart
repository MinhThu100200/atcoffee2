import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/screens/change_password/change_password.dart';
import 'package:at_coffee/screens/manage_order_page/manage_order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/screens/profile_page/profile_update_page.dart';
import 'package:at_coffee/screens/login_page/login_page.dart';
import 'package:at_coffee/common/utils_common/api_service.dart';
import 'package:restart_app/restart_app.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());
  final BillController billController = Get.put(BillController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      productController.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 2.0),
                  alignment: Alignment.centerLeft,
                  child: Text(userController.user.value.name.toString(),
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 2.0),
                  alignment: Alignment.centerLeft,
                  child: const Text('Chào mừng tình yêu!',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))),
            ]),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Card(
                  child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Obx(() {
                        if (userController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.network(
                                  userController.user.value.image,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.contain, errorBuilder:
                                      (BuildContext context, Object exception,
                                          StackTrace stackTrace) {
                                return const Text('😢');
                              }, loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                }
                              }));
                        }
                      }))),
              Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 8.0),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Thông tin cá nhân",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileUpdatePage()));
                            },
                            child: const Text("Chỉnh sửa",
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 18.0)),
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      if (userController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(Icons.person_outline,
                                        color: Colors.black, size: 28.0),
                                  ),
                                  Flexible(
                                      child: Text(
                                          userController.user.value.name,
                                          style:
                                              const TextStyle(fontSize: 18.0)))
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(Icons.cake_outlined,
                                        color: Colors.black, size: 28.0),
                                  ),
                                  Flexible(
                                      child: Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      (userController
                                                              .user.value.dob)
                                                          .toInt()))
                                              .toString(),
                                          style:
                                              const TextStyle(fontSize: 18.0)))
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                        userController.user.value.gender ==
                                                'Nam'
                                            ? Icons.male_outlined
                                            : Icons.female_outlined,
                                        color: Colors.black,
                                        size: 28.0),
                                  ),
                                  Flexible(
                                      child: Text(
                                          userController.user.value.gender,
                                          style:
                                              const TextStyle(fontSize: 18.0)))
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(Icons.phone_outlined,
                                        color: Colors.black, size: 28.0),
                                  ),
                                  Flexible(
                                      child: Text(
                                          userController.user.value.phone,
                                          style:
                                              const TextStyle(fontSize: 18.0)))
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: 28.0),
                                  ),
                                  Flexible(
                                      child: Text(
                                          userController.user.value.address,
                                          style:
                                              const TextStyle(fontSize: 18.0)))
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(Icons.email_outlined,
                                        color: Colors.black, size: 28.0),
                                  ),
                                  Flexible(
                                    child: Text(userController.user.value.email,
                                        style: const TextStyle(fontSize: 18.0)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: const Icon(Icons.password_outlined,
                                color: Colors.black, size: 28.0),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => ChangePassword());
                              },
                              child: const Text('Đổi mật khẩu',
                                  style: TextStyle(fontSize: 18.0)))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => ManageOrderPage()),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: const Icon(Icons.local_shipping_outlined,
                                color: Colors.black, size: 28.0),
                          ),
                          const Text('Đơn hàng',
                              style: TextStyle(fontSize: 18.0))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Thông báo'),
                    content: const Text('Bạn chắc chắn đăng xuất?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Huỷ'),
                      ),
                      TextButton(
                        onPressed: logout,
                        child: const Text('Đồng ý'),
                      ),
                    ],
                  ),
                ),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: const Icon(Icons.logout_outlined,
                                color: Colors.black, size: 28.0),
                          ),
                          const Text('Đăng xuất',
                              style: TextStyle(fontSize: 18.0))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  logout() async {
    await removeToken();
    Restart.restartApp();
  }
}
