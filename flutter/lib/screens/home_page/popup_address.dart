import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/screens/location_page/location_store.dart';
import 'package:at_coffee/screens/location_page/address_delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/common/theme/colors.dart';

class PopUpAddress extends StatefulWidget {
  PopUpAddress({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _PopUpAddress createState() => _PopUpAddress();
}

class _PopUpAddress extends State<PopUpAddress> {
  final ProductController productController = Get.put(ProductController());
  final StoreController storeController = Get.put(StoreController());
  final UserController userController = Get.put(UserController());
  var wayTitle = ["Giao tận nơi", "Tự đến lấy"];
  var wayImage = [
    'assets/icons/delivery-man.png',
    'assets/images/strawberry-background.png'
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (storeController.myAddress.value != "") {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.only(left: 16, top: 5),
                              child: Text("Chọn phương thức giao hàng",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 10),
                                    child:
                                        Icon(Icons.close_rounded, size: 25))),
                          ]),
                      Container(
                        color: Colors.grey[200],
                        width: size.width,
                        child: SizedBox(height: 0.5),
                      ),
                      Obx(() {
                        if (productController.isLoading.value)
                          return Center(child: CircularProgressIndicator());
                        else
                          return Container(
                            //padding: const EdgeInsets.only(left: 10),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: wayTitle.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    child: GestureDetector(
                                      onTap: () =>
                                          storeController.setSeleted(index),
                                      child: Obx(
                                        () => Container(
                                            color: storeController
                                                        .selected.value ==
                                                    index
                                                ? greenTransparent
                                                : white,
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 16, bottom: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: lightGreen3,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Container(
                                                        height: 26,
                                                        width: 26,
                                                        child: Image.asset(
                                                            wayImage[index]))),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          child: Text(
                                                              wayTitle[index],
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500))),
                                                      FittedBox(
                                                        child: Container(
                                                          width:
                                                              size.width - 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          // height: 50,
                                                          child: Text(
                                                              wayTitle[index] ==
                                                                      "Giao tận nơi"
                                                                  ? storeController
                                                                      .myAddress
                                                                      .value
                                                                  : "A&T Coffee, " +
                                                                      storeController
                                                                          .storeNearYou
                                                                          .value
                                                                          .address,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey[600],
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ),
                                                      FittedBox(
                                                        child: Container(
                                                          width:
                                                              size.width - 150,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          // height: 50,
                                                          child: Text(
                                                              wayTitle[index] ==
                                                                      "Giao tận nơi"
                                                                  ? userController
                                                                          .user
                                                                          .value
                                                                          .name +
                                                                      " " +
                                                                      userController
                                                                          .user
                                                                          .value
                                                                          .phone
                                                                  : "Cách đây khoảng " +
                                                                      storeController
                                                                          .storeMinDistance
                                                                          .toString() +
                                                                      "km",
                                                              style: TextStyle(
                                                                // color: Colors.lightBlueAccent,
                                                                fontSize: 13,

                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        color: primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: InkWell(
                                                        onTap: () {
                                                          if (index == 1)
                                                            Get.to(() =>
                                                                LocationStore());
                                                          else {
                                                            Get.to(() =>
                                                                AddressDelivery());
                                                          }
                                                        },
                                                        child: Text("Sửa"))),
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                }),
                          );
                      })
                    ],
                  ));
            },
          );
        }
      },
      child: Container(
          width: size.width,
          padding:
              const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
          color: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: lightGreen2,
                          borderRadius: BorderRadius.circular(14)),
                      height: 20,
                      padding: const EdgeInsets.all(3),
                      child: Image.asset('assets/icons/delivery-man.png')),
                  SizedBox(width: 5),
                  Text("Giao đến",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gray3))
                ],
              ),
              SizedBox(height: 6),
              Obx(() {
                if (storeController.isLoading.value ||
                    storeController.myAddress.value == '') {
                  return Text("Đang định vị vị trí của bạn...",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13));
                } else {
                  storeController.myStoreNearYou();
                  return Text(storeController.myAddress.value,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13));
                }
              })
            ],
          )),
    );
  }
}
