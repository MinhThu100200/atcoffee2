import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/screens/cart_page/cart_item.dart';
import 'package:at_coffee/screens/manage_order_page/manage_order_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/Bill.dart';
import 'package:at_coffee/models/bill_detail.dart';
import 'package:at_coffee/models/payment.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/payment_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/reward_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';
import 'package:at_coffee/controllers/promotion_controller.dart';
import 'package:at_coffee/services/service_firebase.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/constant/variable_constants.dart';
import 'package:at_coffee/screens/location_page/location_store.dart';
import 'package:at_coffee/screens/location_page/address_delivery.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPage createState() => _CartPage();
}

class _CartPage extends State<CartPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

  final TypeController typeController = Get.put(TypeController());
  final CartController cartController = Get.put(CartController());
  final PaymentController paymentController = Get.put(PaymentController());
  final UserController userController = Get.put(UserController());
  final StoreController storeController = Get.put(StoreController());
  final PromotionController promotionController =
      Get.put(PromotionController());

  var wayTitle = ["Giao tận nơi", "Tự đến lấy"];
  var wayImage = [
    'assets/icons/delivery-man.png',
    'assets/images/strawberry-background.png'
  ];

  String _selectedPayment = '';

  bool _isSaving = false;
  bool _isValidPromotion = true;

  @override
  void initState() {
    super.initState();
    _selectedPayment = paymentController.paymentsList != null &&
            paymentController.paymentsList.isEmpty == false
        ? paymentController.paymentsList[0].id.toString()
        : '';
  }
