import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
import 'package:at_coffee/screens/manage_order_page/item_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/products_page/product_item.dart';

class ManageOrderPage extends StatefulWidget {
  ManageOrderPage({Key key}) : super(key: key);
  @override
  _ManageOrderPage createState() => _ManageOrderPage();
}

class _ManageOrderPage extends State<ManageOrderPage> {
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
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Đơn hàng",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ]),
                )),
                SizedBox(
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
                                    setStateValue(index);
                                  },
                                  child: Container(
                                    //width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: indexCategory == index
                                          ? primary
                                          : Colors.grey[300],
                                    ),
                                    margin: const EdgeInsets.only(
                                        right: 15, bottom: 10),
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
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Obx(() {
                          if (productController.isLoading.value)
                            return Center(child: CircularProgressIndicator());
                          else
                            return Container(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: productController
                                      .productsSuggestion.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemOrder(
                                        product: productController
                                            .productsSuggestion[index]);
                                  }),
                            );
                        })
                      ]),
                ),
              ],
            )),
          )),
    );
  }
}
