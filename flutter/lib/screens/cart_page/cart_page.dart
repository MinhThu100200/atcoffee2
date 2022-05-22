import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/screens/cart_page/cart_item.dart';
import 'package:at_coffee/screens/products_page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/bill.dart';
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
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:location/location.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

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

  String _selectedOrder = '';

  String _selectedPayment = '';

  bool _isSaving = false;
  bool _isValidPromotion = true;
  Store _store = new Store();

  @override
  void initState() {
    super.initState();
    _selectedPayment = paymentController.paymentsList != null &&
            paymentController.paymentsList.isEmpty == false
        ? paymentController.paymentsList[0].id.toString()
        : '';
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _store = _getNearestStore();

      storeController.storeNearYou();
    });

    _selectedOrder = cartController.indexSelectedOrder.value == 0
        ? 'Mang đi'
        : 'Giao tận nơi';
  }

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
    cartController.total["amount"] = amount.toInt();
    return amount;
  }

  double _calTotalAmount(carts) {
    double amount = _calAmount(carts) - _calPromotion(carts);
    amount = amount < 0 ? 0 : amount;
    cartController.total["totalAmount"] = amount.toInt();
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
    cartController.total["quantity"] = quantity.toInt();

    return quantity;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        elevation: 0,
        bottomOpacity: 0.0,
        backgroundColor: primary,
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            child: SafeArea(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(_selectedOrder,
                                                    style: const TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w600)),
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
                                                    child: Text(cartController
                                                                .indexSelectedOrder
                                                                .value ==
                                                            0
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
                                          children: [
                                            const Text("Các sản phẩm đã chọn",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 4.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color:
                                                      primary.withOpacity(0.3),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ProductsPage());
                                                  },
                                                  child: const Text("+ Thêm",
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: primary)),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    if (cartController
                                            .cartsList.value.isEmpty ==
                                        false) ...[
                                      Container(
                                        child: ListView.builder(
                                            primary: false,
                                            itemCount:
                                                cartController.cartsList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return CartItem(
                                                  cart: cartController
                                                      .cartsList[index]);
                                            }),
                                      ),
                                    ] else ...[
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 8.0),
                                          child: const Text(
                                              'Chưa có sản phẩm nào được chọn!',
                                              style:
                                                  TextStyle(fontSize: 16.0))),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 8.0),
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
                                                Get.to(
                                                    () => PromotionCartPage());
                                              },
                                              child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                            _textSelectedPromotion(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: _isValidPromotion
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
                                                        oCcy.format(_calTotalAmount(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0,
                                                      vertical: 4.0),
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
                                                  child: Container(
                                                      width: size.width - 96,
                                                      child: Text(payment.name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0))),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cartController.isLoading.value = true;
                                    deleteCartByUserId(
                                        userController.user.value.id);
                                    cartController.isLoading.value = false;
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                  _selectedOrder +
                                      ' - ' +
                                      _calTotalQuantity(
                                              cartController.cartsList)
                                          .toString() +
                                      ' sản phẩm',
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
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
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            const BorderSide(color: purple)))))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  void _paymentOrder() {
    if (cartController.cartsList.where((c) => c.state).isEmpty == true) {
      return;
    }
    var now = DateTime.now();
    String code = 'BI' + now.millisecondsSinceEpoch.toString().substring(1, 9);

    Bill bill = Bill();
    bill.code = code;
    bill.amount = cartController.total["totalAmount"].toDouble();
    bill.price = cartController.total["amount"].toDouble();
    bill.discount = cartController.total["promotion"];
    bill.point = (bill.amount * StatusBillConstants.POINTS_REFUND).toInt();
    bill.address = cartController.indexSelectedOrder.value == 0
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
    bill.billDetails = List<BillDetail>();
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

    FireBaseService.addBill(bill);
  }

  void deleteCartByUserId(int userId) async {
    cartController.deleteCartByUserId(userId);
    cartController.promotion.value = new Promotion();
    cartController.reward.value = new Reward();
    cartController.type.value = 0;
  }

  void _showModelButtonSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 260.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0))),
                child: Scaffold(
                  appBar: AppBar(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    )),
                    title: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Chọn phương thức đặt hàng',
                        style: TextStyle(color: black),
                      ),
                    ),
                    backgroundColor: white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                  ),
                  body: Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartController.isLoading.value = true;
                            cartController.indexSelectedOrder.value = 1;
                            _selectedOrder = 'Giao tận nơi';
                            cartController.isLoading.value = false;
                            Navigator.pop(context);
                          },
                          child: Card(
                              color:
                                  cartController.indexSelectedOrder.value == 1
                                      ? const Color(0xfffef7e4)
                                      : white,
                              child: Row(
                                children: [
                                  Container(
                                    height: 80.0,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                        'assets/icons/delivery-man.png'),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      width: MediaQuery.of(context).size.width -
                                          100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: 20.0,
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Giao hàng',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.0),
                                              )),
                                          Container(
                                            height: 20.0,
                                            alignment: Alignment.centerLeft,
                                            child: Obx(() {
                                              if (storeController
                                                  .isLoading.value) {
                                                return const Text(
                                                    "đang định vị, vị trí của bạn...",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16.0));
                                              } else {
                                                return Text(
                                                    storeController
                                                        .myAddress.value,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16.0));
                                              }
                                            }),
                                          ),
                                          Container(
                                              height: 20.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '0 km - ' +
                                                    userController
                                                        .user.value.name +
                                                    ' - ' +
                                                    userController
                                                        .user.value.phone,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17.0),
                                              )),
                                        ],
                                      ))
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartController.isLoading.value = true;
                            cartController.indexSelectedOrder.value = 0;
                            _selectedOrder = 'Tự đến lấy';
                            cartController.isLoading.value = false;
                            Navigator.pop(context);
                          },
                          child: Card(
                              color:
                                  cartController.indexSelectedOrder.value == 0
                                      ? const Color(0xfffef7e4)
                                      : white,
                              child: Row(
                                children: [
                                  Container(
                                    height: 80.0,
                                    width: 80.0,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                        'assets/images/strawberry-background.png'),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      width: MediaQuery.of(context).size.width -
                                          100.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                              height: 20.0,
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Mang đi',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18.0),
                                              )),
                                          Container(
                                              height: 20.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                _store.address,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16.0),
                                              )),
                                          Container(
                                              height: 20.0,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Cách đây ' +
                                                    _getDistance(
                                                            _store.latitude,
                                                            _store.longitude)
                                                        .toString() +
                                                    ' km',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 17.0),
                                              )),
                                        ],
                                      ))
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
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

  Store _getNearestStore() {
    int _min = 2000000000;
    Store nearestStore = new Store();
    storeController.storesList.forEach((store) {
      int _distance = _getDistance(store.latitude, store.longitude);
      if (_distance < _min) {
        _min = _distance;
        nearestStore = store;
      }
    });

    return nearestStore;
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
  PromotionCartPage({Key key}) : super(key: key);

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
              Expanded(child: Text("Khuyến mãi của bạn")),
              GestureDetector(
                  onTap: () {
                    _cancelApply();
                  },
                  child: Text('Hủy'))
            ],
          ),
          backgroundColor: primary,
          elevation: 0,
          bottomOpacity: 0,
        ),
        body: SafeArea(
            child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Obx(() {
                    if (promotionController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                promotionController.promotionsList.length,
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
                                                  child: Container(
                                                    height: 90,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                                promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .description,
                                                                maxLines: 4,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: _validPromotion(promotionController.promotionsList[
                                                                            index])
                                                                        ? black
                                                                        : Colors
                                                                            .grey[500]))),
                                                        Expanded(
                                                            child: Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15.0,
                                                                        bottom:
                                                                            15),
                                                                child: Text(
                                                                    'Hết hạn ' +
                                                                        new DateFormat('dd/MM/yyyy')
                                                                            .format(DateTime.fromMillisecondsSinceEpoch((promotionController.promotionsList[index].endDate)
                                                                                .toInt()))
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: _validPromotion(promotionController.promotionsList[index])
                                                                            ? black
                                                                            : Colors.grey[500])))),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Card(
                                              margin: const EdgeInsets.only(
                                                  left: 1.0),
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
                                                                  .promotionsList[
                                                              index])
                                                      ? lightYellow
                                                      : Colors.grey[400],
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4.0,
                                                            vertical: 4.0),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 2.0,
                                                                vertical: 4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                          color: _validPromotion(
                                                                  promotionController
                                                                          .promotionsList[
                                                                      index])
                                                              ? Color(
                                                                  0xffe5b06c)
                                                              : Colors
                                                                  .grey[500],
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .coffee_sharp,
                                                                size: 11,
                                                                color: black),
                                                            Container(
                                                              child: Text(
                                                                  "A&T Coffee",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color:
                                                                          white)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Text(
                                                            promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .discount
                                                                    .toString() +
                                                                "%",
                                                            style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: white)),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            }),
                      );
                  }),
                ),
                Container(
                  child: Obx(() {
                    if (promotionController.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else
                      return Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: rewardController.rewardsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_validReward(
                                      rewardController.rewardsList[index])) {
                                    _applyReward(
                                        rewardController.rewardsList[index]);
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
                                            child: Container(
                                              height: 90,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 15),
                                                      child: Text(
                                                          rewardController
                                                              .rewardsList[
                                                                  index]
                                                              .name,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: _validReward(
                                                                      rewardController
                                                                              .rewardsList[
                                                                          index])
                                                                  ? black
                                                                  : Colors.grey[
                                                                      500]))),
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
                                            color: _validReward(rewardController
                                                    .rewardsList[index])
                                                ? lightYellow
                                                : Colors.grey[400],
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 4.0),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    color: _validReward(
                                                            rewardController
                                                                    .rewardsList[
                                                                index])
                                                        ? Color(0xffe5b06c)
                                                        : Colors.grey[500],
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(Icons.coffee_sharp,
                                                          size: 11,
                                                          color: black),
                                                      Container(
                                                        child: Text(
                                                            "A&T Coffee",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: white)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                      (rewardController
                                                                      .rewardsList[
                                                                          index]
                                                                      .redution ~/
                                                                  1000)
                                                              .toString() +
                                                          'K',
                                                      style: TextStyle(
                                                          fontSize: 35,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white)),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                  }),
                )
              ],
            ),
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
    cartController.promotion.value = promotion;
    cartController.type.value = 1;
    Navigator.pop(context);
  }

  void _applyReward(Reward reward) {
    cartController.reward.value = reward;
    cartController.type.value = 2;
    Navigator.pop(context);
  }

  void _cancelApply() {
    cartController.promotion.value = new Promotion();
    cartController.reward.value = new Reward();
    cartController.type.value = 0;
    Navigator.pop(context);
  }
}
