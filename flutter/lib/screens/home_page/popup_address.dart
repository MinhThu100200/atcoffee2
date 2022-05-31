import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/screens/cart_page/cart_page.dart';
import 'package:at_coffee/screens/location_page/location_store.dart';
import 'package:at_coffee/screens/location_page/address_delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/constant/variable_constants.dart';

class PopUpAddress extends StatefulWidget {
  const PopUpAddress({Key key}) : super(key: key);

  @override
  _PopUpAddress createState() => _PopUpAddress();
}

class _PopUpAddress extends State<PopUpAddress> {
  final ProductController productController = Get.put(ProductController());
  final StoreController storeController = Get.put(StoreController());
  final UserController userController = Get.put(UserController());
  final CartController cartController = Get.put(CartController());
  final typeController = Get.put(TypeController());
  var wayTitle = ["Giao tận nơi", "Tự đến lấy"];
  var wayImage = [
    'assets/icons/delivery-man.png',
    'assets/images/strawberry-background.png'
  ];
  var total = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      cartController.calTotalAmounts();
      print("Build Completed:" + userController.user.value.id.toString());
    });
  }

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
                  width: size.width,
                  decoration: const BoxDecoration(
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
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: const Text("Chọn phương thức giao hàng",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 10),
                                    child: const Icon(Icons.close_rounded,
                                        size: 25))),
                          ]),
                      Container(
                        color: Colors.grey[200],
                        //width: size.width,
                        child: const SizedBox(height: 0.5),
                      ),
                      Obx(() {
                        if (productController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: wayTitle.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () =>
                                      storeController.setSeleted(index),
                                  child: Obx(
                                    () => Container(
                                        color: storeController.selected.value ==
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
                                                        BorderRadius.circular(
                                                            25)),
                                                child: SizedBox(
                                                    height: 26,
                                                    width: 26,
                                                    child: Image.asset(
                                                        wayImage[index]))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(wayTitle[index],
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  FittedBox(
                                                    child: Container(
                                                      width: size.width - 140,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
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
                                                                FontWeight.w400,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ),
                                                  FittedBox(
                                                    child: Container(
                                                      width: size.width - 150,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
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
                                                          style:
                                                              const TextStyle(
                                                            // color: Colors.lightBlueAccent,
                                                            fontSize: 13,

                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
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
                                                        BorderRadius.circular(
                                                            14)),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      if (index == 0) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const AddressDelivery()));
                                                      } else {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const LocationStore()));
                                                      }
                                                    },
                                                    child: const Text("Sửa"))),
                                          ],
                                        )),
                                  ),
                                );
                              });
                        }
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
          child: Row(
            children: [
              Expanded(
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
                            child:
                                Image.asset('assets/icons/delivery-man.png')),
                        const SizedBox(width: 5),
                        Obx(
                          () => Text(wayTitle[storeController.selected.value],
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray3)),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Obx(() {
                      if (storeController.isLoading.value ||
                          storeController.myAddress.value == '') {
                        return const Text("Đang định vị vị trí của bạn...",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13));
                      } else {
                        storeController.myStoreNearYou();
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                  storeController.selected.value == 0
                                      ? storeController.myAddress.value
                                      : storeController
                                          .storeNearYou.value.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ),
                          ],
                        );
                      }
                    })
                  ],
                ),
              ),
              Obx(() {
                if (cartController.isLoading.value ||
                    cartController.cartsList.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: const Text(""));
                } else {
                  return GestureDetector(
                    onTap: () => Get.to(() => const CartPage()),
                    child: Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                  "${cartFromJson(cartToJson(cartController.cartsList.where((c) => c.state).toList())).reduce((value, element) {
                                    value.quantity += element.quantity;
                                    return value;
                                  }).quantity}",
                                  style: const TextStyle(
                                      color: primary, fontSize: 12.0)),
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  MethodConstants.oCcy.format(
                                      calTotalAmount(cartController.cartsList)),
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                )),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: white,
                                  size: 12.0,
                                ))
                          ],
                        )),
                  );
                }
              }),
            ],
          )),
    );
  }

  bool _validPromotion(Promotion promotion) {
    if (promotion.proviso > cartController.total["amount"]) {
      return false;
    }

    if (userController.user.value.typeId == null ||
        userController.user.value.typeId <
            typeController.typesList
                .firstWhere((type) => type.code == promotion.object)
                .id) {
      return false;
    }
    return true;
  }

  double _calAmount(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    double amount = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        amount += (carts[i]
                        .product
                        .sizes[carts[i].size == 'S'
                            ? 0
                            : carts[i].size == 'M'
                                ? 1
                                : 2]
                        .price *
                    (1 - carts[i].product.discount / 100))
                .toInt() *
            carts[i].quantity;
      }
    }
    //total["amount"] = amount.toInt();
    return amount;
  }

  double _calPromotion(carts) {
    if (carts == null || carts.length == 0) {
      //total["promotion"] = 0.toInt();
      return 0;
    }
    double promotionValue = 0;

    switch (cartController.type.value) {
      case 0:
        break;
      case 1:
        if (_validPromotion(cartController.promotion.value)) {
          promotionValue = cartController.total["amount"] *
              cartController.promotion.value.discount /
              100;
        }
        break;
      case 2:
        if (_validReward(cartController.reward.value)) {
          promotionValue = cartController.reward.value.redution.toDouble();
        }
        break;
    }
    //total["promotion"] = promotionValue.toInt();
    return promotionValue;
  }

  bool _validReward(Reward reward) {
    if (userController.user.value.currentPoints < reward.proviso) {
      return false;
    }
    return true;
  }

  double calTotalAmount(carts) {
    //isLoading.value = true;
    double amounts = _calAmount(carts) - _calPromotion(carts);
    amounts = amounts < 0 ? 0 : amounts;
    //total["totalAmount"] = amounts.toInt();
    //isLoading.value = false;
    //amount.value = amounts;
    return amounts;
  }
}
