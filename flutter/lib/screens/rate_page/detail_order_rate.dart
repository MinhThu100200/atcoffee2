import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/bill.dart';
import 'package:at_coffee/models/bill_detail.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/manage_order_page/item_order_detail.dart';
import 'package:at_coffee/screens/rate_page/item_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  int star = 5;
  final _comment = TextEditingController();
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
      backgroundColor: lightGray3,
      body: Container(
          color: primary,
          child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: Stack(alignment: Alignment.centerLeft, children: [
                    Positioned(
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text("Đánh giá sản phẩm",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                                          decoration: TextDecoration.underline,
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
                                          decoration: TextDecoration.underline,
                                        )))
                              ],
                            )),
                        ListView.builder(
                            itemCount: _bill.billDetails.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              // return ItemRate(
                              //     billDetail: _bill.billDetails[index]);
                              return GestureDetector(
                                  onTap: () => _bill.billDetails[index].state
                                      ? _showModelButtonSheet(
                                          context, _bill.billDetails[index])
                                      : {},
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
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "${_bill.billDetails[index].quantity} x ${_bill.billDetails[index].name}",
                                                            style: const TextStyle(
                                                                fontSize: 16,
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
                                                                      .amount)
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  lightYellow)),
                                                    ]),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                          "Chú thích: ${_bill.billDetails[index].description == null || _bill.billDetails[index].description == "" ? "Không có" : _bill.billDetails[index].description}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      white1)),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Text(
                                                          _bill
                                                                  .billDetails[
                                                                      index]
                                                                  .state
                                                              ? ">>>>>Đánh giá"
                                                              : "Đã đánh giá",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: gray3)),
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
                                                      productController
                                                          .allProducts
                                                          .where((item) =>
                                                              item.id ==
                                                              _bill
                                                                  .billDetails[
                                                                      index]
                                                                  .productId)
                                                          .toList()[0]
                                                          .image,
                                                      fit: BoxFit.contain,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace stackTrace) {
                                                    return const Text('😢');
                                                  }, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            oCcy.format(_bill.price).toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                .format(
                                                    _bill.price - _bill.amount)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                )
                              ],
                            )),
                      ]),
                ),
              ],
            )),
          )),
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

  Future<void> _addRate(BillDetail _billDetail) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var body = {
      "code": 'RATE${_billDetail.code}',
      "state": true,
      "comment": _comment.text,
      "productId": _billDetail.productId,
      "userId": userController.user.value.id,
      "star": star,
    };
    var idBill = _billDetail.code.split('D');

    print("my id bill " + idBill[0]);
    try {
      billController.updateBill(idBill[0], int.parse(idBill[1]));
      var res = await rateController.addRate(body);
      if (res) {
        await EasyLoading.dismiss();
        Get.snackbar(
          "Đánh giá thành công",
          "Cảm ơn những đánh giá quý báu của bạn!",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      } else {
        await EasyLoading.dismiss();
        Get.snackbar(
          "Đánh giá không thành công",
          "Bạn ơi vui lòng thử lại",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      await EasyLoading.dismiss();
      Get.snackbar(
        "Đánh giá lỗi",
        "Bạn ơi vui lòng thử lại",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    Navigator.pop(context);
  }

  void _showModelButtonSheet(BuildContext context, BillDetail _billDetail) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter myState) {
            return Container(
              height: 300,
              margin: const EdgeInsets.only(bottom: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Text(_billDetail.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800]))),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16, top: 4),
                              child: Text(_billDetail.description,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            //allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                star = rating.toInt();
                              });
                            },
                          ),
                          Container(
                            height: 120,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[400])),
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            child: TextField(
                              maxLines: 5,
                              cursorColor: black.withOpacity(0.5),
                              controller: _comment,
                              style: const TextStyle(fontSize: 15),
                              decoration: const InputDecoration(
                                labelStyle:
                                    TextStyle(color: Colors.black),
                                hintText: "Đánh giá",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _addRate(_billDetail),
                            child: Container(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 60,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: const EdgeInsets.only(left: 5),
                                        child: const Text("Gửi",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black))),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () => _orderHere(item),
                  //   child: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //         color: primary, borderRadius: BorderRadius.circular(8)),
                  //     child: Column(
                  //       children: const [
                  //         Text("Đặt hàng",
                  //             style: TextStyle(
                  //                 color: white,
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w700)),
                  //         Text("Tự đến lấy tại cửa hàng này",
                  //             style: TextStyle(color: white, fontSize: 13)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          });
        });
  }
}
