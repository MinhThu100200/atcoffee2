import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/models/bill_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';

class ItemOrderDetail extends StatefulWidget {
  ItemOrderDetail({Key key, this.billDetail}) : super(key: key);

  BillDetail billDetail;

  @override
  _ItemOrderDetail createState() => _ItemOrderDetail();
}

class _ItemOrderDetail extends State<ItemOrderDetail> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  final ProductController productController = Get.put(ProductController());
  BillDetail _billDetail;
  @override
  void initState() {
    _billDetail = widget.billDetail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OrderPage(product: _product)));
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
                              child: Text(
                                  "${_billDetail.quantity} x ${productController.allProducts.where((item) => item.id == _billDetail.productId).toList()[0].name}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(children: [
                            _billDetail.discount > 0
                                ? Text(
                                    oCcy
                                        .format(_billDetail.price *
                                            _billDetail.quantity)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: black,
                                        decoration:
                                            TextDecoration.lineThrough))
                                : Text(""),
                            Text(
                                " " +
                                    oCcy
                                        .format(_billDetail.amount)
                                        .toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: lightYellow)),
                          ]),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: 40,
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Chú thích: ${_billDetail.description == null || _billDetail.description == "" ? "Không có" : _billDetail.description}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: white1)),
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
                        child: Image.network(
                            productController.allProducts
                                .where((item) =>
                                    item.id == _billDetail.productId)
                                .toList()[0]
                                .image,
                            fit: BoxFit.contain, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace stackTrace) {
                          return const Text('😢');
                        }, loadingBuilder: (BuildContext context,
                                Widget child,
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
                ],
              )),
        ));
  }
}
