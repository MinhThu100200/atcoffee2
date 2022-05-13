import 'package:at_coffee/screens/cart_page/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/models/payment.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/payment_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/common/theme/colors.dart';
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

  final CartController cartController = Get.put(CartController());
  final PaymentController paymentController = Get.put(PaymentController());
  final UserController userController = Get.put(UserController());
  final StoreController storeController = Get.put(StoreController());

  String _selectedOrder = 'Mang đi';
  int _indexSelectedOrder = 0;

  String _selectedPayment = '';

  bool _isSaving = false;

  Store _store = new Store();

  @override
  void initState() {
    super.initState();
    _store = _getNearestStore();
    _selectedPayment = paymentController.paymentsList != null &&
            paymentController.paymentsList.length > 0
        ? paymentController.paymentsList[0].id.toString()
        : '';
  }

  double _calPromotion(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    double amount = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        amount += carts[i]
                .product
                .sizes[carts[i].size == 'S'
                    ? 0
                    : carts[i].size == 'M'
                        ? 1
                        : 2]
                .price *
            (carts[i].product.discount / 100);
      }
    }
    return amount;
  }

  double _calAmount(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    double amount = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        amount += carts[i]
                .product
                .sizes[carts[i].size == 'S'
                    ? 0
                    : carts[i].size == 'M'
                        ? 1
                        : 2]
                .price *
            carts[i].quantity;
      }
    }
    return amount;
  }

  double _calTotalAmount(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    double amount = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        amount += carts[i]
                .product
                .sizes[carts[i].size == 'S'
                    ? 0
                    : carts[i].size == 'M'
                        ? 1
                        : 2]
                .price *
            carts[i].quantity *
            (1 - carts[i].product.discount / 100);
        ;
      }
    }
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
                                  child: Column(children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 24.0,
                                          right: 24.0,
                                          top: 16.0,
                                          bottom: 0.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Các sản phẩm đã chọn",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Text("+ Thêm",
                                                  style: TextStyle(
                                                      fontSize: 22.0)),
                                            ),
                                          ]),
                                    ),
                                    if (cartController.cartsList.length >
                                        0) ...[
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
                                                  TextStyle(fontSize: 18.0))),
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
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                                            fontSize: 18.0)),
                                                    Text(
                                                        oCcy.format(_calAmount(
                                                                cartController
                                                                    .cartsList)
                                                            .toInt()),
                                                        style: const TextStyle(
                                                            fontSize: 18.0))
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
                                                            fontSize: 18.0)),
                                                    Text(
                                                        oCcy.format(_calPromotion(
                                                                cartController
                                                                    .cartsList)
                                                            .toInt()),
                                                        style: const TextStyle(
                                                            fontSize: 18.0))
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
                                                    const Text('Tổng tiền',
                                                        style: TextStyle(
                                                            fontSize: 18.0)),
                                                    Text(
                                                        oCcy.format(_calTotalAmount(
                                                                cartController
                                                                    .cartsList)
                                                            .toInt()),
                                                        style: const TextStyle(
                                                            fontSize: 18.0))
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
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 4.0),
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButton<String>(
                                              value: _selectedPayment ?? '',
                                              iconSize: 30.0,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _selectedPayment = newValue;
                                                });
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
                                                                      18.0))),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deleteCartByUserId(
                                        userController.user.value.id);
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
                                                color: red)),
                                        const Text("Xóa giỏ hàng",
                                            style: TextStyle(
                                                color: red, fontSize: 18.0))
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
                                      cartController.total["quantity"]
                                          .toString() +
                                      ' sản phẩm',
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
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
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ]),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _showModelButtonSheet(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12.0),
                              child: const Text('Đặt hàng',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold)),
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

  void deleteCartByUserId(int userId) async {
    cartController.deleteCartByUserId(userId);
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
                            setState(() {
                              _indexSelectedOrder = 1;
                              _selectedOrder = 'Giao hàng';
                            });
                          },
                          child: Card(
                              color: _indexSelectedOrder == 1
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
                                                    fontWeight: FontWeight.w800,
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
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17.0),
                                              )),
                                        ],
                                      ))
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _indexSelectedOrder = 0;
                              _selectedOrder = 'Mang đi';
                            });
                          },
                          child: Card(
                              color: _indexSelectedOrder == 0
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
                                                    fontWeight: FontWeight.w800,
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
                                                    fontWeight: FontWeight.w500,
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
    // lệch 1km cho phép
    print(distanceInMeters);

    return distanceInMeters.round();
  }
}
