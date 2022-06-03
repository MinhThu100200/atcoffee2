import 'package:at_coffee/screens/order_page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ProductItem extends StatefulWidget {
  ProductItem({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _ProductItem createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

  CartController cartController = Get.put(CartController());
  UserController userController = Get.put(UserController());

  Product _product;
  @override
  void initState() {
    _product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrderPage(product: _product)));
        },
        child: Container(
          height: 140.0,
          padding: const EdgeInsets.only(left: 20.0, right: 0.0),
          child: SizedBox(
              height: size.width,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 20.0,
                    left: 70.0,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 50.0, right: 10.0, top: 5.0, bottom: 5.0),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 100.0,
                      width: size.width - 110.0,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(_product.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: const [
                              Text("Size: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: white1)),
                              Text("S, M, L",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: lightYellow)),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(children: [
                            const Text("Giá: ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: white1)),
                            Text(
                                oCcy
                                        .format(_product.sizes[0].price)
                                        .toString() +
                                    " - " +
                                    oCcy
                                        .format(_product.sizes[2].price)
                                        .toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: lightYellow))
                          ]),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(_product.rate.round().toString() + " ",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow)),
                              Container(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                    "★★★★★".substring(
                                          0,
                                          _product.rate.round(),
                                        ) +
                                        "☆☆☆☆☆".substring(
                                            _product.rate.round(), 5),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow)),
                              ),
                              Text(
                                  "/ " +
                                      _product.numberReviewers.toString() +
                                      " đánh giá",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 110.0,
                    width: 110.0,
                    decoration: BoxDecoration(
                      color: lightYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            Image.network(_product.image, fit: BoxFit.contain,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace stackTrace) {
                          return const Text('😢');
                        }, loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          }
                        })),
                  ),
                  Positioned(
                      left: 70,
                      top: -10.0,
                      child: Obx(() {
                        return IconButton(
                            icon: Icon(
                              EvaIcons.heart,
                              size: 24,
                              color: userController.checkFavourite(_product)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                            onPressed: () {
                              if (userController.checkFavourite(_product)) {
                                _removeFavourite(_product);
                              } else {
                                _addFavourite(_product);
                              }
                            });
                      })),
                  Positioned(
                      right: 10,
                      top: 20.0,
                      child: ((() {
                        if (_product.discount > 0) {
                          return Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: red,
                            ),
                            child: Text(
                                "-" + _product.discount.toString() + "%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: lightYellow)),
                          );
                        } else {
                          return const Text("");
                        }
                      }())))
                ],
              )),
        ));
  }

  void _addFavourite(Product product) async {
    await userController.addFavourites(product);
  }

  void _removeFavourite(Product product) async {
    await userController.removeFavourites(product);
  }
}
