import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  int indexCategory = 0;
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
    super.initState();
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
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text("Thông báo",
                          style: TextStyle(
                              color: white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
                  ]),
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 20.0),
                  // decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(40),
                  //         topRight: Radius.circular(40)),
                  //     color: lightGray3),
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          if (productController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            return Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: productController
                                      .productsSuggestion.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[400],
                                              width: 0.5),
                                        ),
                                        color: lightYellow,
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            height: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  "assets/icons/loudspeaker.png"),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 6),
                                                  child: const Text("Thông báo",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15))),
                                              FittedBox(
                                                child: SizedBox(
                                                    width: size.width - 100,
                                                    child: const Text(
                                                      "Đơn hàng của bạn đã được giao. Xin chân thành cảm ơn. Hẹn gặp lại!!!",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                    );
                                  }),
                            );
                          }
                        })
                      ]),
                ),
              ],
            )),
          )),
    );
  }
}
