import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:get/get.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'
    show Placemark, placemarkFromCoordinates;
import 'package:location/location.dart';
import 'package:at_coffee/common/utils_common/utils_common.dart';

class LocationStore extends StatefulWidget {
  @override
  _locationStoreState createState() => _locationStoreState();
}

class _locationStoreState extends State<LocationStore> {
  List<String> listTab = ["Gần đây", "Tất cả"];

  int selectedTab = 0;

  final StoreController storeController = Get.put(StoreController());

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
                          child: Text("Cửa hàng",
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
                                    SizedBox(height: 5),
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
                          if (storeController.isLoading.value)
                            return Center(child: CircularProgressIndicator());
                          else
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
                                    return InkWell(
                                      onTap: () {
                                        storeController
                                            .updateMyStoreNearYou(data[index]);
                                        Get.back();
                                      },
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
                                                    Container(
                                                      child: Text(
                                                          storeController
                                                              .storesList[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: gray)),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Container(
                                                        width:
                                                            size.width - 130.0,
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                  data[index]
                                                                      .address,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                            )
                                                          ],
                                                        )),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    Container(
                                                      child: Text(
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
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: gray)),
                                                    )
                                                  ]))
                                        ]),
                                      ),
                                    );
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
