import 'package:at_coffee/screens/notification_page/notification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// common
import 'package:at_coffee/common/theme/colors.dart';
// screens
import 'package:at_coffee/screens/location_page/location_page.dart';
import 'package:at_coffee/screens/reward_page/reward_page.dart';
import 'package:at_coffee/screens/profile_page/profile_page.dart';
import 'package:at_coffee/screens/home_page/home_page.dart';
// controllers
import 'package:at_coffee/controllers/cart_controller.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';
import 'package:at_coffee/controllers/reward_controller.dart';
import 'package:at_coffee/controllers/payment_controller.dart';

class RootApp extends StatefulWidget {
  RootApp({Key key, this.nameRoute}) : super(key: key);
  String nameRoute;

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  // get carts
  final cartController = Get.put(CartController());
  final TypeController typeController = Get.put(TypeController());
  final UserController userController = Get.put(UserController());
  final RewardController rewardController = Get.put(RewardController());
  final PaymentController paymentController = Get.put(PaymentController());

  int pageIndex = 0;

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
    cartController.fetchCartsByCustomerId(userController.user.value.id);
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
      children: const [
        HomePage(),
        RewardPage(),
        LocationPage(),
        NotificationPage(),
        ProfilePage(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home_filled,
      CupertinoIcons.gift,
      Icons.storefront_sharp,
      Icons.notifications,
      Icons.account_circle
    ];
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: white,
        border:
            Border(top: BorderSide(width: 1, color: black.withOpacity(0.06))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
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
