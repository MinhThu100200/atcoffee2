import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/cart_controller.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key, this.cart}) : super(key: key);

  Cart cart;
  _CartItem createState() => _CartItem();
}

class _CartItem extends State<CartItem> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

  final CartController cartController = Get.put(CartController());

  Cart _cart;
  @override
  void initState() {
    _cart = widget.cart;
    super.initState();
  }

  void _onChanged(newValue) {
    _cart.state = !_cart.state;
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
            // _cart.state = val;
            setState(() {
              _cart.state = val;
            });
            _updateState(_cart);
          },
        )),
        Expanded(
          child: Column(children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _cart.quantity.toString() +
                      " x " +
                      _cart.product.name +
                      " x " +
                      oCcy.format(_cart
                          .product
                          .sizes[_cart.size == 'S'
                              ? 0
                              : _cart.size == 'M'
                                  ? 1
                                  : 2]
                          .price),
                  style: const TextStyle(fontSize: 20.0),
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: Text('ĐCCH: ' +
                    _cart.product.stores
                        .firstWhere((s) => s.id == _cart.storeId)
                        .address)),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 4.0),
                alignment: Alignment.centerLeft,
                child: Text('Size: ' + _cart.size + ', ' + _cart.description)),
          ]),
        ),
        Center(
          child: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () {
                deleteCart(_cart.id);
              }),
        )
      ]),
    ));
  }

  void _updateState(Cart cart) async {
    cartController.updateCart(cart);
  }

  void deleteCart(int cartId) async {
    cartController.deleteCart(cartId);
  }
}
