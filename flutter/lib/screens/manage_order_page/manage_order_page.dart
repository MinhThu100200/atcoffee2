import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
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

class ManageOrderPage extends StatefulWidget {
  const ManageOrderPage({Key key}) : super(key: key);
  @override
  _ManageOrderPage createState() => _ManageOrderPage();
}

class _ManageOrderPage extends State<ManageOrderPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  String indexCategory = 'REQUESTED';

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
  final BillController billController = Get.put(BillController());

  void setStateValue(value) {
    setState(() {
      indexCategory = value;
    });
    billController.updateSelected(value);
  }

  final CategoryController categoryController = Get.put(CategoryController());
  final StoreController storeController = Get.put(StoreController());
  final ProductController productController = Get.put(ProductController());

  final UserController userController = Get.put(UserController());

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
                          child: const Text("Đơn hàng",
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
                          height: 100,
                          child: Center(
                            child: ListView.builder(
                              itemCount: cateData.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setStateValue(cateData[index]['status']);
                                    if (cateData[index]['status'] == "RATE") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RatePage()));
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        child: Container(
                                          //width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: indexCategory ==
                                                    cateData[index]['status']
                                                ? primary
                                                : Colors.grey[300],
                                          ),
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              // Container(
                                              //   height: 50,
                                              //   width: 32,
                                              //   padding: EdgeInsets.only(
                                              //     top: index == 0 ? 8 : 5,
                                              //     bottom: 5,
                                              //   ),
                                              //   decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               25),
                                              //       color:
                                              //           indexCategory == index
                                              //               ? lightGreen
                                              //               : lightGreen2),
                                              //   child: Image.asset(
                                              //       nameImage[index]
                                              //           .toString(),
                                              //       //height: index == 0 ? 30 : 50,
                                              //       fit: BoxFit.fitHeight),
                                              // ),

                                              Text(cateData[index]['name'],
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      billController.billsList
                                              .where((element) =>
                                                  element.status ==
                                                  cateData[index]['status'])
                                              .toList()
                                              .isNotEmpty
                                          ? Positioned(
                                              left: 3,
                                              bottom: 58,
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: red2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Text(billController
                                                    .billsList
                                                    .where((element) =>
                                                        element.status ==
                                                        cateData[index]
                                                            ['status'])
                                                    .toList()
                                                    .length
                                                    .toString()),
                                              ))
                                          : const Text("")
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Obx(() {
                          if (billController.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            var data = billController.billsList
                                .where((element) =>
                                    element.status == indexCategory)
                                .toList();

                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailOrderPage(
                                                        bill: data[index])));
                                      },
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
                                                                "${data[index].billDetails[0].quantity} x ${data[index].billDetails[0].name}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white))),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(children: [
                                                          data[index]
                                                                      .billDetails[
                                                                          0]
                                                                      .discount >
                                                                  0
                                                              ? Text(
                                                                  oCcy
                                                                      .format(data[index]
                                                                              .billDetails[
                                                                                  0]
                                                                              .price *
                                                                          data[index]
                                                                              .billDetails[
                                                                                  0]
                                                                              .quantity)
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          black,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough))
                                                              : const Text(""),
                                                          Text(
                                                              " " +
                                                                  oCcy
                                                                      .format(data[index]
                                                                              .billDetails[
                                                                                  0]
                                                                              .amount *
                                                                          data[index]
                                                                              .billDetails[
                                                                                  0]
                                                                              .quantity)
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
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  '${data[index].billDetails.length} sản phẩm' +
                                                                      " - " +
                                                                      oCcy
                                                                          .format(data[index]
                                                                              .amount)
                                                                          .toString(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          lightYellow))
                                                            ]),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                                ">>>>> Xem chi tiết",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic)),
                                                          ],
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
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(
                                                          10),
                                                      child: Image.network(
                                                          productController.allProducts
                                                              .where((item) =>
                                                                  item.id ==
                                                                  data[index]
                                                                      .billDetails[
                                                                          0]
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
                                      ));
                                });
                          }
                        })

                        // status == 'REQUESTED'
                        //     ? _getMessageList('REQUESTED')
                        //     : _getMessageList('COMPLETED'),
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
