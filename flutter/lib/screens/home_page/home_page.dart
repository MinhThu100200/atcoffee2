import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/store_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  List<String> listTab = ["Gần đây", "Tất cả"];

  //int selectedTab = 0;

  //final StoreController storeController = Get.put(StoreController());

  void setStateValue(value) {
    //selectedTab = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGray3,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: SafeArea(
              child: Container(
                color: primary,
                child: Column(
                  children: [
                    Container(
                        child: SizedBox(
                      width: size.width,
                      child: Stack(alignment: Alignment.centerLeft, children: [
                        // Positioned(
                        //   child: IconButton(
                        //       icon: const Icon(
                        //         Icons.arrow_back,
                        //         color: Colors.white,
                        //       ),
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //       }),
                        // ),

                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 5),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Xin chào, Minh Thư !!!",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ]),
                    )),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 12),
                      child: Text("Trang chủ",
                          style: TextStyle(
                              color: white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 20,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 110,
                                    width: size.width - 40,
                                    decoration: BoxDecoration(
                                        color: pink,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 90,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Image.asset(
                                                      'assets/icons/reward-cup.png'),
                                                ),
                                                Positioned(
                                                    left: 30,
                                                    top: 47,
                                                    child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                transparentBlack,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Text('120',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))))
                                              ],
                                            )),
                                        Container(
                                          width: size.width - 130,
                                          decoration: BoxDecoration(
                                              color: lightPink,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(top: 16),
                                                  child: Text(
                                                      "Phần thưởng khả dụng",
                                                      style: TextStyle(
                                                          color: primary,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .w800))),
                                              SizedBox(height: 6),
                                              Container(
                                                  height: 48,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: 34, right: 34),
                                                  decoration: BoxDecoration(
                                                      color: primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Text(
                                                      "Chưa đạt phần thưởng",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text("Đặt hàng online",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800))),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: size.width / 2 - 40,
                                    width: size.width / 2 - 30,
                                    decoration: BoxDecoration(
                                        color: lightGreen2,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                              'assets/icons/delivery-man.png'),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: 10, left: 8),
                                                child: Text("Delivery",
                                                    style: TextStyle(
                                                        color: primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 8, right: 5),
                                          child: Text(
                                              "Giao hàng tận nơi đến địa chỉ của bạn",
                                              maxLines: 2,
                                              style: TextStyle(
                                                //color: primary,
                                                fontSize: 13,
                                              )),
                                        ),
                                      ],
                                    )),
                                Container(
                                    alignment: Alignment.center,
                                    height: size.width / 2 - 40,
                                    width: size.width / 2 - 30,
                                    decoration: BoxDecoration(
                                        color: lightGreen2,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 80,
                                          margin: const EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                              'assets/images/strawberry-background.png'),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding:
                                                    EdgeInsets.only(left: 8),
                                                child: Text("Take away",
                                                    style: TextStyle(
                                                        color: primary,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 5, left: 8, right: 5),
                                          child: Text(
                                              "Đặt trước và nhận đồ tại cửa hàng bạn chọn",
                                              maxLines: 2,
                                              style: TextStyle(
                                                //color: primary,
                                                fontSize: 13,
                                              )),
                                        ),
                                      ],
                                    )),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            )),
          ),
          Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 5, left: 10, right: 10),
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: lightGreen2,
                              borderRadius: BorderRadius.circular(14)),
                          height: 30,
                          padding: const EdgeInsets.all(3),
                          child: Image.asset('assets/icons/delivery-man.png')),
                      SizedBox(width: 5),
                      Text("Giao đến",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: gray3))
                    ],
                  ),
                  SizedBox(height: 6),
                  Text("1 Võ Văn Ngân, thành phố Hồ Chí Minh",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                ],
              ))
        ],
      ),
    );
  }
}
