import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/screens/home_page/popup_address.dart';
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

                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       top: 10, left: 10, right: 10),
                        //   height: 70,
                        //   child: Center(
                        //     child: ListView.builder(
                        //       itemCount:
                        //           categoryController.categoriesList.length,
                        //       scrollDirection: Axis.horizontal,
                        //       shrinkWrap: true,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return InkWell(
                        //           onTap: () {
                        //             setStateValue(index);
                        //             productController.fetchProductsByCategory(
                        //                 codeCategory[index]);
                        //           },
                        //           child: Container(
                        //             //width: 100,
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(20),
                        //               color: indexCategory == index
                        //                   ? primary
                        //                   : lightGray3,
                        //             ),
                        //             margin: const EdgeInsets.only(
                        //                 right: 15, bottom: 10),
                        //             padding: const EdgeInsets.all(10),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 50,
                        //                   width: 32,
                        //                   padding: EdgeInsets.only(
                        //                     top: index == 0 ? 8 : 5,
                        //                     bottom: 5,
                        //                   ),
                        //                   decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(25),
                        //                       color: indexCategory == index
                        //                           ? lightGreen
                        //                           : lightGreen2),
                        //                   child: Image.asset(
                        //                       nameImage[index].toString(),
                        //                       //height: index == 0 ? 30 : 50,
                        //                       fit: BoxFit.fitHeight),
                        //                 ),
                        //                 Text(
                        //                     categoryController
                        //                         .categoriesList[index].name,
                        //                     style: TextStyle(fontSize: 16)),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),

                        // Container(
                        //   padding: const EdgeInsets.only(
                        //       top: 10, left: 20, right: 10),
                        //   height: 50,
                        //   child: ListView.builder(
                        //       itemCount: listTab.length,
                        //       scrollDirection: Axis.horizontal,
                        //       shrinkWrap: true,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return InkWell(
                        //           onTap: () {
                        //             // if (selectedTab == 0)
                        //             //   storeController.getStoreListNearYou();
                        //             setStateValue(index);
                        //           },
                        //           child: Column(children: [
                        //             Text(listTab[index],
                        //                 style: TextStyle(
                        //                     fontSize: 18,
                        //                     color: selectedTab == index
                        //                         ? primary
                        //                         : gray,
                        //                     fontWeight: FontWeight.w600)),
                        //             SizedBox(height: 5),
                        //             Container(
                        //                 height: 3,
                        //                 width: 80,
                        //                 color: selectedTab == index
                        //                     ? primary
                        //                     : gray)
                        //           ]),
                        //         );
                        //       }),
                        // ),
                        // Obx(() {
                        //   var data = selectedTab != 0
                        //       ? storeController.storesList.value
                        //       : storeController.storeListNearYou.value;
                        //   if (storeController.isLoading.value)
                        //     return Center(child: CircularProgressIndicator());
                        //   else
                        //     return Container(
                        //       //color: Colors.white,
                        //       margin:
                        //           const EdgeInsets.only(left: 16, right: 10),
                        //       child: ListView.builder(
                        //           itemCount: selectedTab == 0
                        //               ? storeController.storeListNearYou.length
                        //               : storeController.storesList.length,
                        //           shrinkWrap: true,
                        //           itemBuilder:
                        //               (BuildContext context, int index) {
                        //             return GestureDetector(
                        //               onTap: () => _showModelButtonSheet(
                        //                   context, data[index]),
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     color: white,
                        //                     borderRadius:
                        //                         BorderRadius.circular(8.0)),
                        //                 padding: const EdgeInsets.only(
                        //                     left: 13, right: 0),
                        //                 margin: const EdgeInsets.only(
                        //                     top: 12, right: 10),
                        //                 child: Row(children: [
                        //                   Container(
                        //                       padding: const EdgeInsets.only(
                        //                           top: 10, bottom: 10),
                        //                       child: ClipRRect(
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   5.0),
                        //                           child: Image.asset(
                        //                               'assets/images/store' +
                        //                                   (data[index]
                        //                                           .id
                        //                                           .toString())
                        //                                       .toString() +
                        //                                   '.jpg',
                        //                               height: 60,
                        //                               width: 60))),
                        //                   Container(
                        //                       padding: const EdgeInsets.only(
                        //                           left: 10.0, right: 0),
                        //                       child: Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment.start,
                        //                           children: [
                        //                             Container(
                        //                               child: Text(
                        //                                   storeController
                        //                                       .storesList[index]
                        //                                       .name,
                        //                                   style: TextStyle(
                        //                                       fontSize: 11,
                        //                                       fontWeight:
                        //                                           FontWeight
                        //                                               .w700,
                        //                                       color: gray)),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 3,
                        //                             ),
                        //                             Container(
                        //                                 width:
                        //                                     size.width - 130.0,
                        //                                 child: Row(
                        //                                   children: [
                        //                                     Flexible(
                        //                                       child: Text(
                        //                                           data[index]
                        //                                               .address,
                        //                                           style: TextStyle(
                        //                                               fontSize:
                        //                                                   12)),
                        //                                     )
                        //                                   ],
                        //                                 )),
                        //                             SizedBox(
                        //                               height: 12,
                        //                             ),
                        //                             Container(
                        //                               child: Text(
                        //                                   "Cách khoảng đây " +
                        //                                       UtilsCommon.getAddress(
                        //                                               data[index]
                        //                                                   .latitude,
                        //                                               data[index]
                        //                                                   .longitude,
                        //                                               storeController
                        //                                                   .latitude
                        //                                                   .value,
                        //                                               storeController
                        //                                                   .longitude
                        //                                                   .value)
                        //                                           .round()
                        //                                           .toString() +
                        //                                       "km",
                        //                                   style: TextStyle(
                        //                                       fontSize: 12,
                        //                                       color: gray)),
                        //                             )
                        //                           ]))
                        //                 ]),
                        //               ),
                        //             );
                        //           }),
                        //     );
                        // })
                      ]),
                ),
              ],
            )),
          )),
    );
  }
}
