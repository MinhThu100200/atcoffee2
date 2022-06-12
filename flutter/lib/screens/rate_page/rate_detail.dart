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

class RateDetailPage extends StatefulWidget {
  RateDetailPage({Key key, this.bill}) : super(key: key);
  Bill bill;
  @override
  _RateDetailPage createState() => _RateDetailPage();
}

class _RateDetailPage extends State<RateDetailPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  Bill _bill;
  final UserController userController = Get.put(UserController());
  final ProductController productController = Get.put(ProductController());
  final BillController billController = Get.put(BillController());
  final RateController rateController = Get.put(RateController());
  double star = 5;
  final _comment = TextEditingController();
  var infoRate = [];
  @override
  void initState() {
    // TODO: implement initState
    _bill = widget.bill;
    for (var i = 0; i < _bill.billDetails.length; i++) {
      double rateStar = 5.0;
      final _comment = TextEditingController();
      infoRate.add({"rate": rateStar, "comment": _comment});
    }
    print("infoRate");
    print(infoRate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance?.addPostFrameCallback((_) {});

    return Scaffold(
      backgroundColor: lightGray3,
      appBar: AppBar(
        title: const Text("Đánh giá sản phẩm"),
        elevation: 0,
        bottomOpacity: 0.0,
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                //color: primary,
                child: SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: [
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
                          ListView.builder(
                              itemCount: _bill.billDetails.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                // return ItemRate(
                                //     billDetail: _bill.billDetails[index]);
                                return Column(
                                  children: [
                                    GestureDetector(
                                        // onTap: () => _bill
                                        //         .billDetails[index].state
                                        //     ? _showModelButtonSheet(context,
                                        //         _bill.billDetails[index])
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50.0,
                                                          right: 10.0,
                                                          top: 5.0,
                                                          bottom: 5.0),
                                                  decoration: BoxDecoration(
                                                    color: primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  height: 100.0,
                                                  width: size.width - 110.0,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              _bill
                                                                  .billDetails[
                                                                      index]
                                                                  .name,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white))),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "Size: ${_bill.billDetails[index].size}",
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
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
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(
                                                        10),
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
                                                        fit: BoxFit.contain,
                                                        errorBuilder: (BuildContext context,
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
                                    )),
                                    Container(
                                        margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 16,
                                        ),
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: lightGray2)),
                                        child: Column(
                                          children: [
                                            RatingBar.builder(
                                              initialRating: infoRate[index]
                                                  ['rate'],
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              //allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                setState(() {
                                                  infoRate[index]['rate'] =
                                                      rating;
                                                });
                                              },
                                            ),
                                            Container(
                                              height: 120,
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey[400])),
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: TextField(
                                                maxLines: 5,
                                                cursorColor:
                                                    black.withOpacity(0.5),
                                                controller: infoRate[index]
                                                    ['comment'],
                                                style: const TextStyle(
                                                    fontSize: 15),
                                                decoration:
                                                    const InputDecoration(
                                                  labelStyle: TextStyle(
                                                      color: Colors.black),
                                                  hintText: "Đánh giá",
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              }),
                        ]),
                  ),
                ],
              )),
            )),
          ),
          Column(children: [
            InkWell(
                onTap: () {
                  _rateFunc();
                },
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

  Future<void> _rateFunc() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      for (var i = 0; i < _bill.billDetails.length; i++) {
        var body = {
          "code": 'RATE${_bill.billDetails[i].code}',
          "state": true,
          "comment": infoRate[i]['comment'].text,
          "productId": _bill.billDetails[i].productId,
          "userId": userController.user.value.id,
          "star": infoRate[i]['rate'],
        };
        billController.updateBill(_bill.code);
        var res = await rateController.addRate(body);
        if (!res) {
          Get.snackbar(
            "Đánh giá lỗi",
            "Bạn ơi vui lòng thử lại",
            icon: const Icon(Icons.person, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
          );
        }
      }
      Get.snackbar(
        "Đánh giá thành công",
        "Cảm ơn những đánh giá quý báu của bạn!",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
    } catch (error) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Đánh giá lỗi",
        "Bạn ơi vui lòng thử lại",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
    EasyLoading.dismiss();
    Navigator.pop(context);
  }

  // Future<void> _addRate(BillDetail _billDetail) async {
  //   var body = {
  //     "code": 'RATE${_billDetail.code}',
  //     "state": true,
  //     "comment": _comment.text,
  //     "productId": _billDetail.productId,
  //     "userId": userController.user.value.id,
  //     "star": star,
  //   };
  //   var idBill = _billDetail.code.split('D');

  //   print("my id bill " + idBill[0]);
  //   try {
  //     billController.updateBill(idBill[0], int.parse(idBill[1]));
  //     var res = await rateController.addRate(body);
  //     // if (res) {
  //     //   //await EasyLoading.dismiss();
  //     //   Get.snackbar(
  //     //     "Đánh giá thành công",
  //     //     "Cảm ơn những đánh giá quý báu của bạn!",
  //     //     icon: const Icon(Icons.person, color: Colors.white),
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     backgroundColor: Colors.green,
  //     //   );
  //     // } else {
  //     //   //await EasyLoading.dismiss();
  //     //   Get.snackbar(
  //     //     "Đánh giá không thành công",
  //     //     "Bạn ơi vui lòng thử lại",
  //     //     icon: const Icon(Icons.person, color: Colors.white),
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     backgroundColor: Colors.red,
  //     //   );
  //     // }
  //   } catch (error) {
  //     //await EasyLoading.dismiss();
  //     Get.snackbar(
  //       "Đánh giá lỗi",
  //       "Bạn ơi vui lòng thử lại",
  //       icon: const Icon(Icons.person, color: Colors.white),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //     );
  //   }
  // }

  // void _showModelButtonSheet(BuildContext context, BillDetail _billDetail) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter myState) {
  //           return Container(
  //             height: 300,
  //             margin: const EdgeInsets.only(bottom: 250),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                             alignment: Alignment.centerLeft,
  //                             padding: const EdgeInsets.only(left: 16, top: 16),
  //                             child: Text(_billDetail.name,
  //                                 style: TextStyle(
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: Colors.grey[800]))),
  //                         Container(
  //                             alignment: Alignment.centerLeft,
  //                             padding: const EdgeInsets.only(left: 16, top: 4),
  //                             child: Text(_billDetail.description,
  //                                 style: const TextStyle(
  //                                     fontSize: 13,
  //                                     fontWeight: FontWeight.w500,
  //                                     color: Colors.black))),
  //                         RatingBar.builder(
  //                           initialRating: star,
  //                           minRating: 1,
  //                           direction: Axis.horizontal,
  //                           //allowHalfRating: true,
  //                           itemCount: 5,
  //                           itemPadding:
  //                               const EdgeInsets.symmetric(horizontal: 4.0),
  //                           itemBuilder: (context, _) => const Icon(
  //                             Icons.star,
  //                             color: Colors.amber,
  //                           ),
  //                           onRatingUpdate: (rating) {
  //                             setState(() {
  //                               star = rating;
  //                             });
  //                           },
  //                         ),
  //                         Container(
  //                           height: 120,
  //                           margin: const EdgeInsets.all(8),
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(8),
  //                               border: Border.all(color: Colors.grey[400])),
  //                           padding: const EdgeInsets.only(
  //                             left: 5,
  //                           ),
  //                           child: TextField(
  //                             maxLines: 5,
  //                             cursorColor: black.withOpacity(0.5),
  //                             controller: _comment,
  //                             style: const TextStyle(fontSize: 15),
  //                             decoration: const InputDecoration(
  //                               labelStyle: TextStyle(color: Colors.black),
  //                               hintText: "Đánh giá",
  //                               border: InputBorder.none,
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () => _addRate(_billDetail),
  //                           child: Container(
  //                               padding:
  //                                   const EdgeInsets.only(right: 10, top: 16),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.end,
  //                                 children: [
  //                                   Container(
  //                                       height: 30,
  //                                       width: 60,
  //                                       alignment: Alignment.center,
  //                                       decoration: BoxDecoration(
  //                                           color: primary,
  //                                           borderRadius:
  //                                               BorderRadius.circular(8)),
  //                                       padding: const EdgeInsets.only(left: 5),
  //                                       child: const Text("Gửi",
  //                                           style: TextStyle(
  //                                               fontSize: 14,
  //                                               color: Colors.black))),
  //                                 ],
  //                               )),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }

}
