import 'package:at_coffee/screens/cart_page/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/models/user.dart';
import 'package:at_coffee/models/payment.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/payment_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  String _selectedOrder = 'Tự đến lấy';

  String _selectedPayment = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      cartController.fetchCartsByCustomerId(userController.user.value.id);
    });

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
            .price;
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
                      child: Column(
                        children: [
                          Card(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28.0, vertical: 4.0),
                                    alignment: Alignment.centerLeft,
                                    child: DropdownButton<String>(
                                      value: _selectedOrder ?? '',
                                      iconSize: 30.0,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedOrder = newValue;
                                        });
                                      },
                                      items: <String>[
                                        'Tự đến lấy',
                                        'Giao tận nơi'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Container(
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      fontSize: 18.0))),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28.0, vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: const Icon(
                                              Icons.location_on_outlined,
                                              size: 24.0,
                                            )),
                                        Container(
                                          child: Text(
                                            cartController.cartsList.length > 0
                                                ? cartController
                                                    .cartsList[0].product.stores
                                                    .firstWhere((s) =>
                                                        s.id ==
                                                        cartController
                                                            .cartsList[0]
                                                            .storeId)
                                                    .address
                                                : '',
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                      Text("Các sản phẩm đã chọn",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold)),
                                      const Text("+ Thêm",
                                          style: TextStyle(fontSize: 22.0)),
                                    ]),
                              ),
                              if (cartController.cartsList.length > 0) ...[
                                Container(
                                  child: ListView.builder(
                                      itemCount:
                                          cartController.cartsList.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                        style: TextStyle(fontSize: 18.0))),
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
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.0),
                                          child: const Divider()),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Giảm giá',
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              Text(
                                                  oCcy.format(_calPromotion(
                                                          cartController
                                                              .cartsList)
                                                      .toInt()),
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ],
                                          )),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.0),
                                          child: const Divider()),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Tổng tiền',
                                                  style: TextStyle(
                                                      fontSize: 18.0)),
                                              Text(
                                                  oCcy.format(_calTotalAmount(
                                                          cartController
                                                              .cartsList)
                                                      .toInt()),
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ],
                                          )),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.0),
                                          child: Divider()),
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
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold))),
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
                                        items: paymentController.paymentsList
                                            .map((Payment payment) {
                                          return DropdownMenuItem<String>(
                                            value: payment.id.toString(),
                                            child: Container(
                                                width: size.width - 96,
                                                child: Text(payment.name,
                                                    style: const TextStyle(
                                                        fontSize: 18.0))),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Card(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 12.0),
                              child: Row(children: [
                                Container(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: const Icon(Icons.delete_outline,
                                        color: red)),
                                const Text("Xóa giỏ hàng",
                                    style:
                                        TextStyle(color: red, fontSize: 18.0))
                              ]),
                            ),
                          ),
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
                                  '$_selectedOrder' +
                                      ' - ' +
                                      _calTotalQuantity(
                                              cartController.cartsList)
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
}
