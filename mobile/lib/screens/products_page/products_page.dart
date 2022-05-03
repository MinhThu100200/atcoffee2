import 'package:at_coffee/controllers/category_controller.dart';
import 'package:at_coffee/controllers/product_controller.dart';
import 'package:at_coffee/controllers/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:at_coffee/common/theme/colors.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/screens/products_page/product_item.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);
  @override
  _ProductsPage createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  final oCcy = NumberFormat.currency(locale: 'vi', symbol: 'đ');
  int indexCategory = 0;
  var nameImage = [
    "assets/images/coffee.png",
    "assets/images/bubble-tea.png",
    "assets/images/smoothie.png"
  ];
  var codeCategory = ['COFFEE', 'MILKTEA', 'JUICE'];

  void setStateValue(value) {
    indexCategory = value;
    setState(() {});
  }

  final CategoryController categoryController = Get.put(CategoryController());
  // final StoreController storeController = Get.put(StoreController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      productController.fetchProductsByCategory(codeCategory[0]);
      //print("Build Completed");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          color: primary,
          child: SafeArea(
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
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Sản phẩm",
                            style: TextStyle(
                                color: white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
                )),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white1,
                  ),
                  child: const Text("A&T Coffee",
                      style: TextStyle(fontSize: 18, color: primary)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: white),
                    child: Obx(() {
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            height: 70,
                            child: Center(
                              child: ListView.builder(
                                itemCount:
                                    categoryController.categoriesList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setStateValue(index);
                                      productController.fetchProductsByCategory(
                                          codeCategory[index]);
                                    }, 
                                    child: Container(
                                      //width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: indexCategory == index
                                            ? primary
                                            : lightGray3,
                                      ),
                                      margin: const EdgeInsets.only(
                                          right: 15, bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 32,
                                            padding: EdgeInsets.only(
                                              top: index == 0 ? 8 : 5,
                                              bottom: 5,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: indexCategory == index
                                                    ? lightGreen
                                                    : lightGreen2),
                                            child: Image.asset(
                                                nameImage[index].toString(),
                                                //height: index == 0 ? 30 : 50,
                                                fit: BoxFit.fitHeight),
                                          ),
                                          Text(
                                              categoryController
                                                  .categoriesList[index].name,
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Obx(() {
                            if (productController.isLoading.value)
                              return Center(child: CircularProgressIndicator());
                            else
                              return Expanded(
                                child: Container(
                                  child: ListView.builder(
                                      itemCount:
                                          productController.productsList.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ProductItem(
                                            product: productController
                                                .productsList[index]);
                                      }),
                                ),
                              );
                          })
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
