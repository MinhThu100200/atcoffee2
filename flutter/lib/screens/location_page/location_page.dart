import 'dart:async';

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

class LocationPage extends StatefulWidget {
  const LocationPage({Key key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<String> listTab = ["Gần đây", "Tất cả"];
  Timer _timer;

  int selectedTab = 0;

  final StoreController storeController = Get.put(StoreController());

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
                      child: const Text("Cửa hàng",
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
                          height: 50,
                          child: ListView.builder(
                              itemCount: listTab.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    // if (selectedTab == 0)
                                    //   storeController.getStoreListNearYou();
                                    setStateValue(index);
                                  },
                                  child: Column(children: [
                                    Text(listTab[index],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: selectedTab == index
                                                ? primary
                                                : gray,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 5),
                                    Container(
                                        height: 3,
                                        width: 80,
                                        color: selectedTab == index
                                            ? primary
                                            : gray)
                                  ]),
                                );
                              }),
                        ),
                        Obx(() {
                          var data = selectedTab != 0
                              ? storeController.storesList.value
                              : storeController.storeListNearYou.value;
                          if (storeController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            return Container(
                              //color: Colors.white,
                              margin:
                                  const EdgeInsets.only(left: 16, right: 10),
                              child: ListView.builder(
                                  itemCount: selectedTab == 0
                                      ? storeController.storeListNearYou.length
                                      : storeController.storesList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () => _showModelButtonSheet(
                                          context, data[index]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        padding: const EdgeInsets.only(
                                            left: 13, right: 0),
                                        margin: const EdgeInsets.only(
                                            top: 12, right: 10),
                                        child: Row(children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  child: Image.asset(
                                                      'assets/images/store' +
                                                          (data[index]
                                                                  .id
                                                                  .toString())
                                                              .toString() +
                                                          '.jpg',
                                                      height: 60,
                                                      width: 60))),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 0),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        storeController
                                                            .storesList[index]
                                                            .name,
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                            color: gray)),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            size.width - 130.0,
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                  data[index]
                                                                      .address,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                            )
                                                          ],
                                                        )),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                        "Cách khoảng đây " +
                                                            UtilsCommon.getAddress(
                                                                    data[index]
                                                                        .latitude,
                                                                    data[index]
                                                                        .longitude,
                                                                    storeController
                                                                        .latitude
                                                                        .value,
                                                                    storeController
                                                                        .longitude
                                                                        .value)
                                                                .round()
                                                                .toString() +
                                                            "km",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: gray))
                                                  ]))
                                        ]),
                                      ),
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
                        child: Image.asset(
                            'assets/images/store1.jpg',
                            // height: 100,
                            width: MediaQuery.of(context)
                                .size
                                .width)),
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
                                child:
                                    const Icon(CupertinoIcons.phone, size: 15)),
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
              GestureDetector(
                onTap: () => _orderHere(item),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: const [
                      Text("Đặt hàng",
                          style: TextStyle(
                              color: white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                      Text("Tự đến lấy tại cửa hàng này",
                          style: TextStyle(color: white, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _orderHere(Store store) async{
    //print(store.address);
    storeController.setSeleted(1);
    storeController.updateMyStoreNearYou(store);
    Get.to(() => const ProductsPage());
  }

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '0346279377',
    );
    await launchUrl(launchUri);
  }

  void _launchMapsUrl(location) async {
    _timer?.cancel();
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = 'https://www.google.com/maps/search/?api=1&query=$location';
    var myUrl = Uri.encodeFull(uri);
    //print(Uri.parse(myUrl));
    if (await canLaunchUrl(Uri.parse(myUrl))) {
      await launchUrl(Uri.parse(myUrl));
      _timer?.cancel();
      await EasyLoading.dismiss();
    } else {
      _timer?.cancel();
      await EasyLoading.dismiss();
      throw 'Could not launch $myUrl';
    }
  }
}
