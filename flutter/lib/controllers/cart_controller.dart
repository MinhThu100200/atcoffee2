import 'package:at_coffee/models/promotion.dart';
import 'package:at_coffee/models/reward.dart';
import 'package:at_coffee/models/cart.dart';
import 'package:at_coffee/services/service_cart.dart';
import 'package:at_coffee/controllers/user_controller.dart';
import 'package:at_coffee/controllers/type_controller.dart';
import 'package:get/get.dart';

class _TotalCart {
  int amount;
  int promotion;
  bool isValidPromotion = true;
  int totalAmount;
  int quantity;
  _TotalCart(
      {this.amount,
      this.promotion,
      this.isValidPromotion,
      this.totalAmount,
      this.quantity});
}

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartsList = <Cart>[].obs;
  var promotion = Promotion().obs;
  var reward = Reward().obs;
  // khi nhấn "Thêm" tại giỏ hàng
  var isAdd = false.obs;
  // 0 - Mang đi; 1 - Giao tận nơi
  var indexSelectedOrder = 0.obs;
  // 0 - none; 1 - promotion; 2 - reward
  var type = 0.obs;
  var amount = 0.0.obs;

  var totalCart = _TotalCart().obs;

  final userController = Get.put(UserController());
  final typeController = Get.put(TypeController());

  @override
  void onInit() {
    totalCart.value.isValidPromotion = true;
    super.onInit();
  }

  void fetchCartsByCustomerId(id) async {
    try {
      isLoading.value = true;
      var carts = await RemoteServices.fetchCartsByCustomerId(id);
      if (carts != null) {
        cartsList.value = carts;
        calcTotalCart();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<Cart> addCart(Cart cart) async {
    try {
      isLoading.value = true;
      cart = await RemoteServices.addCart(cart);
      if (cart != null) {
        cartsList.add(cart);
        calcTotalCart();
        return cart;
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Cart> updateCart(Cart cart) async {
    try {
      // isLoading.value = true;
      // update in list
      Cart prevCart = Cart.fromJson(cart.toJson());
      var index = cartsList.indexWhere((c) => c.id == cart.id);
      cartsList[index] = cart;
      calcTotalCart();
      // update in database
      cart = await RemoteServices.updateCart(cart);
      if (cart != null) {
        return cart;
      } else {
        // rollback in list
        var prevIndex = cartsList.indexWhere((c) => c.id == prevCart.id);
        cartsList[prevIndex] = prevCart;
        calcTotalCart();
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCart(int cartId) async {
    print(cartId);
    try {
      // isLoading.value = true;
      // remove in list
      Cart prevCart =
          Cart.fromJson(cartsList.firstWhere((c) => c.id == cartId).toJson());
      var index = cartsList.indexWhere((c) => c.id == cartId);
      cartsList.value = cartsList.where((c) => c.id != cartId).toList();
      calcTotalCart();
      // remove in database
      bool isDeleted = await RemoteServices.deleteCart(cartId);
      if (isDeleted) {
        return true;
      } else {
        // rollback list
        cartsList.insert(index, prevCart);
        calcTotalCart();
      }
      return isDeleted;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteCartByUserId(int userId) async {
    try {
      // isLoading.value = true;
      // remove list
      var prevCarts = cartFromJson(cartToJson(cartsList));
      cartsList.removeRange(0, cartsList.length);
      calcTotalCart();
      cancelApply();
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
      isLoading.value = false;
    }
  }

  Future<bool> deleteCartPayment() async {
    try {
      // isLoading.value = true;
      List<int> ids = <int>[];
      for (var cart in cartsList) {
        if (cart.state == true) {
          ids.add(cart.id);
        }
      }
      // remove list
      var prevCarts = cartFromJson(cartToJson(cartsList));
      cartsList.value = cartsList.where((c) => c.state == false).toList();
      calcTotalCart();
      bool isDeleted = await RemoteServices.deleteCartPayment(ids);
      if (isDeleted) {
        cartsList.removeWhere((c) => ids.contains(c.id));
        return true;
      } else {
        // rollback list
        cartsList.value = prevCarts;
        calcTotalCart();
      }
      return isDeleted;
    } finally {
      isLoading.value = false;
    }
  }

  void applyPromotion(Promotion p) {
    promotion.value = p;
    reward.value = Reward();
    type.value = 1;
    calcTotalCart();
  }

  void applyReward(Reward r) {
    reward.value = r;
    promotion.value = Promotion();
    type.value = 2;
    calcTotalCart();
  }

  void cancelApply() {
    promotion.value = Promotion();
    reward.value = Reward();
    type.value = 0;
    calcTotalCart();
  }

  void calcTotalCart() {
    calcQuantity();
    calcAmount();
    calcPromotion();
    calcTotalAmount();
  }

  void calcQuantity() {
    totalCart.value.quantity = cartsList
        .where((c) => c.state == true)
        .fold(0, (sum, item) => sum + item.quantity);
  }

  void calcPromotion() {
    totalCart.value.isValidPromotion = true;
    if (cartsList.isEmpty) {
      totalCart.value.promotion = 0;
      return;
    }
    double promotionValue = 0;

    switch (type.value) {
      case 0:
        break;
      case 1:
        if (_validPromotion(promotion.value)) {
          promotionValue =
              totalCart.value.amount * promotion.value.discount / 100;
        } else {
          totalCart.value.isValidPromotion = false;
        }
        break;
      case 2:
        if (_validReward(reward.value)) {
          promotionValue = reward.value.redution.toDouble();
        } else {
          totalCart.value.isValidPromotion = false;
        }
        break;
    }
    totalCart.value.promotion = promotionValue.toInt();
  }

  void calcAmount() {
    if (cartsList.isEmpty) {
      totalCart.value.amount = 0;
      return;
    }

    double amount = 0;
    for (int i = 0; i < cartsList.length; i++) {
      if (cartsList[i].state == true) {
        amount += (cartsList[i]
                        .product
                        .sizes[cartsList[i].size == 'S'
                            ? 0
                            : cartsList[i].size == 'M'
                                ? 1
                                : 2]
                        .price *
                    (1 - cartsList[i].product.discount / 100))
                .toInt() *
            cartsList[i].quantity;
      }
    }
    totalCart.value.amount = amount.toInt();
  }

  void calcTotalAmount() {
    int amounts = totalCart.value.amount - totalCart.value.promotion;
    amounts = amounts < 0 ? 0 : amounts;
    totalCart.value.totalAmount = amounts.toInt();
  }

  bool _validPromotion(Promotion promotion) {
    if (promotion.proviso > totalCart.value.amount) {
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
