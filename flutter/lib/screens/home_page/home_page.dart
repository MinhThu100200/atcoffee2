import 'package:at_coffee/controllers/address_controller.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/location_page/address_delivery.dart';
import 'package:at_coffee/screens/products_page/products_page.dart';
import 'package:at_coffee/screens/reward_page/reward_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';

import '../products_page/product_item.dart';
import '../products_page/products_page.dart';
import '../root_app/root_app.dart';

class HomePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  final StoreController storeController = Get.put(StoreController());
  final UserController userController = Get.put(UserController());
  final ProductController productController = Get.put(ProductController());
  final AddressController addressController = Get.put(AddressController());
  final CartController cartController = Get.put(CartController());
  //var selected = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      storeController.getAddress();
      productController.fetchProductSuggest(userController.user.value.id, 3);
      storeController.getStoreListNearYou();
      addressController.fetchDistrictByCity();
      cartController.fetchCartsByCustomerId(userController.user.value.id);

      //addressController.fetchAddress();
      print("Build Completed:" + userController.user.value.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGray3,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: SafeArea(
              child: Container(
                color: primary,
                child: Column(
                  children: [
                    Container(
                        child: SizedBox(
                      width: size.width,
                      child: Stack(alignment: Alignment.centerLeft, children: [
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Obx(
                                () => Text(
                                    "Xin chào, " +
                                        userController.user.value.name +
                                        " !!!",
                                    style: const TextStyle(
                                        color: white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )
                      ]),
                    )),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 12),
                      child: const Text("Trang chủ",
                          style: TextStyle(
                              color: white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.only(top: 20.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: lightGray3),
                      child: Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 110,
                                    width: size.width - 40,
                                    decoration: BoxDecoration(
                                        color: pink,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 90,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Image.asset(
                                                      'assets/icons/reward-cup.png'),
                                                ),
                                                Positioned(
                                                    left: 30,
                                                    top: 47,
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                transparentBlack,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Obx(
                                                          () => Text(
                                                              userController
                                                                  .user
                                                                  .value
                                                                  .currentPoints
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        )))
                                              ],
                                            )),
                                        GestureDetector(
                                          onTap: () => Get.to(() =>
                                              RootApp(nameRoute: 'reward')),
                                          child: Container(
                                            width: size.width - 130,
                                            decoration: BoxDecoration(
                                                color: lightPink,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 16),
                                                    child: Text(
                                                        "Phần thưởng khả dụng",
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800))),
                                                SizedBox(height: 6),
                                                Container(
                                                    height: 48,
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        left: 34, right: 34),
                                                    decoration: BoxDecoration(
                                                        color: primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16)),
                                                    child: Text(
                                                        "Chưa đạt phần thưởng",
                                                        style: TextStyle(
                                                            color: white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text("Đặt hàng online",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800))),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _delivery(),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: size.width / 2 - 40,
                                      width: size.width / 2 - 30,
                                      decoration: BoxDecoration(
                                          color: lightGreen2,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      //padding: const EdgeInsets.only(bottom: 5),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 65,
                                              margin:
                                                  const EdgeInsets.only(top: 8),
                                              child: Image.asset(
                                                  'assets/icons/delivery-man.png'),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        top: 6, left: 8),
                                                    child: Text("Delivery",
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 8, right: 5),
                                              child: Text(
                                                  "Giao hàng tận nơi đến địa chỉ của bạn",
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    //color: primary,
                                                    fontSize: 12,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () => _takeAway(),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: size.width / 2 - 40,
                                      width: size.width / 2 - 30,
                                      decoration: BoxDecoration(
                                          color: lightGreen2,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 80,
                                              child: Image.asset(
                                                  'assets/images/strawberry-background.png'),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text("Take away ",
                                                        style: TextStyle(
                                                            color: primary,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 8, right: 5),
                                              child: Text(
                                                  "Đặt trước và nhận đồ tại cửa hàng bạn chọn",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    //color: primary,
                                                    fontSize: 12,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text("Gợi ý riêng của bạn",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800))),
                              ],
                            ),
                            Obx(() {
                              if (productController.isLoading.value)
                                return Center(
                                    child: CircularProgressIndicator());
                              else
                                return Container(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: productController
                                          .productsSuggestion.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ProductItem(
                                            product: productController
                                                .productsSuggestion[index]);
                                      }),
                                );
                            })
                          ]),
                    ),
                  ],
                ),
              ),
            )),
          ),
          //popup
          PopUpAddress(),
        ],
      ),
    );
  }

  Future<void> _delivery() {
    storeController.setSeleted(0);

    Get.to(() => ProductsPage());
  }

  Future<void> _takeAway() {
    storeController.setSeleted(1);

    Get.to(() => ProductsPage());
  }
}