//check here
  double _calPromotion(carts) {
    if (carts == null || carts.length == 0) {
      cartController.total["promotion"] = 0.toInt();
      return 0;
    }
    _isValidPromotion = true;

    double promotionValue = 0;

    switch (cartController.type.value) {
      case 0:
        break;
      case 1:
        Promotion promotion = cartController.promotion.value;
        if (_validPromotion(promotion)) {
          
          promotionValue =
              cartController.total["amount"] * promotion.discount / 100;
        } else {
          _isValidPromotion = false;
        }
        break;
      case 2:
        Reward reward = cartController.reward.value;
        if (_validReward(reward)) {
          promotionValue = reward.redution.toDouble();
        } else {
          _isValidPromotion = false;
        }
        break;
    }
    //check here
    cartController.total["promotion"] = promotionValue.toInt();
    return promotionValue;
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
    //check here
    cartController.total["amount"] = amount.toInt();
    print("_calAmount" +
        cartController.total["amount"].toString() +
        amount.toInt().toString());
    return amount;
  }

  double _calTotalAmount(carts) {
    double amount = _calAmount(carts) - _calPromotion(carts);
    amount = amount < 0 ? 0 : amount;
    //check here
    cartController.total["totalAmount"] = amount.toInt();
    print("_calTotalAmount" +
        cartController.total["totalAmount"].toString() +
        amount.toInt().toString());
    return amount;
  }

  int _calTotalQuantity(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    int quantity = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        quantity += carts[i].quantity;
      }
    }
    //check here
    cartController.total["quantity"] = quantity.toInt();

    return quantity;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng"),
        elevation: 0,
        bottomOpacity: 0.0,
        backgroundColor: primary,
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Positioned(
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 24.0,
                                    right: 22.0,
                                    top: 8.0,
                                    bottom: 8.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Obx(() {
                                                return Text(
                                                    wayTitle[storeController
                                                        .selected.value],
                                                    style: const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w600));
                                              }),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: primary
                                                        .withOpacity(0.3),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _showModelButtonSheet(
                                                          context);
                                                    },
                                                    child: const Text(
                                                        "Thay đổi",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: primary)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                  child: Text(storeController
                                                              .selected.value ==
                                                          1
                                                      ? storeController
                                                          .storeNearYou
                                                          .value
                                                          .address
                                                      : storeController
                                                          .myAddress.value))
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Column(children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 24.0,
                                        right: 22.0,
                                        top: 16.0,
                                        bottom: 0.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("Các sản phẩm đã chọn",
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600)),
                                          // GestureDetector(
                                          //   onTap: () {},
                                          //   child: Container(
                                          //     padding:
                                          //         const EdgeInsets.symmetric(
                                          //             horizontal: 10.0,
                                          //             vertical: 4.0),
                                          //     decoration: BoxDecoration(
                                          //       borderRadius:
                                          //           BorderRadius.circular(
                                          //               10.0),
                                          //       color:
                                          //           primary.withOpacity(0.3),
                                          //     ),
                                          //     child: GestureDetector(
                                          //       onTap: () {
                                          //         Get.to(
                                          //             () => ProductsPage());
                                          //       },
                                          //       child: const Text("+ Thêm",
                                          //           style: TextStyle(
                                          //               fontSize: 16.0,
                                          //               color: primary)),
                                          //     ),
                                          //   ),
                                          // ),
                                        ]),
                                  ),
                                  if (cartController.cartsList.isEmpty ==
                                      false) ...[
                                    ListView.builder(
                                        primary: false,
                                        itemCount:
                                            cartController.cartsList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CartItem(
                                              cart: cartController
                                                  .cartsList[index]);
                                        }),
                                  ] else ...[
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 8.0),
                                        child: const Text(
                                            'Chưa có sản phẩm nào được chọn!',
                                            style: TextStyle(fontSize: 16.0))),
                                  ]
                                ]),
                              ),
                              Card(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 8.0),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Tổng cộng",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Thành tiền',
                                                      style: TextStyle(
                                                          fontSize: 16.0)),
                                                  Text(
                                                      oCcy.format(_calAmount(
                                                              cartController
                                                                  .cartsList)
                                                          .toInt()),
                                                      style: const TextStyle(
                                                          fontSize: 16.0))
                                                ],
                                              )),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 0.0),
                                              child: const Divider()),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Giảm giá',
                                                      style: TextStyle(
                                                          fontSize: 16.0)),
                                                  Text(
                                                      oCcy.format(_calPromotion(
                                                              cartController
                                                                  .cartsList)
                                                          .toInt()),
                                                      style: const TextStyle(
                                                          fontSize: 16.0))
                                                ],
                                              )),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 0.0),
                                              child: const Divider()),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() =>
                                                  const PromotionCartPage());
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0,
                                                        vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          _textSelectedPromotion(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  _isValidPromotion
                                                                      ? lightBlue
                                                                      : red)),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_right_outlined,
                                                      color: lightBlue,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 0.0),
                                              child: const Divider()),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('Tổng tiền',
                                                      style: TextStyle(
                                                          fontSize: 16.0)),
                                                  Text(
                                                      oCcy.format(
                                                          _calTotalAmount(
                                                                  cartController
                                                                      .cartsList)
                                                              .toInt()),
                                                      style: const TextStyle(
                                                          fontSize: 16.0))
                                                ],
                                              )),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 0.0),
                                              child: const Divider()),
                                        ],
                                      ))),
                              Card(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 4.0),
                                            alignment: Alignment.centerLeft,
                                            child: const Text("Thanh toán",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 2.0),
                                          alignment: Alignment.centerLeft,
                                          child: DropdownButton<String>(
                                            value: _selectedPayment ?? '',
                                            iconSize: 30.0,
                                            onChanged: (newValue) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (_) => setState(() {
                                                            _selectedPayment =
                                                                newValue;
                                                          }));
                                            },
                                            items: paymentController
                                                .paymentsList
                                                .map((Payment payment) {
                                              return DropdownMenuItem<String>(
                                                value: payment.id.toString(),
                                                child: SizedBox(
                                                    width: size.width - 96,
                                                    child: Text(payment.name,
                                                        style: const TextStyle(
                                                            fontSize: 16.0))),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //cartController.isLoading.value = true;
                                  deleteCartByUserId(
                                      userController.user.value.id);
                                  //cartController.isLoading.value = false;
                                },
                                child: Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 12.0),
                                    child: Row(children: [
                                      Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: const Icon(
                                              Icons.delete_outline,
                                              color: red,
                                              size: 18.0)),
                                      const Text("Xóa giỏ hàng",
                                          style: TextStyle(
                                              color: red, fontSize: 16.0))
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isSaving == true) ...[
                          Positioned(
                            child: Container(
                              width: size.width,
                              height: size.height - 86.0,
                              color: Colors.grey.withOpacity(0.3),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                Container(
                  color: primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                                wayTitle[storeController.selected.value] +
                                    ' - ' +
                                    _calTotalQuantity(cartController.cartsList)
                                        .toString() +
                                    ' sản phẩm',
                                style: const TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                                oCcy.format(
                                    _calTotalAmount(cartController.cartsList)
                                        .toInt()),
                                style: const TextStyle(
                                    color: white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ]),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _paymentOrder();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: const Text('Đặt hàng',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(purple),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: purple)))))
                    ],
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }

  void _paymentOrder() async {
    if (cartController.cartsList.where((c) => c.state).isEmpty == true) {
      Fluttertoast.showToast(
          msg: "Chưa có sản phẩm được chọn",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: googleColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    //cartController.isLoading.value = true;

    String token = await FirebaseMessaging.instance.getToken();

    var now = DateTime.now();
    String code = 'BI' + now.millisecondsSinceEpoch.toString().substring(1, 9);

    Bill bill = Bill();
    bill.code = code;
    bill.amount = cartController.total["totalAmount"].toDouble();
    bill.price = cartController.total["amount"].toDouble();
    bill.discount = cartController.total["promotion"];
    bill.point = (bill.amount * StatusBillConstants.POINTS_REFUND).toInt();
    bill.address = storeController.selected.value == 1
        ? storeController.storeNearYou.value.address
        : storeController.myAddress.value;
    bill.status = StatusBillConstants.REQUESTED;
    bill.rewardId =
        cartController.type.value == 2 ? cartController.reward.value.id : 0;
    bill.promotionId = cartController.type.value == 1 && _isValidPromotion
        ? cartController.promotion.value.id
        : 0;
    bill.promotionCode = cartController.type.value == 1 && _isValidPromotion
        ? cartController.promotion.value.code
        : '';
    bill.paymentId = _selectedPayment != '' ? int.parse(_selectedPayment) : 0;
    bill.paymentName = paymentController.paymentsList
        .firstWhere((p) => p.id == int.parse(_selectedPayment))
        .name;
    bill.storeId = storeController.storeNearYou.value.id;
    bill.staffId = 0;
    bill.staffName = '';
    bill.customerId = userController.user.value.id;
    bill.customerName = userController.user.value.name;

    int count = 1;
    bill.billDetails = <BillDetail>[];
    cartController.cartsList.where((c) => c.state == true).forEach((c) {
      double priceItem =
          c.product.sizes.firstWhere((element) => element.size == c.size).price;
      BillDetail billDetail = BillDetail();

      billDetail.code = code + 'D' + (count++).toString();
      billDetail.quantity = c.quantity;
      billDetail.description = c.description;
      billDetail.amount = priceItem * (1 - c.product.discount / 100);
      billDetail.price = priceItem;
      billDetail.size = c.size;
      billDetail.discount = c.product.discount;
      billDetail.productId = c.productId;
      bill.billDetails.add(billDetail);
    });
    bill.createdDate = DateTime.now().millisecondsSinceEpoch;
    bill.state = true;
    bill.read = false;
    bill.token = token;

    await FireBaseService.addBill(bill);

    await cartController.deleteCartPayment();

    //cartController.isLoading.value = false;

    Fluttertoast.showToast(
        msg: "Đặt hàng thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primary,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ManageOrderPage()));
    //Get.to(() => ManageOrderPage());
  }

  void deleteCartByUserId(int userId) async {
    cartController.deleteCartByUserId(userId);
    //check here
    cartController.promotion.value = Promotion();
    //check here
    cartController.reward.value = Reward();
    //check here
    cartController.type.value = 0;
  }

  void _showModelButtonSheet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            height: 200,
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
                        padding: const EdgeInsets.only(left: 16, top: 5),
                        child: const Text("Chọn phương thức giao hàng",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              padding: const EdgeInsets.only(top: 5, right: 10),
                              child:
                                  const Icon(Icons.close_rounded, size: 25))),
                    ]),
                Container(
                  color: Colors.grey[200],
                  width: size.width,
                  child: const SizedBox(height: 0.5),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wayTitle.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => storeController.setSeleted(index),
                        child: Obx(
                          () => Container(
                              color: storeController.selected.value == index
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
                                              BorderRadius.circular(25)),
                                      child: SizedBox(
                                          height: 26,
                                          width: 26,
                                          child: Image.asset(wayImage[index]))),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(wayTitle[index],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        FittedBox(
                                          child: Container(
                                            width: size.width - 140,
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            // height: 50,
                                            child: Text(
                                                wayTitle[index] ==
                                                        "Giao tận nơi"
                                                    ? storeController
                                                        .myAddress.value
                                                    : "A&T Coffee, " +
                                                        storeController
                                                            .storeNearYou
                                                            .value
                                                            .address,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            width: size.width - 150,
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            // height: 50,
                                            child: Text(
                                                wayTitle[index] ==
                                                        "Giao tận nơi"
                                                    ? userController
                                                            .user.value.name +
                                                        " " +
                                                        userController
                                                            .user.value.phone
                                                    : "Cách đây khoảng " +
                                                        storeController
                                                            .storeMinDistance
                                                            .toString() +
                                                        "km",
                                                style: const TextStyle(
                                                  // color: Colors.lightBlueAccent,
                                                  fontSize: 13,

                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: primary,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: GestureDetector(
                                          onTap: () {
                                            if (index == 1) {
                                              Get.to(() => LocationStore());
                                            } else {
                                              Get.to(() =>
                                                  const AddressDelivery());
                                            }
                                          },
                                          child: const Text("Sửa"))),
                                ],
                              )),
                        ),
                      );
                    }),
              ],
            ));
      },
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

  bool _validReward(Reward reward) {
    if (userController.user.value.currentPoints < reward.proviso) {
      return false;
    }
    return true;
  }

  String _textSelectedPromotion() {
    if (cartController.type.value == 0) {
      return 'Chọn mã khuyến mãi';
    }

    if (cartController.type.value == 1) {
      return cartController.promotion.value.description;
    }

    if (cartController.type.value == 2) {
      return cartController.reward.value.name;
    }

    return '';
  }

  int _getDistance(double lat, double long) {
    double distanceInMeters = 0;
    if (lat == 0 ||
        long == 0 ||
        storeController.latitude.value == 0 ||
        storeController.longitude.value == 0) return 0;

    distanceInMeters = (Geolocator.distanceBetween(
                storeController.latitude.value,
                storeController.longitude.value,
                lat,
                long) +
            1000) /
        1000;

    return distanceInMeters.round();
  }
}

