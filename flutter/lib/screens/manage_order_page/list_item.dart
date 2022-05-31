import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/models/bill.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOrder extends StatefulWidget {
  ListOrder({Key key, this.status}) : super(key: key);

  //Bill bill;
  String status;

  @override
  _ListOrder createState() => _ListOrder();
}

class _ListOrder extends State<ListOrder> {
  final ProductController productController = Get.put(ProductController());
  final BillController billController = Get.put(BillController());
  //Bill _bill;
  String _status;
  @override
  void initState() {
    _status = widget.status;
    super.initState();
  }

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
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // var status = cateData[indexCategory]['name'];
      print(_status);
      print("Build Completed");
    });
    return FirebaseAnimatedList(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        query: FirebaseDatabase.instance
            .ref('bills')
            .orderByChild('status')
            .equalTo(_status),
        //sort: (a, b) => ,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<Object, Object>;
          final yourBill = Bill.fromDocumentSnapshot(json);
          // json.forEach((key, values) {
          //   print(values);
          //   //bills.add(Bill.fromDocumentSnapshot(values));
          // });
          print(json);
          //return ItemOrder(bill: yourBill);
        });
  }
}
