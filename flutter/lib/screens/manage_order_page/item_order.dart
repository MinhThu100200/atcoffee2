import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/screens/order_page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/order_page/order_page.dart';
import 'package:at_coffee/common/theme/colors.dart';

class ItemOrder extends StatefulWidget {
  ItemOrder({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _ItemOrder createState() => _ItemOrder();
}

class _ItemOrder extends State<ItemOrder> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  final ProductController productController = Get.put(ProductController());
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
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text("1 x " + _product.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            child: Row(children: [
                              Text(
                                  "giá - giảm" +
                                      " - " +
                                      oCcy
                                          .format(_product.sizes[2].price)
                                          .toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: lightYellow))
                            ]),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            child: Row(children: [
                              Text(
                                  "tổng sp - tiền" +
                                      " - " +
                                      oCcy
                                          .format(_product.sizes[2].price)
                                          .toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
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
                              Text(">>>>> Xem chi tiết",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          )),
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
                ],
              )),
        ));
  }
}
