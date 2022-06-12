import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/bill.dart';
import 'package:at_coffee/screens/rate_page/rate_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';

class DetailOrderRatePage extends StatefulWidget {
  DetailOrderRatePage({Key key, this.bill}) : super(key: key);
  Bill bill;
  @override
  _DetailOrderRatePage createState() => _DetailOrderRatePage();
}

class _DetailOrderRatePage extends State<DetailOrderRatePage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  int indexCategory = 0;
  Bill _bill;
  var cateData = [
    {
      "id": 1,
      "name": 'Chờ xác nhận',
      "status": 'REQUESTED',
    },
    {
      "id": 2,
      "name": 'Đang chuẩn bị',
      "status": 'APPROVED',
    },
    {
      "id": 3,
      "name": 'Đang giao',
      "status": 'DELIVERING',
    },
    {
      "id": 4,
      "name": 'Hoàn thành',
      "status": 'COMPLETED',
    },
    {
      "id": 5,
      "name": 'Đã hủy',
      "status": 'CANCELED',
    },
    {
      "id": 6,
      "name": 'Đánh giá',
      "status": 'RATE',
    },
  ];

  void setStateValue(value) {
    indexCategory = value;
    setState(() {});
  }

  final UserController userController = Get.put(UserController());

  final ProductController productController = Get.put(ProductController());
  final BillController billController = Get.put(BillController());
  final RateController rateController = Get.put(RateController());
  @override
  void initState() {
    // TODO: implement initState
    _bill = widget.bill;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance?.addPostFrameCallback((_) {});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Đánh giá sản phẩm",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: lightGray3,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.only(top: 20.0, right: 5),
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(40),
                        //     topRight: Radius.circular(40)),
                        color: lightGray3),
                    child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 15, right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[400], width: 0.5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text("Tình trạng đơn hàng",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20))),
                                  const SizedBox(height: 5),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          "${cateData.where((element) => element['status'] == _bill?.status).toList()[0]['name']}",
                                          style: const TextStyle(
                                            color: lightBlue,
                                            fontSize: 14,
                                            // decoration:
                                            //     TextDecoration.underline,
                                          )))
                                ],
                              )),
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 5, left: 15, right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[400], width: 0.5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text("Địa chỉ nhận hàng",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20))),
                                  const SizedBox(height: 5),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          _bill?.address == "" ||
                                                  _bill?.address == null
                                              ? "Nhận tại cửa hàng"
                                              : _bill?.address,
                                          style: const TextStyle(
                                            color: lightBlue,
                                            fontSize: 14,
                                            // decoration:
                                            //     TextDecoration.underline,
                                          )))
                                ],
                              )),
                          const SizedBox(height: 10),
                          ListView.builder(
                              itemCount: _bill.billDetails.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    // onTap: () => _bill.billDetails[index].state
                                    //     ? _showModelButtonSheet(
                                    //         context, _bill.billDetails[index])
                                    //     : {},
                                    child: Container(
                                  height: 140.0,
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 0.0),
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
                                                  left: 50.0,
                                                  right: 10.0,
                                                  top: 5.0,
                                                  bottom: 5.0),
                                              decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              height: 100.0,
                                              width: size.width - 110.0,
                                              child: Column(
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "${_bill.billDetails[index].quantity} x ${_bill.billDetails[index].name}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(children: [
                                                    _bill.billDetails[index]
                                                                .discount >
                                                            0
                                                        ? Text(
                                                            oCcy
                                                                .format(_bill
                                                                        .billDetails[
                                                                            index]
                                                                        .price *
                                                                    _bill
                                                                        .billDetails[
                                                                            index]
                                                                        .quantity)
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: black,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough))
                                                        : Text(""),
                                                    Text(
                                                        " " +
                                                            oCcy
                                                                .format(_bill
                                                                        .billDetails[
                                                                            index]
                                                                        .amount *
                                                                    _bill
                                                                        .billDetails[
                                                                            index]
                                                                        .quantity)
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                lightYellow)),
                                                  ]),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        "Chú thích: ${_bill.billDetails[index].description == null || _bill.billDetails[index].description == "" ? "Không có" : _bill.billDetails[index].description}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: white)),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    productController.allProducts
                                                        .where((item) =>
                                                            item.id ==
                                                            _bill
                                                                .billDetails[
                                                                    index]
                                                                .productId)
                                                        .toList()[0]
                                                        .image,
                                                    fit: BoxFit.contain, errorBuilder: (BuildContext context,
                                                        Object exception,
                                                        StackTrace stackTrace) {
                                                  return const Text('😢');
                                                }, loadingBuilder: (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
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
                                                  }
                                                })),
                                          ),
                                        ],
                                      )),
                                ));
                              }),
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 5, left: 15, right: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[400], width: 0.5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: const Text("Tổng tiền",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20))),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text("Tổng cộng:",
                                              style: TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              oCcy
                                                  .format(totalPrice())
                                                  .toString(),
                                              style: const TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text("Giảm giá:",
                                              style: TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              oCcy
                                                  .format(_bill.price)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text(
                                              "Khuyến mãi/Phần thưởng:",
                                              style: TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              oCcy
                                                  .format(_bill.price -
                                                      _bill.amount)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: const Text("Thành tiền:",
                                              style: TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              oCcy
                                                  .format(_bill.amount)
                                                  .toString(),
                                              style: const TextStyle(
                                                color: gray1,
                                                fontSize: 14,
                                              ))),
                                    ],
                                  ),
                                ],
                              )),
                        ]),
                  ),
                ],
              ),
            )),
          ),
          Column(children: [
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RateDetailPage(bill: _bill))),
                child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: primary,
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        bottom: 5, top: 15, right: 10, left: 10),
                    child: const Text("Đánh giá",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: white))))
          ])
        ],
      ),
    );
  }

  double totalPrice() {
    double total = 0;
    for (var i = 0; i < _bill.billDetails.length; i++) {
      total =
          total + _bill.billDetails[i].price * _bill.billDetails[i].quantity;
    }
    return total;
  }
}
