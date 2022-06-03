import 'dart:async';

import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/models/store.dart';
import 'package:at_coffee/screens/products_page/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:at_coffee/common/utils_common/utils_common.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key key}) : super(key: key);

  @override
  _RatePage createState() => _RatePage();
}

class _RatePage extends State<RatePage> {
  List<String> listTab = ["Chưa đánh giá", "Đã đánh giá"];
  int selectedTab = 0;

  final RateController rateController = Get.put(RateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setStateValue(value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      rateController.fetchRateByUser();
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
                          child: const Text("Đánh giá của bạn",
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
                              top: 10, left: 20, right: 10),
                          height: 38,
                          child: ListView.builder(
                              itemCount: listTab.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    setStateValue(index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: selectedTab == index
                                                ? primary
                                                : gray,
                                            width: 1.25),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(listTab[index],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: selectedTab == index
                                                    ? primary
                                                    : gray,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 3),
                                        // check đánh giá
                                        index == 0
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: red2),
                                                child: const SizedBox(
                                                    height: 8, width: 8))
                                            : const Text("")
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        // Obx(() {
                        //   if (billController.isLoading.value) {
                        //     return const Center(
                        //         child: CircularProgressIndicator());
                        //   } else {
                        //     var data = billController.billsList
                        //         .where((element) =>
                        //             element.status == indexCategory)
                        //         .toList();

                        //     return ListView.builder(
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         itemCount: data.length,
                        //         shrinkWrap: true,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return GestureDetector(
                        //               onTap: () {
                        //                 Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             DetailOrderPage(
                        //                                 bill: data[index])));
                        //               },
                        //               child: Container(
                        //                 height: 140.0,
                        //                 padding: const EdgeInsets.only(
                        //                     left: 20.0, right: 0.0),
                        //                 child: SizedBox(
                        //                     height: size.width,
                        //                     width: size.width,
                        //                     child: Stack(
                        //                       children: [
                        //                         Positioned(
                        //                           top: 20.0,
                        //                           left: 70.0,
                        //                           child: Container(
                        //                             padding:
                        //                                 const EdgeInsets.only(
                        //                                     left: 50.0,
                        //                                     right: 10.0,
                        //                                     top: 5.0,
                        //                                     bottom: 5.0),
                        //                             decoration: BoxDecoration(
                        //                               color: primary,
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       20),
                        //                             ),
                        //                             height: 100.0,
                        //                             width: size.width - 110.0,
                        //                             child: Column(
                        //                               children: [
                        //                                 Container(
                        //                                     alignment: Alignment
                        //                                         .centerLeft,
                        //                                     child: Text(
                        //                                         "${data[index].billDetails[0].quantity} x " +
                        //                                             productController
                        //                                                 .allProducts
                        //                                                 .where((item) =>
                        //                                                     item.id ==
                        //                                                     data[index]
                        //                                                         .billDetails[
                        //                                                             0]
                        //                                                         .productId)
                        //                                                 .toList()[
                        //                                                     0]
                        //                                                 .name,
                        //                                         style: const TextStyle(
                        //                                             fontSize:
                        //                                                 16,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .bold,
                        //                                             color: Colors
                        //                                                 .white))),
                        //                                 const SizedBox(
                        //                                   height: 6,
                        //                                 ),
                        //                                 Row(children: [
                        //                                   data[index]
                        //                                               .billDetails[
                        //                                                   0]
                        //                                               .discount >
                        //                                           0
                        //                                       ? Text(
                        //                                           oCcy
                        //                                               .format(data[index]
                        //                                                       .billDetails[
                        //                                                           0]
                        //                                                       .price *
                        //                                                   data[index]
                        //                                                       .billDetails[
                        //                                                           0]
                        //                                                       .quantity)
                        //                                               .toString(),
                        //                                           style: const TextStyle(
                        //                                               fontSize:
                        //                                                   14,
                        //                                               fontWeight:
                        //                                                   FontWeight
                        //                                                       .bold,
                        //                                               color:
                        //                                                   black,
                        //                                               decoration:
                        //                                                   TextDecoration
                        //                                                       .lineThrough))
                        //                                       : const Text(""),
                        //                                   Text(
                        //                                       " " +
                        //                                           oCcy
                        //                                               .format(data[
                        //                                                       index]
                        //                                                   .billDetails[
                        //                                                       0]
                        //                                                   .amount)
                        //                                               .toString(),
                        //                                       style: const TextStyle(
                        //                                           fontSize: 14,
                        //                                           fontWeight:
                        //                                               FontWeight
                        //                                                   .bold,
                        //                                           color:
                        //                                               lightYellow)),
                        //                                 ]),
                        //                                 const SizedBox(
                        //                                   height: 6,
                        //                                 ),
                        //                                 Row(
                        //                                     mainAxisAlignment:
                        //                                         MainAxisAlignment
                        //                                             .end,
                        //                                     crossAxisAlignment:
                        //                                         CrossAxisAlignment
                        //                                             .end,
                        //                                     children: [
                        //                                       Text(
                        //                                           '${data[index].billDetails.length} sản phẩm' +
                        //                                               " - " +
                        //                                               oCcy
                        //                                                   .format(data[index]
                        //                                                       .amount)
                        //                                                   .toString(),
                        //                                           style: const TextStyle(
                        //                                               fontSize:
                        //                                                   14,
                        //                                               fontWeight:
                        //                                                   FontWeight
                        //                                                       .bold,
                        //                                               color:
                        //                                                   lightYellow))
                        //                                     ]),
                        //                                 const SizedBox(
                        //                                   height: 8,
                        //                                 ),
                        //                                 GestureDetector(
                        //                                   onTap: () {},
                        //                                   child: Row(
                        //                                     mainAxisAlignment:
                        //                                         MainAxisAlignment
                        //                                             .end,
                        //                                     children: [
                        //                                       Text(">>>>> Xem chi tiết",
                        //                                           style: TextStyle(
                        //                                               color: Colors
                        //                                                       .grey[
                        //                                                   800],
                        //                                               fontSize:
                        //                                                   12,
                        //                                               fontWeight:
                        //                                                   FontWeight
                        //                                                       .bold,
                        //                                               fontStyle:
                        //                                                   FontStyle
                        //                                                       .italic)),
                        //                                     ],
                        //                                   ),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           ),
                        //                         ),
                        //                         Container(
                        //                           height: 110.0,
                        //                           width: 110.0,
                        //                           decoration: BoxDecoration(
                        //                             color: lightYellow,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     10),
                        //                           ),
                        //                           child: ClipRRect(
                        //                               borderRadius: BorderRadius.circular(
                        //                                   10),
                        //                               child: Image.network(
                        //                                   productController.allProducts
                        //                                       .where((item) =>
                        //                                           item.id ==
                        //                                           data[index]
                        //                                               .billDetails[
                        //                                                   0]
                        //                                               .productId)
                        //                                       .toList()[0]
                        //                                       .image,
                        //                                   fit: BoxFit.contain,
                        //                                   errorBuilder: (BuildContext context,
                        //                                       Object exception,
                        //                                       StackTrace stackTrace) {
                        //                                 return const Text('😢');
                        //                               }, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                        //                                 if (loadingProgress ==
                        //                                     null) {
                        //                                   return child;
                        //                                 } else {
                        //                                   return Center(
                        //                                     child:
                        //                                         CircularProgressIndicator(
                        //                                       value: loadingProgress
                        //                                                   .expectedTotalBytes !=
                        //                                               null
                        //                                           ? loadingProgress
                        //                                                   .cumulativeBytesLoaded /
                        //                                               loadingProgress
                        //                                                   .expectedTotalBytes
                        //                                           : null,
                        //                                     ),
                        //                                   );
                        //                                 }
                        //                               })),
                        //                         ),
                        //                       ],
                        //                     )),
                        //               ));
                        //         });
                        //   }
                        // })
                      ]),
                ),
              ],
            )),
          )),
    );
  }

  void _showModelButtonSheet(BuildContext context, Store item) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Positioned(
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                child: Image.asset('assets/images/store1.jpg',
                                    // height: 100,
                                    width: MediaQuery.of(context).size.width)),
                          ),
                          Positioned(
                              right: 10,
                              top: 20,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    height: 26,
                                    width: 26,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(bottom: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: const Text("x",
                                        style: TextStyle(fontSize: 20))),
                              )),
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Text("AT Coffee",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]))),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(item.address,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16, top: 6),
                          child: Text(
                              "Giờ mở cửa: " +
                                  item.timeOpen +
                                  " - " +
                                  item.timeClose,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[800]))),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          color: Colors.grey[300],
                          child: SizedBox(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width)),
                      GestureDetector(
                        onTap: () => _launchMapsUrl(item.address),
                        child: Container(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(6)),
                                    child: const Icon(CupertinoIcons.location,
                                        size: 15)),
                                Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(item.address,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black))),
                              ],
                            )),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          color: Colors.grey[300],
                          child: SizedBox(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width)),
                      //Favourite store
                      // GestureDetector(
                      //   //onTap: () => _launchMapsUrl(item.address),
                      //   child: Container(
                      //       padding: const EdgeInsets.only(left: 16, top: 16),
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //               padding: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                   color: Colors.grey[200],
                      //                   borderRadius: BorderRadius.circular(6)),
                      //               child:
                      //                   Icon(CupertinoIcons.heart, size: 15)),
                      //           Container(
                      //               padding: EdgeInsets.only(left: 5),
                      //               child: Text("Cửa hàng yêu thích",
                      //                   style: TextStyle(
                      //                       fontSize: 14,
                      //                       color: Colors.black))),
                      //         ],
                      //       )),
                      // ),
                      // Container(
                      //     margin: EdgeInsets.only(top: 16),
                      //     color: Colors.grey[300],
                      //     child: SizedBox(
                      //         height: 0.5,
                      //         width: MediaQuery.of(context).size.width)),
                      GestureDetector(
                        onTap: () => _makePhoneCall(),
                        child: Container(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(6)),
                                    child: const Icon(CupertinoIcons.phone,
                                        size: 15)),
                                Container(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: const Text("Liên hệ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black))),
                              ],
                            )),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16),
                          color: Colors.grey[300],
                          child: SizedBox(
                              height: 0.5,
                              width: MediaQuery.of(context).size.width)),
                    ],
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () => _orderHere(item),
              //   child: Container(
              //     padding: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //         color: primary, borderRadius: BorderRadius.circular(8)),
              //     child: Column(
              //       children: const [
              //         Text("Đặt hàng",
              //             style: TextStyle(
              //                 color: white,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w700)),
              //         Text("Tự đến lấy tại cửa hàng này",
              //             style: TextStyle(color: white, fontSize: 13)),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  // Future<void> _orderHere(Store store) async {
  //   storeController.setSeleted(1);
  //   storeController.updateMyStoreNearYou(store);
  //   Get.to(() => const ProductsPage());
  // }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0346279377',
    );
    await launchUrl(launchUri);
  }

  void _launchMapsUrl(location) async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = 'https://www.google.com/maps/search/?api=1&query=$location';
    var myUrl = Uri.encodeFull(uri);
    //print(Uri.parse(myUrl));
    if (await canLaunchUrl(Uri.parse(myUrl))) {
      await launchUrl(Uri.parse(myUrl));
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
      throw 'Could not launch $myUrl';
    }
  }
}
