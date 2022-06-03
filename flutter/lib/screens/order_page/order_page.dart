import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/screens/order_page/rate_filter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/cart_page/cart_page.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/payment_controller.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key, this.product}) : super(key: key);

  Product product;
  @override
  _OrderPage createState() => _OrderPage();
}

enum SizeEnum { S, M, L }

class _OrderPage extends State<OrderPage> {
  Product _product;

  RateController rateController = Get.put(RateController());
  CartController cartController = Get.put(CartController());
  UserController userController = Get.put(UserController());
  PaymentController paymentController = Get.put(PaymentController());

  final _milkNames = ["Sữa ngôi sao", "Sữa ông thọ", "Sữa tươi"];
  final _sugarPercents = [0, 25, 50, 75, 100];
  final _icePercents = [0, 25, 50, 75, 100];

  int _quantity = 1;
  String _milk = "";
  int _sugar = 50;
  int _ice = 50;

  final String _urlDefault = "assets/images/coffee.png";
  final String _urlSelected = "assets/images/ice-tea.png";

  String _urlS = "";
  String _urlM = "";
  String _urlL = "";
  int _index = 2;

  void _updateQuantity(String operator) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          if (operator == "add") {
            _quantity += 1;
          } else {
            if (_quantity > 1) {
              _quantity -= 1;
            }
          }
        }));
  }

  void _updateSize(SizeEnum size) {
    _index = size.index;

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _urlS = _urlDefault;
          _urlM = _urlDefault;
          _urlL = _urlDefault;
          if (size == SizeEnum.S) {
            _urlS = _urlSelected;
          } else if (size == SizeEnum.M) {
            _urlM = _urlSelected;
          } else {
            _urlL = _urlSelected;
          }
        }));
  }

  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _updateSize(SizeEnum.L);
    _milk = _milkNames[0];
    _ice = _icePercents[2];
    _sugar = _sugarPercents[2];
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      cartController.fetchCartsByCustomerId(userController.user.value.id);
      rateController.fetchRates(_product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Stack(
                children: [
                  Positioned(
                    child: SafeArea(
                        child: Column(children: [
                      SizedBox(
                        width: size.width,
                        height: size.width,
                        child:
                            Stack(alignment: Alignment.centerLeft, children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                                padding: const EdgeInsets.all(40.0),
                                height: size.width * 0.90,
                                width: size.width * 0.90,
                                decoration: const BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(100.0)),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network(_product.image,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.contain))),
                          ),
                          Positioned(
                            left: size.width * 0.10 - 24.0,
                            top: 0.0,
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey,
                              ),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ),
                          ),
                          Obx(() {
                            return Positioned(
                              right: 12.0,
                              top: 0.0,
                              child: Container(
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.transparent,
                                ),
                                child: IconButton(
                                    icon: Icon(
                                      EvaIcons.heart,
                                      size: 32,
                                      color: userController
                                              .checkFavourite(_product)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      if (userController
                                          .checkFavourite(_product)) {
                                        _removeFavourite(_product);
                                      } else {
                                        _addFavourite(_product);
                                      }
                                    }),
                              ),
                            );
                          }),
                          Positioned.fill(
                            bottom: 20.0,
                            // left: 50,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: 160,
                                  height: 44.0,
                                  padding: const EdgeInsets.all(0.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                    color: Colors.grey,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 6.0),
                                        child: IconButton(
                                            icon: const Icon(Icons.remove,
                                                size: 24.0,
                                                color: Colors.white),
                                            onPressed: () {
                                              _updateQuantity("minus");
                                            }),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(_quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: IconButton(
                                            icon: const Icon(Icons.add,
                                                size: 24.0,
                                                color: Colors.white),
                                            onPressed: () {
                                              _updateQuantity("add");
                                            }),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ]),
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          width: size.width,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    //width: size.width - 60.0,
                                    padding: const EdgeInsets.only(
                                        top: 0.0, bottom: 5.0),
                                    child: Text(_product.name,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: red,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ))),
                                Container(
                                    //width: size.width - 60.0,
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      _product.description,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    )),
                              ])),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: const Text("Size",
                                style: TextStyle(
                                    color: red,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 70.0,
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      _updateSize(SizeEnum.S);
                                    },
                                    child: Container(
                                      child: SizedBox(
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                            Positioned(
                                              child: Image.asset(
                                                  'assets/icons/coffee-cup.png',
                                                  height: 70,
                                                  color: _index == 0
                                                      ? primary
                                                      : black,
                                                  fit: BoxFit.fitHeight),
                                            ),
                                            Positioned(
                                              top: 25,
                                              child: Text(SizeEnum.S.name,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white)),
                                            )
                                          ])),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 80.0,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      _updateSize(SizeEnum.M);
                                    },
                                    child: Container(
                                      alignment:
                                          Alignment.center, // use aligment
                                      child: SizedBox(
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                            Positioned(
                                              child: Image.asset(
                                                  'assets/icons/coffee-cup.png',
                                                  height: 85,
                                                  color: _index == 1
                                                      ? primary
                                                      : black,
                                                  fit: BoxFit.fitHeight),
                                            ),
                                            Positioned(
                                              top: 30.0,
                                              child: Text(SizeEnum.M.name,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white)),
                                            )
                                          ])),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 95.0,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      _updateSize(SizeEnum.L);
                                    },
                                    child: SizedBox(
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                          Positioned(
                                            child: Image.asset(
                                                'assets/icons/coffee-cup.png',
                                                height: 100,
                                                color: _index == 2
                                                    ? primary
                                                    : black,
                                                fit: BoxFit.fitHeight),
                                          ),
                                          Positioned(
                                            top: 35,
                                            child: Text(SizeEnum.L.name,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white)),
                                          )
                                        ])),
                                  ),
                                )
                              ]),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(children: [
                              Container(
                                  child: ((() {
                                if (_product.discount > 0) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, right: 28),
                                    child: Text(
                                        oCcy.format(_product.sizes[0].price),
                                        style: const TextStyle(
                                            color: yellow,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                  );
                                }
                              })())),
                              Container(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, right: 30),
                                  child: Text(
                                      oCcy.format(_product.sizes[0].price *
                                          (1 - _product.discount / 100)),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ))),
                            ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                      child: ((() {
                                    if (_product.discount > 0) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 33.0),
                                        child: Text(
                                            oCcy.format(
                                                _product.sizes[1].price),
                                            style: const TextStyle(
                                                color: yellow,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                      );
                                    }
                                  })())),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          top: 2.0, right: 35.0),
                                      child: Text(
                                          oCcy.format(_product.sizes[1].price *
                                              (1 - _product.discount / 100)),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ))),
                                ]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    child: ((() {
                                  if (_product.discount > 0) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 14.0),
                                      child: Text(
                                          oCcy.format(_product.sizes[2].price),
                                          style: const TextStyle(
                                              color: yellow,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                    );
                                  }
                                })())),
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, right: 16),
                                    child: Text(
                                        oCcy.format(_product.sizes[2].price *
                                            (1 - _product.discount / 100)),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ))),
                              ],
                            ),
                            const SizedBox(width: 8),
                          ]),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 10, right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, top: 0.0, right: 0.0),
                                        child: const Text("Sữa",
                                            style: TextStyle(
                                                color: red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 0),
                                      child: SizedBox(
                                        width: 130,
                                        height: 100,
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                //left: 20,
                                                child: Container(
                                                  width: 90,
                                                  height: 90,
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primary),
                                                  child: Image.asset(
                                                      'assets/icons/milk.png',
                                                      height: 75,
                                                      width: 60,
                                                      color: white1),
                                                ),
                                              ),
                                              Positioned(
                                                right: 95,
                                                child: InkWell(
                                                  onTap: () {
                                                    int _indexMilk = _milkNames
                                                        .indexOf(_milk);
                                                    if (_indexMilk == 0) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  setState(() {
                                                                    _milk = _milkNames[
                                                                        _milkNames.length -
                                                                            1];
                                                                  }));
                                                    } else {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  setState(() {
                                                                    _milk = _milkNames[
                                                                        _indexMilk -
                                                                            1];
                                                                  }));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: lightGray3),
                                                    child: Image.asset(
                                                        'assets/icons/left-arrow.png',
                                                        height: 13,
                                                        color: black),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 95,
                                                child: InkWell(
                                                  onTap: () {
                                                    int _indexMilk = _milkNames
                                                        .indexOf(_milk);
                                                    if (_indexMilk ==
                                                        _milkNames.length - 1) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  setState(() {
                                                                    _milk =
                                                                        _milkNames[
                                                                            0];
                                                                  }));
                                                    } else {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  setState(() {
                                                                    _milk = _milkNames[
                                                                        _indexMilk +
                                                                            1];
                                                                  }));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: lightGray3),
                                                    child: Image.asset(
                                                        'assets/icons/right-arrow.png',
                                                        height: 13,
                                                        color: black),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          _milk,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ))
                                  ]),
                              Container(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10.0, top: 0.0, right: 0.0),
                                          child: const Text("Đường",
                                              style: TextStyle(
                                                  color: red,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 0),
                                        child: SizedBox(
                                          width: 130,
                                          height: 60,
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned(
                                                  //left: 20,
                                                  child: Container(
                                                    width: 100,
                                                    height: 45,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: primary),
                                                    child: Text(
                                                        _sugar.toString() + '%',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int _indexSugar =
                                                          _sugarPercents
                                                              .indexOf(_sugar);
                                                      if (_indexSugar > 0) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) => setState(
                                                                        () {
                                                                      _sugar = _sugarPercents[
                                                                          _indexSugar -
                                                                              1];
                                                                    }));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: _sugar != 0
                                                            ? lightGray3
                                                            : Colors.grey[500],
                                                      ),
                                                      child: Image.asset(
                                                          'assets/icons/left-arrow.png',
                                                          height: 13,
                                                          color: black),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int _indexSugar =
                                                          _sugarPercents
                                                              .indexOf(_sugar);
                                                      if (_indexSugar <
                                                          _sugarPercents
                                                                  .length -
                                                              1) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) => setState(
                                                                        () {
                                                                      _sugar = _sugarPercents[
                                                                          _indexSugar +
                                                                              1];
                                                                    }));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: _sugar != 100
                                                            ? lightGray3
                                                            : Colors.grey[500],
                                                      ), //lightGray3),
                                                      child: Image.asset(
                                                          'assets/icons/right-arrow.png',
                                                          height: 13,
                                                          color: black),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 10.0, top: 0.0, right: 0.0),
                                          child: const Text("Đá",
                                              style: TextStyle(
                                                  color: red,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 0),
                                        child: SizedBox(
                                          width: 130,
                                          height: 60,
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Positioned(
                                                  //left: 20,
                                                  child: Container(
                                                    width: 100,
                                                    height: 45,
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: primary),
                                                    child: Text(
                                                        _ice.toString() + '%',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int _indexIce =
                                                          _icePercents
                                                              .indexOf(_ice);
                                                      if (_indexIce > 0) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) => setState(
                                                                        () {
                                                                      _ice = _icePercents[
                                                                          _indexIce -
                                                                              1];
                                                                    }));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: _ice != 0
                                                            ? lightGray3
                                                            : Colors.grey[500],
                                                      ),
                                                      child: Image.asset(
                                                          'assets/icons/left-arrow.png',
                                                          height: 13,
                                                          color: black),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int _indexIce =
                                                          _icePercents
                                                              .indexOf(_ice);
                                                      if (_indexIce <
                                                          _icePercents.length -
                                                              1) {
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (_) => setState(
                                                                        () {
                                                                      _ice = _icePercents[
                                                                          _indexIce +
                                                                              1];
                                                                    }));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          color: _ice != 100
                                                              ? lightGray3
                                                              : Colors
                                                                  .grey[500]),
                                                      child: Image.asset(
                                                          'assets/icons/right-arrow.png',
                                                          height: 13,
                                                          color: black),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ]),
                              ),
                            ]),
                      ),
                      Container(
                          color: Colors.grey[200],
                          padding: EdgeInsets.only(top: 4),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RateFilterPage())),
                                child: Container(
                                  color: white,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Khách hàng đánh giá",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      _product.rate
                                                              .toStringAsFixed(
                                                                  1) +
                                                          "/5 ",
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: yellowDark)),
                                                  // Container(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           bottom: 5.0),
                                                  //   child: Text(
                                                  //       "★★★★★".substring(
                                                  //             0,
                                                  //             _product.rate
                                                  //                 .toInt(),
                                                  //           ) +
                                                  //           "☆☆☆☆☆".substring(
                                                  //               _product.rate
                                                  //                   .toInt(),
                                                  //               5),
                                                  //       style: const TextStyle(
                                                  //           fontSize: 16,
                                                  //           fontWeight:
                                                  //               FontWeight.bold,
                                                  //           color: yellowDark)),
                                                  // ),

                                                  Text(
                                                      " (" +
                                                          _product
                                                              .numberReviewers
                                                              .toString() +
                                                          " đánh giá)",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .grey[500])),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          Text("Xem tất cả",
                                              style: TextStyle(
                                                  color: primary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700)),
                                          Icon(CupertinoIcons.right_chevron,
                                              color: primary, size: 15),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  color: primary,
                                  child: SizedBox(
                                    height: 0.75,
                                    width: size.width,
                                  )),
                              Obx(() {
                                if (rateController.isLoading.value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Container(
                                    color: white,
                                    child: ListView.builder(
                                        //itemCount: storeController.storesList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            rateController.ratesList.length < 3
                                                ? rateController
                                                    .ratesList.length
                                                : 3,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 13, right: 0),
                                                //margin: const EdgeInsets.only(right: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              child: Image.asset(
                                                                  'assets/icons/profile.png',
                                                                  height: 25,
                                                                  width: 25))),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 10,
                                                                bottom: 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "User " +
                                                                    rateController
                                                                        .ratesList[
                                                                            index]
                                                                        .userId
                                                                        .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        11,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color:
                                                                        gray)),
                                                            const SizedBox(
                                                                height: 5),
                                                            Text(
                                                                DateTime.fromMillisecondsSinceEpoch(rateController
                                                                        .ratesList[
                                                                            index]
                                                                        .createdDate)
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            10)),
                                                            Text(
                                                                "★★★★★"
                                                                        .substring(
                                                                      0,
                                                                      rateController
                                                                          .ratesList[
                                                                              index]
                                                                          .star
                                                                          .toInt(),
                                                                    ) +
                                                                    "☆☆☆☆☆".substring(
                                                                        rateController
                                                                            .ratesList[
                                                                                index]
                                                                            .star
                                                                            .toInt(),
                                                                        5),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        yellowDark)),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 35,
                                                              right: 10),
                                                      child: Text(
                                                          rateController
                                                              .ratesList[index]
                                                              .comment
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  color: gray)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  color: Colors.grey[300],
                                                  child: SizedBox(
                                                    height: 0.75,
                                                    width: size.width,
                                                  )),
                                            ],
                                          );
                                        
                                        }),
                                  );
                                }
                              }),
                            ],
                          )),
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RateFilterPage())),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Xem tất cả (${_product.numberReviewers.toString()})',
                                      style: const TextStyle(
                                          color: primary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700)),
                                  const Icon(CupertinoIcons.right_chevron,
                                      color: primary, size: 18)
                                ])),
                      ),
                      Container(
                          color: Colors.grey[300],
                          child: SizedBox(
                            height: 0.75,
                            width: size.width,
                          )),
                      const SizedBox(
                        height: 5,
                      )
                    ])),
                  ),
                ],
              )),
            ),
            Container(
              color: primary,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                    padding: const EdgeInsets.all(0.0),
                    color: primary,
                    height: 60.0,
                    width: size.width / 3,
                    child: Obx(() {
                      if (cartController.isLoading.value) {
                        return TextButton(
                            onPressed: () {},
                            child: Text(
                                'Giỏ hàng (' +
                                    cartController.cartsList.length.toString() +
                                    ')',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white)));
                      } else {
                        return TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartPage())),
                            child: Text(
                                'Giỏ hàng (' +
                                    cartController.cartsList.length.toString() +
                                    ')',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white)));
                      }
                    })),
                Container(
                    color: lightGray3,
                    height: 60.0,
                    width: size.width / 3.25,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                            "Tổng tiền: " +
                                oCcy
                                    .format(_quantity *
                                        _product.sizes[_index].price *
                                        (1 - _product.discount / 100))
                                    .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black)))),
                Container(
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center,
                    color: primary,
                    height: 60.0,
                    width: size.width / 3,
                    child: TextButton(
                        onPressed: addToCart,
                        child: const Text("Thêm vào giỏ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white)))),
              ]),
            ),
          ],
        ));
  }

  void _addFavourite(Product product) async {
    await userController.addFavourites(product);
  }

  void _removeFavourite(Product product) async {
    await userController.removeFavourites(product);
  }

  void addToCart() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    Cart cart = Cart();
    cart.code = 'CART' +
        ((DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt()).toString();
    cart.state = true;
    cart.description = 'Sữa: ' +
        _milk +
        ', Đường: ' +
        _sugar.toString() +
        '%, Đá: ' +
        _ice.toString() +
        '%';
    cart.quantity = _quantity;
    cart.size = _index == 0
        ? 'S'
        : _index == 1
            ? 'M'
            : 'L';
    cart.customerId = userController.user.value.id;
    cart.productId = _product.id;
    cart.storeId = 1;
    cart.ice = _ice;
    cart.milk = _milk;
    cart.sugar = _sugar;
    cart.product = _product;

    List<Cart> cartCheck = cartController.cartsList
        .where((c) =>
            c.productId == cart.productId &&
            c.size == cart.size &&
            c.milk == cart.milk &&
            c.ice == cart.ice &&
            c.sugar == cart.sugar)
        .toList();
    if (cartCheck != null && cartCheck.length > 0) {
      cartCheck[0].quantity += cart.quantity;
      await cartController.updateCart(cartCheck[0]);
      var index =
          cartController.cartsList.indexWhere((c) => c.id == cartCheck[0].id);
      cartController.cartsList[index].quantity = cartCheck[0].quantity;
    } else {
      Cart cartDB = await cartController.addCart(cart);
    }

    await EasyLoading.dismiss();
  }
}
