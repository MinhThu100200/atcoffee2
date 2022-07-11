import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/controllers/reward_controller.dart';
import 'package:at_coffee/controllers/promotion_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({Key key}) : super(key: key);

  @override
  _RewardPage createState() => _RewardPage();
}

class _RewardPage extends State<RewardPage> {
  RewardController rewardController = Get.put(RewardController());
  PromotionController promotionController = Get.put(PromotionController());
  final UserController userController = Get.put(UserController());
  final TypeController typeController = Get.put(TypeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: lightGray3,
        body: Container(
          color: primary,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              SizedBox(
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
                        child: const Text("Ưu đãi",
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
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15),
                            child: const Text("Khuyến mãi",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))),
                        // Container(
                        //     margin: const EdgeInsets.only(
                        //         top: 15, left: 15, right: 15),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: Container(
                        //           //color: primary,
                        //           padding: const EdgeInsets.only(
                        //               top: 8, left: 5, right: 5, bottom: 8),
                        //           decoration: BoxDecoration(
                        //               color: Colors.green[100],
                        //               borderRadius: BorderRadius.circular(8)),
                        //           child: const Text("Xem tất cả",
                        //               style: TextStyle(
                        //                   color: primary,
                        //                   fontWeight: FontWeight.w600))),
                        //     ))
                      ],
                    ),
                    Obx(() {
                      if (promotionController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                promotionController.promotionsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return checkExpired(
                                      promotionController.promotionsList[index])
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 5.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Card(
                                                  margin: const EdgeInsets.only(
                                                      right: 1.0),
                                                  child: SizedBox(
                                                    height: 90,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        15),
                                                            child: Text(
                                                                promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .description,
                                                                maxLines: 4,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: _validPromotion(promotionController.promotionsList[
                                                                            index])
                                                                        ? black
                                                                        : Colors
                                                                            .grey[500]))),
                                                        Expanded(
                                                            child: Container(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 15,
                                                                    right: 15.0,
                                                                    bottom: 10),
                                                                child: Text(
                                                                    'Hết hạn ' +
                                                                        DateFormat('dd/MM/yyyy')
                                                                            .format(DateTime.fromMillisecondsSinceEpoch((promotionController.promotionsList[index].endDate)
                                                                                .toInt()))
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: _validPromotion(promotionController.promotionsList[index])
                                                                            ? black
                                                                            : Colors.grey[500])))),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Card(
                                              margin: const EdgeInsets.only(
                                                  left: 1.0),
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10.0,
                                                      bottom: 10.0,
                                                      left: 10.0,
                                                      right: 10.0),
                                                  height: 70,
                                                  width: 70,
                                                  color: _validPromotion(
                                                          promotionController
                                                                  .promotionsList[
                                                              index])
                                                      ? lightYellow
                                                      : Colors.grey[400],
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4.0,
                                                            vertical: 4.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 2.0,
                                                                vertical: 4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.0),
                                                          color: _validPromotion(
                                                                  promotionController
                                                                          .promotionsList[
                                                                      index])
                                                              ? const Color(
                                                                  0xffe5b06c)
                                                              : Colors
                                                                  .grey[500],
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(
                                                                Icons
                                                                    .coffee_sharp,
                                                                size: 10,
                                                                color: black),
                                                            Text("A&T Coffee",
                                                                style: TextStyle(
                                                                    fontSize: 8,
                                                                    color:
                                                                        white)),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2),
                                                        child: Text(
                                                            promotionController
                                                                    .promotionsList[
                                                                        index]
                                                                    .discount
                                                                    .toString() +
                                                                "%",
                                                            style: const TextStyle(
                                                                fontSize: 33,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: white)),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            });
                      }
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
                        // Container(
                        //     margin: const EdgeInsets.only(
                        //         top: 15, left: 15, right: 15),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: Container(
                        //           //color: primary,
                        //           padding: const EdgeInsets.only(
                        //               top: 8, left: 5, right: 5, bottom: 8),
                        //           decoration: BoxDecoration(
                        //               color: Colors.green[100],
                        //               borderRadius: BorderRadius.circular(8)),
                        //           child: const Text("Xem tất cả",
                        //               style: TextStyle(
                        //                   color: primary,
                        //                   fontWeight: FontWeight.w600))),
                        //     ))
                      ],
                    ),
                    Obx(() {
                      if (rewardController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: rewardController.rewardsList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                            margin: const EdgeInsets.only(
                                                right: 1.0),
                                            child: SizedBox(
                                              height: 90,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15,
                                                          vertical: 15),
                                                      child: Text(
                                                          rewardController
                                                              .rewardsList[
                                                                  index]
                                                              .name,
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: _validReward(
                                                                      rewardController
                                                                              .rewardsList[
                                                                          index])
                                                                  ? black
                                                                  : Colors.grey[
                                                                      500]))),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Card(
                                        margin:
                                            const EdgeInsets.only(left: 1.0),
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            height: 70,
                                            width: 70,
                                            color: _validReward(rewardController
                                                    .rewardsList[index])
                                                ? lightYellow
                                                : Colors.grey[400],
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 4.0),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 2.0,
                                                      vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    color: _validReward(
                                                            rewardController
                                                                    .rewardsList[
                                                                index])
                                                        ? const Color(
                                                            0xffe5b06c)
                                                        : Colors.grey[500],
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons.coffee_sharp,
                                                          size: 10,
                                                          color: black),
                                                      Text("A&T Coffee",
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              color: white)),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                      (rewardController
                                                                      .rewardsList[
                                                                          index]
                                                                      .redution ~/
                                                                  1000)
                                                              .toString() +
                                                          'K',
                                                      style: const TextStyle(
                                                          fontSize: 33,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: white)),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }),
                  ]))
            ]),
          )),
        ));
  }

  bool checkExpired(item) {
    int milis = DateTime.now().millisecondsSinceEpoch;
    //print(item.endDate.toString() + ' ' + milis.toString());
    if (item.endDate > milis) {
      return true;
    }
    return false;
  }

  bool _validPromotion(Promotion promotion) {
    bool isValid = false;

    try {
      isValid = userController.user.value.typeId <
          typeController.typesList
              .firstWhere((type) => type.code == promotion.object)
              .id;
    } catch (e) {
      return false;
    }

    if (userController.user.value.typeId == null || isValid) {
      return false;
    }
    return true;
  }

  bool _validReward(Reward reward) {
    if (userController.user.value.currentPoints < reward.proviso) {
      return false;
    }
    return true;
  }
}