class PromotionCartPage extends StatefulWidget {
  const PromotionCartPage({Key key}) : super(key: key);

  @override
  _PromotionCartPage createState() => _PromotionCartPage();
}

class _PromotionCartPage extends State<PromotionCartPage> {
  final PromotionController promotionController =
      Get.put(PromotionController());
  final RewardController rewardController = Get.put(RewardController());
  final CartController cartController = Get.put(CartController());
  final UserController userController = Get.put(UserController());
  final TypeController typeController = Get.put(TypeController());

  @override
  void initState() {
    typeController.fetchTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(
          title: Row(
            children: [
              const Expanded(child: Text("Khuyến mãi của bạn")),
              GestureDetector(
                  onTap: () {
                    _cancelApply();
                  },
                  child: const Text('Hủy'))
            ],
          ),
          backgroundColor: primary,
          elevation: 0,
          bottomOpacity: 0,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                if (promotionController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: promotionController.promotionsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return checkExpired(
                                promotionController.promotionsList[index])
                            ? GestureDetector(
                                onTap: () {
                                  if (_validPromotion(promotionController
                                      .promotionsList[index])) {
                                    _applyPromotion(promotionController
                                        .promotionsList[index]);
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                            margin: const EdgeInsets.only(
                                                right: 1.0),
                                            child: SizedBox(
                                              height: 90,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 15),
                                                      child: Text(
                                                          promotionController
                                                              .promotionsList[
                                                                  index]
                                                              .description,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: _validPromotion(
                                                                      promotionController
                                                                              .promotionsList[
                                                                          index])
                                                                  ? black
                                                                  : Colors.grey[
                                                                      500]))),
                                                  Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  left: 15,
                                                                  right: 15.0,
                                                                  bottom: 15),
                                                          child: Text(
                                                              'Hết hạn ' +
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .format(DateTime.fromMillisecondsSinceEpoch(
                                                                          (promotionController.promotionsList[index].endDate)
                                                                              .toInt()))
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: _validPromotion(promotionController.promotionsList[index])
                                                                      ? black
                                                                      : Colors
                                                                          .grey[500])))),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Card(
                                        margin:
                                            const EdgeInsets.only(left: 1.0),
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            height: 70,
                                            width: 70,
                                            color: _validPromotion(
                                                    promotionController
                                                        .promotionsList[index])
                                                ? lightYellow
                                                : Colors.grey[400],
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 4.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    color: _validPromotion(
                                                            promotionController
                                                                    .promotionsList[
                                                                index])
                                                        ? const Color(
                                                            0xffe5b06c)
                                                        : Colors.grey[500],
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons.coffee_sharp,
                                                          size: 10,
                                                          color: black),
                                                      Text("A&T Coffee",
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color: white)),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    promotionController
                                                            .promotionsList[
                                                                index]
                                                            .discount
                                                            .toString() +
                                                        "%",
                                                    style: const TextStyle(
                                                        fontSize: 33,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: white))
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      });
                }
              }),
              Obx(() {
                if (rewardController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rewardController.rewardsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (_validReward(
                                rewardController.rewardsList[index])) {
                              _applyReward(rewardController.rewardsList[index]);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Card(
                                      margin: const EdgeInsets.only(right: 1.0),
                                      child: SizedBox(
                                        height: 90,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Text(
                                                    rewardController
                                                        .rewardsList[index]
                                                        .name,
                                                    maxLines: 4,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: _validReward(
                                                                rewardController
                                                                        .rewardsList[
                                                                    index])
                                                            ? black
                                                            : Colors
                                                                .grey[500]))),
                                          ],
                                        ),
                                      )),
                                ),
                                Card(
                                  margin: const EdgeInsets.only(left: 1.0),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0,
                                          left: 10.0,
                                          right: 10.0),
                                      height: 70,
                                      width: 70,
                                      color: _validReward(rewardController
                                              .rewardsList[index])
                                          ? lightYellow
                                          : Colors.grey[400],
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0, vertical: 4.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2.0, vertical: 4.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.0),
                                              color: _validReward(
                                                      rewardController
                                                          .rewardsList[index])
                                                  ? const Color(0xffe5b06c)
                                                  : Colors.grey[500],
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.coffee_sharp,
                                                    size: 10, color: black),
                                                Text("A&T Coffee",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: white)),
                                              ],
                                            ),
                                          ),
                                          Text(
                                              (rewardController
                                                              .rewardsList[
                                                                  index]
                                                              .redution ~/
                                                          1000)
                                                      .toString() +
                                                  'K',
                                              style: const TextStyle(
                                                  fontSize: 33,
                                                  fontWeight: FontWeight.w700,
                                                  color: white))
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              })
            ],
          ),
        )));
  }

  bool checkExpired(item) {
    int milis = DateTime.now().millisecondsSinceEpoch;
    print(item.endDate.toString() + ' ' + milis.toString());
    if (item.endDate > milis) {
      return true;
    }
    return false;
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

  bool _validReward(Reward reward) {
    if (userController.user.value.currentPoints < reward.proviso) {
      return false;
    }
    return true;
  }

  void _applyPromotion(Promotion promotion) {
    //check here
    cartController.promotion.value = promotion;
    //check here
    cartController.type.value = 1;
    Navigator.pop(context);
  }

  void _applyReward(Reward reward) {
    //check here
    cartController.reward.value = reward;
    //check here
    cartController.type.value = 2;
    Navigator.pop(context);
  }

  void _cancelApply() {
    //check here
    cartController.promotion.value = Promotion();
    //check here
    cartController.reward.value = Reward();
    //check here
    cartController.type.value = 0;
    Navigator.pop(context);
  }
}
