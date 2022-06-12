import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/bill_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ItemRate extends StatefulWidget {
  ItemRate({Key key, this.billDetail}) : super(key: key);

  BillDetail billDetail;

  @override
  _ItemRate createState() => _ItemRate();
}

class _ItemRate extends State<ItemRate> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  final ProductController productController = Get.put(ProductController());
  final UserController userController = Get.put(UserController());
  final RateController rateController = Get.put(RateController());
  final BillController billController = Get.put(BillController());
  BillDetail _billDetail;
  int star = 5;
  final _comment = TextEditingController();
  @override
  void initState() {
    _billDetail = widget.billDetail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => GestureDetector(
          //onTap: () => _billDetail.state ? _showModelButtonSheet(context) : {},
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
                                    "${_billDetail.quantity} x ${_billDetail.name}",
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
                              height: 25,
                              alignment: Alignment.topLeft,
                              child: Text(
                                  "Chú thích: ${_billDetail.description == null || _billDetail.description == "" ? "Không có" : _billDetail.description}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: white1)),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                  _billDetail.state
                                      ? ">>>>>Đánh giá"
                                      : "Đã đánh giá",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
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
          )),
    );
  }

  // Future<bool> _addRate() async {
  //   await EasyLoading.show(
  //     status: 'loading...',
  //     maskType: EasyLoadingMaskType.black,
  //   );
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
  //     if (res) {
  //       await EasyLoading.dismiss();
  //       Get.snackbar(
  //         "Đánh giá thành công",
  //         "Cảm ơn những đánh giá quý báu của bạn!",
  //         icon: Icon(Icons.person, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //       );
  //     } else {
  //       await EasyLoading.dismiss();
  //       Get.snackbar(
  //         "Đánh giá không thành công",
  //         "Bạn ơi vui lòng thử lại",
  //         icon: const Icon(Icons.person, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   } catch (error) {
  //     await EasyLoading.dismiss();
  //     Get.snackbar(
  //       "Đánh giá lỗi",
  //       "Bạn ơi vui lòng thử lại",
  //       icon: const Icon(Icons.person, color: Colors.white),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //     );
  //   }
  //   Navigator.pop(context);
  // }

  // void _showModelButtonSheet(BuildContext context) {
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
  //                           initialRating: 3,
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
  //                               star = rating.toInt();
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
  //                           onTap: () => _addRate(),
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
  //                 // GestureDetector(
  //                 //   onTap: () => _orderHere(item),
  //                 //   child: Container(
  //                 //     padding: const EdgeInsets.all(8),
  //                 //     decoration: BoxDecoration(
  //                 //         color: primary, borderRadius: BorderRadius.circular(8)),
  //                 //     child: Column(
  //                 //       children: const [
  //                 //         Text("Đặt hàng",
  //                 //             style: TextStyle(
  //                 //                 color: white,
  //                 //                 fontSize: 14,
  //                 //                 fontWeight: FontWeight.w700)),
  //                 //         Text("Tự đến lấy tại cửa hàng này",
  //                 //             style: TextStyle(color: white, fontSize: 13)),
  //                 //       ],
  //                 //     ),
  //                 //   ),
  //                 // ),
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }

}
