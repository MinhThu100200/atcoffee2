<template>
  <div class="col-lg-2 col-md-6 col-sm-6 col-12 col-custom">
    <div class="card card-product-1" @click="handleShowSelect">
      <div class="card-icon">
        <img :src="product.image"/>
      </div>
      <div class="card-wrap">
        <div class="card-header">
          <h4>{{product.name}}</h4>
        </div>
        <div class="card-body" v-if="product.discount == 0">
          {{formatPrice(product.sizes[0].price)}}
        </div>
        <div class="card-body flex" v-else>
          <div id="triangle-right">
              <span>{{product.discount}}%</span>
          </div>
          <span v-html="processPrice(product.sizes[0].price)"></span>
          {{formatPrice(product.sizes[0].price * (1 - product.discount / 100))}}
        </div>
      </div>
    </div>
    <select-popup :isSelectPopup="isSelectPopup" :quantity="quantity" :size="size" class="select-popup-item"
    @handleHide="handleHideSelect" @handleChange="handleChangeQuantity" @handleChangeSize="handleChangeSize" @handleSubmit="handleSubmit"></select-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import SelectPopup from '../popup/SelectPopup.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCTS_ITEM,

  props: ['product'],

  components: {
    SelectPopup
  },

  data(){
    return {
      isSelectPopup: false,
      quantity: 1,
      size: 'S'
    }
  },

  methods: {

    handleHideSelect() {
      this.isSelectPopup = false;
      this.quantity = 1;
      this.size = 'S';
    },

    handleShowSelect() {
      this.isSelectPopup = true;
    },

    handleChangeQuantity(quantity) {
      this.quantity = quantity;
    },

    handleChangeSize(size) {
      this.size = size;
    },

    handleSubmit() {
      var price = this.size == 'S' ? this.product.sizes[0].price : this.size == 'M' ? this.product.sizes[1].price : this.product.sizes[2].price;
      var amount = price * this.quantity * (1 - this.product.discount / 100);
      var cart = {
        name: this.product.name,
        productId: this.product.id,
        quantity: this.quantity,
        size: this.size,
        price: price,
        amount: amount,
        discount: this.product.discount,
        description: '',
      };
      this.$store.commit(MutationsName.MUTATION_NAME_ADD_CART, cart);
      this.handleHideSelect();
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    }
  }
}
</script>

<style>
.col-lg-2.col-custom {
  position: relative;
  cursor: pointer;
  flex: 0 20%;
  /* max-width: auto; */
  min-width: 280px;
}

.card.card-product-1 {
  display: inline-block;
  width: 100%;
}

.card.card-product-1 .card-icon{

  width: 80px;
  height: 80px;
  margin: 10px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-product-1 .card-icon img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 3px;
  margin-left: 0px;
}

.card.card-product-1 .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-top: 25px;
  padding-bottom: 4px;
}

.card.card-product-1 .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 14px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #37A372;
}

.card.card-product-1 .card-body {
  font-weight: 700;
  color: #34395e;
  padding-bottom: 0px;
  padding-top: 0px;
  font-size: 16px;
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

#triangle-right {
  position: absolute;
  top: 0px;
  right: 0px;
	width: 0;
  height: 0;
  border-top-right-radius: .25rem;
  -webkit-border-top-right-radius: .25rem;
  -moz-border-top-right-radius: .25rem;
  border-top: 40px solid orange;
  border-left: 40px solid transparent;
}

#triangle-right span {
  position: absolute;
  font-size: 14px;
  top: -36px;
  right: 0px;
  color: #fff;
  transform: rotateZ(45deg);
}

.select-popup-item {
  position: absolute;
  top: -20px;
  right: 40px;
}
</style>