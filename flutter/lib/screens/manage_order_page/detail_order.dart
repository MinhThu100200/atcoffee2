import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/models/bill.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/manage_order_page/item_order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';

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
  final ProductController productController = Get.put(ProductController());
  final BillController billController = Get.put(BillController());
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
                          child: const Text("Chi tiết đơn hàng",
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
                                          //decoration: TextDecoration.underline,
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
                                          //decoration: TextDecoration.underline,
                                        )))
                              ],
                            )),
                        ListView.builder(
                            itemCount: _bill.billDetails.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemOrderDetail(
                                  billDetail: _bill.billDetails[index]);
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
                                            oCcy
                                                .format(
                                                    totalPrice() - _bill.price)
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
                                        child: const Text("Phí giao hàng:",
                                            style: TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                    Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            oCcy
                                                .format(_bill.shipFee)
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
                                                .format(_bill.amount +
                                                    _bill.shipFee)
                                                .toString(),
                                            style: const TextStyle(
                                              color: gray1,
                                              fontSize: 14,
                                            ))),
                                  ],
                                ),
                                _bill?.status == 'REQUESTED'
                                    ? Column(children: [
                                        InkWell(
                                            onTap: () =>
                                                cancelOrder(_bill.code),
                                            child: Container(
                                                width: size.width,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: primary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 5, top: 15),
                                                child: const Text("Huỷ đơn",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600))))
                                      ])
                                    : const Text("")
                              ],
                            )),
                      ]),
                ),
              ],
            )),
          )),
    );
  }

  Future<void> cancelOrder(billCode) async {
    try {
      await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
      );
      await billController.updateBillStatus(billCode);
      EasyLoading.dismiss();
    } catch (error) {
      EasyLoading.dismiss();
    }
    Navigator.pop(context);
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
