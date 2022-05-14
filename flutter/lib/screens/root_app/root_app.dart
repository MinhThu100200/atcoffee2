import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// common
import 'package:at_coffee/common/theme/colors.dart';
// screens
import 'package:at_coffee/screens/location_page/location_page.dart';
import 'package:at_coffee/screens/products_page/products_page.dart';
import 'package:at_coffee/screens/reward_page/reward_page.dart';
import 'package:at_coffee/screens/profile_page/profile_page.dart';
import 'package:at_coffee/screens/home_page/home_page.dart';
// controllers
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/screens/test_location.dart';
import 'package:at_coffee/controllers/user_controller.dart';

class RootApp extends StatefulWidget {
  RootApp({Key key, this.nameRoute}) : super(key: key);
  String nameRoute;

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  // get carts
  final cartController = Get.put(CartController());
  int pageIndex = 0;
  String _nameRoute;

  void getIndex(nameRoute) {
    switch (widget.nameRoute) {
      case 'home':
        setStatePageIndex(0);
        break;
      case 'reward':
        setStatePageIndex(1);
        break;
      case 'location':
        setStatePageIndex(2);
        break;
      case 'notification':
        setStatePageIndex(3);
        break;
      default:
        setStatePageIndex(4);
        break;
    }
  }

  void setStatePageIndex(value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void initState() {
    getIndex(widget.nameRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody(BuildContext context) {
    return IndexedStack(
      index: pageIndex,
      children: [
        //ProductsPage(),
        HomePage(),
        RewardPage(),
        LocationPage(),
        // CartPage(),
        // Center(
        //   child: Text("Notification Page"),
        // ),
        GetUserLocation(),
        ProfilePage(),
        // Center(
        //   child: Text("Personal Page"),
        // ),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home_filled,
      CupertinoIcons.gift,
      Icons.add,
      Icons.notifications,
      Icons.account_circle
    ];
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        border:
            Border(top: BorderSide(width: 1, color: black.withOpacity(0.06))),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: Column(
                children: [
                  Icon(
                    items[index],
                    size: 28,
                    color: pageIndex == index ? primary : black,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  pageIndex == index
                      ? Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: primary, shape: BoxShape.circle),
                        )
                      : Container()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
