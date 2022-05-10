import 'package:at_coffee/screens/order_page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/order_page/order_page.dart';
import 'package:at_coffee/common/theme/colors.dart';

class ProductItem extends StatefulWidget {
  ProductItem({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _ProductItem createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');

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
          height: 160.0,
          padding: const EdgeInsets.only(left: 20.0, right: 0.0),
          child: SizedBox(
              height: size.width,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 30.0,
                    left: 70.0,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 120.0,
                      width: size.width - 110.0,
                      child: Column(
                        children: [
                          Container(
                            //flex: 1,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(_product.name,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            //flex: 1,
                            child: Row(
                              children: [
                                Text("Size: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: white1)),
                                Text("S, M, L",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: lightYellow)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            child: Row(children: [
                              Text("Giá: ",
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: lightYellow))
                            ]),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                              child: Row(
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
                          )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 130.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: lightYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              Image.network(_product.image, fit: BoxFit.contain,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                            return const Text('😢');
                          }, loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                          })),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      top: 20.0,
                      child: ((() {
                        if (_product.discount > 0) {
                          return Container(
                            height: 45,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: red,
                            ),
                            child: Text(
                                "-" + _product.discount.toString() + "%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
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
}
