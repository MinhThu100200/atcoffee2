import 'package:flutter/material.dart';
import 'package:at_coffee/screens/login_page/login_page.dart';
import 'package:at_coffee/screens/signup_page/sign_up_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'avenir'),
      home: onboarding(),
    );
  }
}

class onboarding extends StatefulWidget {
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  PageController _pageController =
      new PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("onboard1", "Nhận ưu đãi hấp dẫn",
                        "Cập nhật liên tục ưu đãi một cách nhanh chóng <3"),
                    onBoardPage("onboard2", "Mọi lúc mọi nơi",
                        'Đặt món bất kể khi nào và nơi đâu'),
                    onBoardPage("onboard3", "Trải nghiệm khác biệt",
                        'Tận hưởng những trãi nghiệm của riêng bạn'),
                  ],
                  onPageChanged: (value) => {setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 420,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/path.png'),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: openLoginPage,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 9),
                                blurRadius: 20,
                                spreadRadius: 3)
                          ]),
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: openSignUp,
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer getIndicator(int pageNo) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey),
    );
  }

  Column onBoardPage(String img, String title, String content) {
    String uriAnimation = (img == 'onboard1'
        ? 'assets/animations/gift.json'
        : img == 'onboard2'
            ? 'assets/animations/comportable.json'
            : 'assets/animations/cool.json');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Lottie.asset(
              uriAnimation,
              height: 150,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  setCurrentPage(int value) {
    currentPage = value;
    setState(() {});
  }

  openSignUp() {
    Get.to(() => SignUpPage());
  }

  openLoginPage() {
    Get.to(() => LoginPage());
  }
}
