import 'package:get/state_manager.dart';
import 'package:at_coffee/models/product.dart';
import 'package:at_coffee/services/service_product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productsList = List<Product>().obs;
  var productsSuggestion = List<Product>().obs;

  @override
  void onInit() {
    //fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productsList.value = products;
        print("sản phẩm");
        print(products);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByCategory(cate) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProductsByCategory(cate);
      if (products != null) {
        productsList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchProductSuggest(customerId, size) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProductSuggest(customerId, size);
      if (products != null) {
        productsSuggestion.value = products;
        print("suggest");
        print(products);
      }
    } finally {
      isLoading(false);
    }
  }
}
