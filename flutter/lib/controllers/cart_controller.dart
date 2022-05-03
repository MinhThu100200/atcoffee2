import 'package:get/state_manager.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/services/service_cart.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartsList = new List<Cart>().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchCartsByCustomerId(id) async {
    try {
      isLoading(true);
      var carts = await RemoteServices.fetchCartsByCustomerId(id);
      if (carts != null) {
        cartsList.value = carts;
      }
    } finally {
      isLoading(false);
    }
  }
}
