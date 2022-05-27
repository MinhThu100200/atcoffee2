import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/models/Bill.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/manage_order_page/item_order_detail.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/products_page/product_item.dart';

class DetailOrderPage extends StatefulWidget {
  DetailOrderPage({Key key, this.bill}) : super(key: key);
  Bill bill;
  @override
  _DetailOrderPage createState() => _DetailOrderPage();
}

class _DetailOrderPage extends State<DetailOrderPage> {
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

  final CategoryController categoryController = Get.put(CategoryController());
  final StoreController storeController = Get.put(StoreController());
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    // TODO: implement initState
    _bill = widget.bill;
    super.initState();
    // storeController.getStoreListNearYou();
    // storeController.getAddress();
    //WidgetsBinding.instance?.addPostFrameCallback((_) {
    // _getLocationData().then((value) => setState(() {
    //       currentLocation = value;
    //     }));
    //storeController.getStoreListNearYou();
    //storeController.getAddress();
    // productController.fetchProductsByCategory(codeCategory[0]);
    print("Build Completed");
    //});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      storeController.getAddress();
      storeController.getStoreListNearYou();
    });

    return Scaffold(
      backgroundColor: lightGray3,
      body: Container(
          color: primary,
          child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    child: SizedBox(
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
                          child: Text("Chi tiết đơn hàng",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ]),
                )),
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
                            padding: EdgeInsets.only(
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
                                    child: Text("Tình trạng đơn hàng",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))),
                                SizedBox(height: 5),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "${cateData.where((element) => element['status'] == _bill?.status).toList()[0]['name']}",
                                        style: TextStyle(
                                          color: lightBlue,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                        )))
                              ],
                            )),
                        Container(
                            padding: EdgeInsets.only(
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
                                    child: Text("Địa chỉ nhận hàng",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))),
                                SizedBox(height: 5),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "${_bill?.address == "" || _bill?.address == null ? "Nhận tại cửa hàng" : _bill?.address}",
                                        style: TextStyle(
                                          color: lightBlue,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                        )))
                              ],
                            )),
                        Container(
                          child: ListView.builder(
                              itemCount: _bill.billDetails.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemOrderDetail(
                                    billDetail: _bill.billDetails[index]);
                              }),
                        ),
                        Container(
                            padding: EdgeInsets.only(
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
                                    child: Text("Tổng tiền",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("Tổng cộng:",
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
                                            style: TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("Giảm giá:",
                                            style: TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            oCcy.format(_bill.price).toString(),
                                            style: TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("Khuyến mãi/Phần thưởng:",
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
                                            style: TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text("Thành tiền:",
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
                                            style: TextStyle(
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
}
