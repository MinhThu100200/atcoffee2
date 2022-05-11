import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ticketview/ticketview.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/reward_controller.dart';
import 'package:at_coffee/controllers/promotion_controller.dart';

class RewardPage extends StatefulWidget {
  RewardPage({Key key}) : super(key: key);

  @override
  _RewardPage createState() => _RewardPage();
}

class _RewardPage extends State<RewardPage> {
  RewardController rewardController = Get.put(new RewardController());
  PromotionController promotionController = Get.put(new PromotionController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightGray3,
        body: Container(
          color: primary,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(children: [
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Ưu đãi",
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: Text("Khuyến mãi",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  //color: primary,
                                  padding: EdgeInsets.only(
                                      top: 8, left: 5, right: 5, bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Xem tất cả",
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.w600))),
                            ))
                      ],
                    ),
                    Obx(() {
                      if (promotionController.isLoading.value)
                        return Center(child: CircularProgressIndicator());
                      else
                        return Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  promotionController.promotionsList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return checkExpired(promotionController
                                        .promotionsList[index])
                                    ? TicketView(
                                        backgroundColor: primary,
                                        child: Container(
                                          //margin: EdgeInsets.only(),
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 200,
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                          promotionController
                                                              .promotionsList[
                                                                  index]
                                                              .description,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              fontSize: 13))),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 13),
                                                  height: 70,
                                                  width: 70,
                                                  color: lightYellow,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .coffee_sharp,
                                                                size: 11),
                                                            Text("A&T Coffee",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 7),
                                                        child: Text(
                                                            promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .discount
                                                                    .toString() +
                                                                "%",
                                                            style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: white)),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container();
                              }),
                        );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: const Text("Quà tặng hội viên",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                  //color: primary,
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 5, right: 5, bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("Xem tất cả",
                                      style: TextStyle(
                                          color: primary,
                                          fontWeight: FontWeight.w600))),
                            ))
                      ],
                    ),
                    Obx(() {
                      if (promotionController.isLoading.value)
                        return Center(child: CircularProgressIndicator());
                      else
                        return Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  promotionController.promotionsList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return checkExpired(promotionController
                                        .promotionsList[index])
                                    ? TicketView(
                                        backgroundColor: primary,
                                        child: Container(
                                          //margin: EdgeInsets.only(),
                                          height: 100,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 200,
                                                      padding: EdgeInsets.only(
                                                          left: 12),
                                                      child: Text(
                                                          promotionController
                                                              .promotionsList[
                                                                  index]
                                                              .description,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              fontSize: 13))),
                                                ],
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 13),
                                                  height: 70,
                                                  width: 70,
                                                  color: lightYellow,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .coffee_sharp,
                                                                size: 11),
                                                            Text("A&T Coffee",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 7),
                                                        child: Text(
                                                            promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .discount
                                                                    .toString() +
                                                                "%",
                                                            style: TextStyle(
                                                                fontSize: 35,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: white)),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container();
                              }),
                        );
                    }),
                  ]))
            ]),
          )),
        ));
  }

  bool checkExpired(item) {
    int milis = DateTime.now().millisecondsSinceEpoch;
    print(item.endDate.toString() + ' ' + milis.toString());
    if (item.endDate > milis) {
      return true;
    }
    return false;
  }
}
