import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:get/state_manager.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/services/service_cart.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartsList = new List<Cart>().obs;
  var promotion = new Promotion().obs;
  var reward = new Reward().obs;
  // khi nhấn "Thêm" tại giỏ hàng
  var isAdd = false.obs;
  // 0 - Mang đi; 1 - Giao tận nơi
  var indexSelectedOrder = 0.obs;
  // 0 - none; 1 - promotion; 2 - reward
  var type = 0.obs;

  var total =
      {"amount": 0, "promotion": 0, "totalAmount": 0, "quantity": 0}.obs;

  void calcTotal() {
    total["quantity"] = cartsList
        .where((c) => c.state == true)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  final userController = Get.put(UserController());
  final typeController = Get.put(TypeController());

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

  Future<Cart> addCart(Cart cart) async {
    try {
      isLoading(true);
      cart = await RemoteServices.addCart(cart);
      if (cart != null) {
        cartsList.add(cart);
        return cart;
      }
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<Cart> updateCart(Cart cart) async {
    try {
      // update in list
      Cart prevCart = Cart.fromJson(cart.toJson());
      var index = cartsList.indexWhere((c) => c.id == cart.id);
      cartsList[index] = cart;
      // update in database
      cart = await RemoteServices.updateCart(cart);
      if (cart != null) {
        return cart;
      } else {
        // rollback in list
        var prevIndex = cartsList.indexWhere((c) => c.id == prevCart.id);
        cartsList[prevIndex] = prevCart;
      }
      return null;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCart(int cartId) async {
    try {
      // remove in list
      Cart prevCart =
          Cart.fromJson(cartsList.firstWhere((c) => c.id != cartId).toJson());
      var index = cartsList.indexWhere((c) => c.id == cartId);
      cartsList.value = cartsList.where((c) => c.id != cartId).toList();
      // remove in database
      bool isDeleted = await RemoteServices.deleteCart(cartId);
      if (isDeleted) {
        return true;
      } else {
        // rollback list
        cartsList.insert(index, prevCart);
      }
      return isDeleted;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteCartByUserId(int userId) async {
    try {
      // remove list
      var prevCarts = cartFromJson(cartToJson(cartsList));
      cartsList.removeRange(0, cartsList.length);
      // remove in database
      bool isDeleted = await RemoteServices.deleteCartByUserId(userId);
      if (isDeleted) {
        return true;
      } else {
        //rollback list
        cartsList.value = prevCarts;
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
        return true;
      }
      return isDeleted;
    } finally {
      isLoading(false);
    }
  }

  double _calPromotion(carts) {
    if (carts == null || carts.length == 0) {
      total["promotion"] = 0.toInt();
      return 0;
    }
    double promotionValue = 0;

    switch (type.value) {
      case 0:
        break;
      case 1:
        if (_validPromotion(promotion.value)) {
          promotionValue = total["amount"] * promotion.value.discount / 100;
        }
        break;
      case 2:
        if (_validReward(reward.value)) {
          promotionValue = reward.value.redution.toDouble();
        }
        break;
    }
    total["promotion"] = promotionValue.toInt();
    return promotionValue;
  }

  double _calAmount(carts) {
    if (carts == null || carts.length == 0) {
      return 0;
    }

    double amount = 0;
    for (int i = 0; i < carts.length; i++) {
      if (carts[i].state == true) {
        amount += (carts[i]
                        .product
                        .sizes[carts[i].size == 'S'
                            ? 0
                            : carts[i].size == 'M'
                                ? 1
                                : 2]
                        .price *
                    (1 - carts[i].product.discount / 100))
                .toInt() *
            carts[i].quantity;
      }
    }
    total["amount"] = amount.toInt();
    return amount;
  }

  double calTotalAmount(carts) {
    isLoading(true);
    double amount = _calAmount(carts) - _calPromotion(carts);
    amount = amount < 0 ? 0 : amount;
    total["totalAmount"] = amount.toInt();
    isLoading(false);
    return amount;
  }

  bool _validPromotion(Promotion promotion) {
    if (promotion.proviso > total["amount"]) {
      return false;
    }

    if (userController.user.value.typeId == null ||
        userController.user.value.typeId <
            typeController.typesList
                .firstWhere((type) => type.code == promotion.object)
                .id) {
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
