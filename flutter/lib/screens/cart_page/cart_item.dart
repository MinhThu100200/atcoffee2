import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/models/size.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key, this.cart}) : super(key: key);

  Cart cart;
  _CartItem createState() => _CartItem();
}

class _CartItem extends State<CartItem> with TickerProviderStateMixin {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

  final CartController cartController = Get.put(CartController());

  final _milkNames = ["Sữa ngôi sao", "Sữa ông thọ", "Sữa tươi"];
  final _sugarPercents = [0, 25, 50, 75, 100];
  final _icePercents = [0, 25, 50, 75, 100];

  Cart _cart;
  @override
  void initState() {
    super.initState();
    _cart = Cart.fromJson(widget.cart.toJson());
  }

  void _onChanged(newValue) {
    _cart.state = !_cart.state;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Row(children: [
        Center(
            child: Checkbox(
          fillColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateBorderSide.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const BorderSide(color: gray);
            } else {
              return const BorderSide(color: gray);
            }
          }),
          checkColor: lightGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          value: _cart.state,
          onChanged: (val) {
            // cartController.isLoading.value = true;
            _cart.state = val;
            _updateCart(_cart);
            // cartController.isLoading.value = false;
          },
        )),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _showModelButtonSheet(context);
            },
            child: Column(children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 2.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _cart.quantity.toString() +
                        " x " +
                        _cart.product.name +
                        " x " +
                        oCcy.format((_cart
                                    .product
                                    .sizes[_cart.size == 'S'
                                        ? 0
                                        : _cart.size == 'M'
                                            ? 1
                                            : 2]
                                    .price *
                                (1 - _cart.product.discount / 100))
                            .toInt()),
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w600),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 2.0),
                  alignment: Alignment.centerLeft,
                  child:
                      Text('Size: ' + _cart.size + ', ' + _cart.description)),
            ]),
          ),
        ),
        Center(
          child: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () {
                // cartController.isLoading.value = true;
                _deleteCart(_cart.id);
                //  cartController.isLoading.value = false;
              }),
        )
      ]),
    ));
  }

  void _updateCart(Cart cart) {
    cartController.updateCart(cart);
  }

  void _deleteCart(int cartId) {
    cartController.deleteCart(cartId);
  }

  void _showModelButtonSheet(BuildContext context) {
    var size = MediaQuery.of(context).size;

    showModalBottomSheet(
        isScrollControlled: true,
        // expand: false,
        isDismissible: false,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter myState) {
            return SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      child: SizedBox(
                        width: size.width,
                        height: size.width + 30.0,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                  margin: const EdgeInsets.all(0.0),
                                  padding: const EdgeInsets.all(40.0),
                                  height: size.width,
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(_cart.product.image,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.contain, errorBuilder:
                                              (BuildContext context,
                                                  Object exception,
                                                  StackTrace stackTrace) {
                                        return const Text('😢');
                                      }, loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          );
                                      }))),
                            ),
                            Positioned.fill(
                              top: 0.0,
                              bottom: 10.0,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 6.0),
                                          child: IconButton(
                                              icon: const Icon(Icons.remove,
                                                  size: 24.0,
                                                  color: Colors.white),
                                              onPressed: () {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) =>
                                                        myState(() {
                                                          _cart.quantity -=
                                                              _cart.quantity > 1
                                                                  ? 1
                                                                  : 0;
                                                        }));
                                              }),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                _cart.quantity.toString(),
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
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (_) => myState(() {
                                                              _cart.quantity +=
                                                                  1;
                                                            }));
                                              }),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                                right: 10.0,
                                top: 40.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: white,
                                  ),
                                  child: Text(oCcy.format(_calcAmount(_cart)),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0)),
                                )),
                            Positioned(
                                left: 10.0,
                                top: 40.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: white,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 16.0,
                                      color: black,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          top: 15.0,
                        ),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                alignment: Alignment.centerLeft,
                                child: Text(_cart.product.name,
                                    style: const TextStyle(
                                      color: red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _cart.product.description,
                                  style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )),
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15.0),
                                  alignment: Alignment.centerLeft,
                                  height: 100,
                                  child: const Text(
                                    "Kích thước",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                      color: red,
                                    ),
                                  )),
                            ),
                            Container(
                                child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_cart.size.toUpperCase() != 'S') {
                                          myState(() {
                                            _cart.size = 'S';
                                          });
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              height: 100,
                                              alignment: Alignment.bottomCenter,
                                              width: 60,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Image.asset(
                                                  'assets/icons/coffee-cup.png',
                                                  height: 75,
                                                  width: 60,
                                                  color: _cart.size == 'S'
                                                      ? primary
                                                      : black,
                                                  fit: BoxFit.fitHeight),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 60,
                                            left: 40,
                                            child: Text('S',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: ((() {
                                            if (_cart.product.discount > 0) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, right: 0),
                                                child: Text(
                                                    oCcy.format(_cart.product
                                                        .sizes[0].price),
                                                    style: const TextStyle(
                                                        color: yellow,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              );
                                            }
                                          })())),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 0),
                                              child: Text(
                                                  oCcy.format(_cart.product
                                                          .sizes[0].price *
                                                      (1 -
                                                          _cart.product
                                                                  .discount /
                                                              100)),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_cart.size.toUpperCase() != 'M') {
                                          myState(() {
                                            _cart.size = 'M';
                                          });
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              height: 100,
                                              alignment: Alignment.bottomCenter,
                                              width: 65,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Image.asset(
                                                  'assets/icons/coffee-cup.png',
                                                  height: 85,
                                                  width: 65,
                                                  color: _cart.size == 'M'
                                                      ? primary
                                                      : black,
                                                  fit: BoxFit.fitHeight),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 57,
                                            left: 41,
                                            child: Text('M',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: ((() {
                                            if (_cart.product.discount > 0) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, right: 0),
                                                child: Text(
                                                    oCcy.format(_cart.product
                                                        .sizes[1].price),
                                                    style: const TextStyle(
                                                        color: yellow,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              );
                                            }
                                          })())),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 0),
                                              child: Text(
                                                  oCcy.format(_cart.product
                                                          .sizes[1].price *
                                                      (1 -
                                                          _cart.product
                                                                  .discount /
                                                              100)),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (_cart.size.toUpperCase() != 'L') {
                                          myState(() {
                                            _cart.size = 'L';
                                          });
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            child: Container(
                                              height: 100,
                                              alignment: Alignment.bottomCenter,
                                              width: 70,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Image.asset(
                                                  'assets/icons/coffee-cup.png',
                                                  height: 95,
                                                  width: 70,
                                                  color: _cart.size == 'L'
                                                      ? primary
                                                      : black,
                                                  fit: BoxFit.fitHeight),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 55,
                                            left: 46,
                                            child: Text('L',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: ((() {
                                            if (_cart.product.discount > 0) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, right: 0),
                                                child: Text(
                                                    oCcy.format(_cart.product
                                                        .sizes[2].price),
                                                    style: const TextStyle(
                                                        color: yellow,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              );
                                            }
                                          })())),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 0),
                                              child: Text(
                                                  oCcy.format(_cart.product
                                                          .sizes[2].price *
                                                      (1 -
                                                          _cart.product
                                                                  .discount /
                                                              100)),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                          ],
                        )),
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
                                                      .indexOf(_cart.milk);
                                                  if (_indexMilk == 0) {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) => myState(() {
                                                                  _cart.milk =
                                                                      _milkNames[
                                                                          _milkNames.length -
                                                                              1];
                                                                }));
                                                  } else {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) => myState(() {
                                                                  _cart.milk =
                                                                      _milkNames[
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
                                                          BorderRadius.circular(
                                                              6),
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
                                                      .indexOf(_cart.milk);
                                                  if (_indexMilk ==
                                                      _milkNames.length - 1) {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) => myState(() {
                                                                  _cart.milk =
                                                                      _milkNames[
                                                                          0];
                                                                }));
                                                  } else {
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) => myState(() {
                                                                  _cart.milk =
                                                                      _milkNames[
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
                                                          BorderRadius.circular(
                                                              6),
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
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _cart.milk,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, top: 0.0, right: 0.0),
                                        child: const Text("Đường",
                                            style: TextStyle(
                                                color: red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primary),
                                                  child: Text(
                                                      _cart.sugar.toString() +
                                                          '%',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                              Positioned(
                                                right: 100,
                                                child: InkWell(
                                                  onTap: () {
                                                    int _indexSugar =
                                                        _sugarPercents.indexOf(
                                                            _cart.sugar);
                                                    if (_indexSugar > 0) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  myState(() {
                                                                    _cart.sugar =
                                                                        _sugarPercents[
                                                                            _indexSugar -
                                                                                1];
                                                                  }));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: _cart.sugar != 0
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
                                                        _sugarPercents.indexOf(
                                                            _cart.sugar);
                                                    if (_indexSugar <
                                                        _sugarPercents.length -
                                                            1) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  myState(() {
                                                                    _cart.sugar =
                                                                        _sugarPercents[
                                                                            _indexSugar +
                                                                                1];
                                                                  }));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: _cart.sugar != 100
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
                                                fontWeight: FontWeight.bold))),
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
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primary),
                                                  child: Text(
                                                      _cart.ice.toString() +
                                                          '%',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                              Positioned(
                                                right: 100,
                                                child: InkWell(
                                                  onTap: () {
                                                    int _indexIce = _icePercents
                                                        .indexOf(_cart.ice);
                                                    if (_indexIce > 0) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  myState(() {
                                                                    _cart.ice =
                                                                        _icePercents[
                                                                            _indexIce -
                                                                                1];
                                                                  }));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      color: _cart.ice != 0
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
                                                    int _indexIce = _icePercents
                                                        .indexOf(_cart.ice);
                                                    if (_indexIce <
                                                        _icePercents.length -
                                                            1) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) =>
                                                                  myState(() {
                                                                    _cart.ice =
                                                                        _icePercents[
                                                                            _indexIce +
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
                                                        color: _cart.ice != 100
                                                            ? lightGray3
                                                            : Colors.grey[500]),
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
                      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // cartController.isLoading.value = true;
                                _cart.description = 'Sữa: ' +
                                    _cart.milk +
                                    ', Đường: ' +
                                    _cart.sugar.toString() +
                                    '%, Đá: ' +
                                    _cart.ice.toString() +
                                    '%';
                                _updateCart(_cart);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                child: const Text('Cập nhật',
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(primary),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: const BorderSide(
                                              color: primary))))),
                          const SizedBox(
                            width: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // cartController.isLoading.value = true;
                                _deleteCart(_cart.id);
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                child: const Text('Xóa',
                                    style: TextStyle(
                                        color: red,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              const BorderSide(color: red))))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        }).whenComplete(() {
      _cart = Cart.fromJson(widget.cart.toJson());
    });
  }

  int _calcAmount(Cart cart) {
    Size size = cart.product.sizes.firstWhereOrNull(
        (s) => s.size.toUpperCase() == cart.size.toUpperCase());
    int amount =
        (size.price * (1 - cart.product.discount / 100) * cart.quantity)
            .toInt();
    return amount;
  }
}
