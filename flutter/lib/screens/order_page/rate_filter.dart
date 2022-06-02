import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/models/bill.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/manage_order_page/detail_order.dart';
import 'package:at_coffee/screens/rate_page/rate_page.dart';
import 'package:at_coffee/screens/root_app/root_app.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';

class RateFilterPage extends StatefulWidget {
  const RateFilterPage({Key key}) : super(key: key);
  @override
  _RateFilterPage createState() => _RateFilterPage();
}

class _RateFilterPage extends State<RateFilterPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  int indexCategory = 6;

  var cateData = [
    {
      "id": 6,
      "name": 'Tất cả',
    },
    {
      "id": 5,
      "name": '5 sao',
    },
    {
      "id": 4,
      "name": '4 sao',
    },
    {
      "id": 3,
      "name": '3 sao',
    },
    {
      "id": 2,
      "name": '2 sao',
    },
    {
      "id": 1,
      "name": '1 sao',
    },
  ];
  final BillController billController = Get.put(BillController());

  void setStateValue(value) {
    setState(() {
      indexCategory = value;
    });
  }

  final CategoryController categoryController = Get.put(CategoryController());
  final StoreController storeController = Get.put(StoreController());
  final ProductController productController = Get.put(ProductController());

  final UserController userController = Get.put(UserController());
  final RateController rateController = Get.put(RateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                            onPressed: () => Navigator.pop(context))),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text("Đánh giá",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: lightGray3),
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          height: 70,
                          child: Center(
                            child: ListView.builder(
                              itemCount: cateData.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setStateValue(cateData[index]['id']);
                                  },
                                  child: Container(
                                    //width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          indexCategory == cateData[index]['id']
                                              ? lightGray3
                                              : Colors.grey[300],
                                      border: Border.all(
                                          color: indexCategory ==
                                                  cateData[index]['id']
                                              ? primary
                                              : lightGray3),
                                    ),
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            cateData[index]['id'] == 6
                                                ? Text(cateData[index]['name'],
                                                    style: const TextStyle(
                                                        fontSize: 16))
                                                : Text(
                                                    "★★★★★".substring(
                                                      0,
                                                      cateData[index]['id'],
                                                    ),
                                                    style: const TextStyle(
                                                        color: yellowDark)),
                                          ],
                                        ),
                                        cateData[index]['id'] == 6
                                            ? Text(
                                                "(${rateController.ratesList.length})")
                                            : Text(
                                                "(${rateController.ratesList.where((item) => item.star == cateData[index]['id']).toList().length})"),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            )),
          )),
    );
  }

  Widget _getMessageList(status) {
    return FirebaseAnimatedList(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        query: FirebaseDatabase.instance
            .ref('bills')
            .orderByChild('status')
            .equalTo(status),
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
