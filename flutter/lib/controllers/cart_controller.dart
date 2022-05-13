import 'package:get/state_manager.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/services/service_cart.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartsList = new List<Cart>().obs;

  var total =
      {"amount": 0, "promotion": 0, "totalAmount": 0, "quantity": 0}.obs;

  void calcTotal() {
    total["quantity"] = cartsList
        .where((c) => c.state == true)
        .fold(0, (sum, item) => sum + item.quantity);
  }

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
        calcTotal();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Cart> updateCart(Cart cart) async {
    try {
      cart = await RemoteServices.updateCart(cart);
      if (cart != null) {
        var index = cartsList.indexWhere((c) => c.id == cart.id);
        cartsList[index].state = cart.state;
        calcTotal();
        return cart;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<Cart> addCart(Cart cart) async {
    try {
      isLoading(true);
      cart = await RemoteServices.addCart(cart);
      if (cart != null) {
        cartsList.add(cart);
        calcTotal();
        return cart;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCart(int cartId) async {
    try {
      bool isDeleted = await RemoteServices.deleteCart(cartId);
      if (isDeleted) {
        cartsList.removeWhere((c) => c.id == cartId);
        calcTotal();
      }
      return isDeleted;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCartByUserId(int userId) async {
    try {
      bool isDeleted = await RemoteServices.deleteCartByUserId(userId);
      if (isDeleted) {
        cartsList.value = new List<Cart>();
        calcTotal();
      }
      return isDeleted;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCartPayment(List<int> ids) async {
    try {
      bool isDeleted = await RemoteServices.deleteCartPayment(ids);
      if (isDeleted) {
        cartsList.removeWhere((c) => ids.contains(c.id));
        calcTotal();
      }
      return isDeleted;
    } finally {
      isLoading(false);
    }
  }
}
