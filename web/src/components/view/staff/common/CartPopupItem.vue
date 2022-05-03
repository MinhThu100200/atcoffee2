<template>
  <div class="col-custom">
    <div class="card card-product-1" :class="$route.path.includes('payment') ? 'payment' : ''" @click="handleShowSelect">
      <div class="card-icon">
        <img :src="product.image"/>
      </div>
      <div class="card-wrap">
        <div class="card-header">
          <h4>{{product.name}}</h4>
        </div>
        <div class="card-body flex">
          <span>{{formatPrice(cart.price)}}</span> &emsp;
          <span>x{{cart.quantity}}</span> &emsp;
          <span>{{cart.size}}</span>&emsp;
          <span v-if="cart.discount > 0" class="discount">-{{cart.discount}}%</span>
          <span class="flex-1 text-right"> {{formatPrice(cart.amount)}}</span>
        </div>
      </div>
    </div>
    <select-cart-popup :isSelectCartPopup="isSelectCartPopup" :quantity="quantity" :size="size" class="select-popup-item"
    @handleHide="handleHideSelect" @handleChange="handleChangeQuantity" @handleChangeSize="handleChangeSize" 
    @handleRemove="handleRemove" @handleSubmit="handleSubmit"></select-cart-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import ProductCommand from '../../../command/ProductCommand'
import SelectCartPopup from '../popup/SelectCartPopup.vue'

export default {
  name: Constants.COMPONENT_NAME_CART_POPUP_ITEM,

  props: ['cart'],

  components: {
    SelectCartPopup
  },

  data(){
    return {
      isSelectCartPopup: false,
      product: {},
      quantity: 1,
      size: 'S'
    }
  },
  
  methods: {

    handleHideSelect() {
      this.isSelectCartPopup = false;
      this.quantity = this.cart.quantity;
      this.size = this.cart.size;
    },

    handleShowSelect() {
      this.isSelectCartPopup = true;
    },

    handleChangeQuantity(quantity) {
      this.quantity = quantity;
    },

    handleChangeSize(size) {
      this.size = size;
    },

    handleRemove() {
      this.$store.commit(MutationsName.MUTATION_NAME_REMOVE_CART, this.cart);
      this.isSelectCartPopup = false;
    },

    handleSubmit() {
      var preCart = {...this.cart};
      var price = this.size == 'S' ? this.product.sizes[0].price : this.size == 'M' ? this.product.sizes[1].price : this.product.sizes[2].price;
      var amount = price * this.quantity * (1 - this.product.discount / 100);
      var nextCart = {...this.cart, size: this.size, quantity: this.quantity, price, amount};
      this.$store.commit(MutationsName.MUTATION_NAME_UPDATE_CART, {preCart, nextCart});
      this.isSelectCartPopup = false;
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    },

    async loadProduct() {
      this.product = await ProductCommand.findOne(this.cart.productId);
    }
  },

  renderTriggered({key, target}) {
    if (key == 'isSelectCartPopup' && target.isSelectCartPopup) {
      this.quantity = this.cart.quantity;
      this.size = this.cart.size;
    }
  },

  created() {
    this.quantity = this.cart.quantity;
    this.size = this.cart.size;
    this.loadProduct();
  }
}
</script>

<style scoped>
.col-custom {
  position: relative;
  cursor: pointer;
  /* max-width: auto; */
  min-width: 280px;
  transition: all .3s;
}

.card.card-product-1 {
  display: inline-block;
  width: 100%;
  margin-bottom: 12px;
  padding-left: 8px;
}

.card.card-product-1 .card-icon{
  width: 40px;
  height: 40px;
  margin: 4px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-product-1 .card-icon img {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 3px;
  margin-left: 0px;
}

.card.card-product-1 .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-top: 4px;
  padding-bottom: 4px;
}

.card.card-product-1 .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 13px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #37A372;
}

.card.card-product-1 .card-body {
  font-weight: 700;
  color: #34395e;
  padding-bottom: 0px;
  padding-top: 0px;
  font-size: 14px;
}

.card.card-product-1 .card-body.flex {
  display: flex !important;
  justify-content: left;
  padding: 0;
}

.card.card-product-1 .card-body.flex .decoration-line{
  text-decoration: line-through;
  color: lightcoral;
  margin-right: 8px;
}

.select-popup-item {
  position: absolute;
  top: -60px;
  right: 40px;
}

.flex-1 {
  flex: 1 !important;
}

.text-right {
  text-align: right;
  padding-right: 20px;
}

.card.card-product-1.payment {
  display: inline-block;
  width: 100%;
  margin-bottom: 12px;
  padding-left: 8px;
}

.card.card-product-1.payment .card-icon{
  width: 60px;
  height: 60px;
  margin: 4px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-product-1.payment .card-icon img {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 3px;
  margin-left: 0px;
}

.card.card-product-1.payment .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-top: 12px;
  padding-bottom: 4px;
}

.card.card-product-1.payment .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 14px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #37A372;
}

</style>