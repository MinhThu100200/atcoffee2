<template>
  <div class="cart-popup">
    <div class="cart-header">
        Giỏ hàng
    </div>
    <div class="cart-body">
      <div class="cart-items" v-if="$store.getters.carts?.length > 0">
        <cart-popup-item v-for="(cart, index) in $store.getters.carts" :key="index" :cart="cart"></cart-popup-item>
      </div>
      <div class="cart-items empty" v-else>
          Chưa có sản phẩm nào được chọn
        </div>
    </div>
    <div class="cart-footer">

    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CartPopupItem from '../common/CartPopupItem.vue'

export default {
  name: Constants.COMPONENT_NAME_CART_POPUP_USER,

  components: {
    CartPopupItem
  }
}
</script>

<style scoped>
.cart-popup {
  position: absolute;
  width: 300px;
  height: 400px;
  background: #fff;
  right: 0;
  box-shadow: 0px 0px 12px rgba(0, 0, 0, 0.3);
  border-radius: 4px;
}

.cart-popup .cart-header {
  color: #333;
  font-weight: 600;
  padding-bottom: 18px;
  margin-top: 8px;
  padding: 8px 12px;
}
</style>