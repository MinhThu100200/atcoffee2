import 'package:at_coffee/controllers/bill_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/rate_controller.dart';
import 'package:at_coffee/screens/rate_page/detail_order_rate.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key key}) : super(key: key);

  @override
  _RatePage createState() => _RatePage();
}

class _RatePage extends State<RatePage> {
  List<String> listTab = ["Chưa đánh giá", "Đã đánh giá"];
  int selectedTab = 0;

  final RateController rateController = Get.put(RateController());
  final ProductController productController = Get.put(ProductController());
  final BillController billController = Get.put(BillController());
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
    final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      rateController.fetchRateByUser();
    });

    return Scaffold(
      backgroundColor: white,
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
                      color: white),
                  child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
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
                                    width: size.width / 2,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(listTab[index],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: selectedTab == index
                                                    ? primary
                                                    : gray,
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 3),
                                        index == 0 &&
                                                billController.billsList
                                                    .where((element) =>
                                                        element.status ==
                                                            'COMPLETED' &&
                                                        element.rate)
                                                    .toList()
                                                    .isNotEmpty
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
                        const SizedBox(height: 5),
                        listTab[selectedTab] == "Đã đánh giá"
                            ? Obx(() {
                                if (rateController.isLoading.value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return ListView.builder(
                                      //itemCount: storeController.storesList.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          rateController.rateByUser.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          color: Colors.white70,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Column(
                                            children: [
                                              Container(
                                                //color: lightGray3,
                                                margin: const EdgeInsets.only(
                                                    top: 3),
                                                padding: const EdgeInsets.only(
                                                  left: 13,
                                                  right: 0,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  //bottom: 20,
                                                                  left: 16),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              child: Image.asset(
                                                                  'assets/icons/profile.png',
                                                                  height: 22,
                                                                  width: 22))),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 10,
                                                                bottom: 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "User " +
                                                                    rateController
                                                                        .rateByUser[
                                                                            index]
                                                                        .userId
                                                                        .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color:
                                                                        gray)),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                    const SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: Text(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                                  rateController
                                                                      .rateByUser[
                                                                          index]
                                                                      .createdDate)
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      11)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: Text(
                                                          "★★★★★".substring(
                                                                0,
                                                                rateController
                                                                    .rateByUser[
                                                                        index]
                                                                    .star
                                                                    .toInt(),
                                                              ) +
                                                              "☆☆☆☆☆".substring(
                                                                  rateController
                                                                      .rateByUser[
                                                                          index]
                                                                      .star
                                                                      .toInt(),
                                                                  5),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  yellowDark)),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 16),
                                                      child: Text(
                                                          rateController
                                                              .rateByUser[index]
                                                              .comment
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  color: gray)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(children: [
                                                Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: lightYellow,
                                                      // border: Border.all(
                                                      //     color:
                                                      //         lightGreen2)
                                                    ),
                                                    margin: const EdgeInsets.only(
                                                        left: 30, right: 3),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10),
                                                        child: Image.network(productController.allProducts.where((item) => item.id == rateController.rateByUser[index].productId).toList()[0].image,
                                                            fit: BoxFit.contain,
                                                            errorBuilder:
                                                                (BuildContext context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace
                                                                        stackTrace) {
                                                          return const Text(
                                                              '😢');
                                                        }, loadingBuilder:
                                                                (BuildContext context,
                                                                    Widget child,
                                                                    ImageChunkEvent loadingProgress) {
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
                                                        }))),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  height: 40,
                                                  width: size.width - 105,
                                                  decoration: const BoxDecoration(
                                                      //color: Colors.grey[300]
                                                      ),
                                                  child: Text(productController
                                                      .allProducts
                                                      .where((item) =>
                                                          item.id ==
                                                          rateController
                                                              .rateByUser[index]
                                                              .productId)
                                                      .toList()[0]
                                                      .name),
                                                ),
                                              ]),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  color: Colors.grey[300],
                                                  child: SizedBox(
                                                    height: 0.75,
                                                    width: size.width,
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }
                              })
                            : Obx(() {
                                if (billController.isLoading.value) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  var data = billController.billsList
                                      .where((element) =>
                                          element.status == 'COMPLETED' &&
                                          element.rate)
                                      .toList();
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailOrderRatePage(
                                                              bill: data[
                                                                  index])));
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
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 50.0,
                                                                  right: 10.0,
                                                                  top: 5.0,
                                                                  bottom: 5.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          height: 100.0,
                                                          width: size.width -
                                                              110.0,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                      "${data[index].billDetails[0].quantity} x ${data[index].billDetails[0].name}",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.white))),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Row(children: [
                                                                data[index]
                                                                            .billDetails[
                                                                                0]
                                                                            .discount >
                                                                        0
                                                                    ? Text(oCcy.format(data[index].billDetails[0].price * data[index].billDetails[0].quantity).toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                black,
                                                                            decoration: TextDecoration
                                                                                .lineThrough))
                                                                    : const Text(
                                                                        ""),
                                                                Text(
                                                                    " " +
                                                                        oCcy
                                                                            .format(data[index]
                                                                                .billDetails[
                                                                                    0]
                                                                                .amount)
                                                                            .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
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
                                                                                FontWeight.bold,
                                                                            color: lightYellow))
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
                                                                      ">>>>> Đánh giá",
                                                                      style: TextStyle(
                                                                          color: Colors.grey[
                                                                              800],
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontStyle:
                                                                              FontStyle.italic)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 110.0,
                                                        width: 110.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: lightYellow,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10),
                                                            child: Image.network(
                                                                productController
                                                                    .allProducts
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
                                                              return const Text(
                                                                  '😢');
                                                            }, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              } else {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
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
                                            ));
                                      });
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
