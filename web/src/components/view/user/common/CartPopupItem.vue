<template>
  <div class="cart-item">
    <div class="cart-item-header">
      <div class="image">
        <img :src="cart.product.image"/>
      </div>
    </div>
    <div class="cart-item-body">
      <span class="name">{{cart.product.name}}</span>
    </div>
    <div class="cart-item-footer">
      <span>{{formatPrice(getPrice())}}</span>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

export default {
  name: Constants.COMPONENT_NAME_CART_POPUP_ITEM_USER,

  props: ['cart'],

  methods: {
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    getPrice() {
      var size = this.cart.size == 'S' ? this.cart.product.sizes[0] : this.cart.size == 'M' ? this.cart.product.sizes[1] : this.cart.product.sizes[2];
      return size.price * (1 - this.cart.product.discount / 100);
    }
  },

  created() {
    console.log(this.cart);
  }
}
</script>

<style scoped>
.cart-item {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  padding: 8px;
  /* border-bottom: 1px solid #ccc; */
}

.cart-item .cart-item-header .image{
  width: 60px;
  height: 60px;
  border-radius: 4px;
  background: var(--primaryBackground);
  padding: 8px;
}

.cart-item .cart-item-header .image img{
  width: 100%;
  height: 100%;
}

.cart-item .cart-item-body{
  flex: 1;
  padding: 0 8px;
  display: flex;
  flex-direction: column;
}

.cart-item .cart-item-body .name{
  color: var(--primary);
  font-weight: bold;
  font-size: 14px;
}
</style>