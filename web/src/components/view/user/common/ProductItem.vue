<template>
  <div v-if="product != null" class="col-lg-3 col-md-6 col-6 mb-30 product-item">
    <router-link :to="'/product?id=' + product.id" class="image">
      <span class="promotion" v-if="product.discount != 0">
        <span>
          {{product.discount}}%
        </span>
      </span>
      <img :src="product.image"/>
    </router-link>
    <router-link :to="'/product?id=' + product.id" class="name">{{product.name}}</router-link>
    <span class="price">
      <span>{{formatPrice(product.sizes[0].price * (1 - product.discount / 100))}} &nbsp;</span>
      <span v-if="product.discount > 0" v-html="processPrice(product.sizes[0].price)"></span>
      <span class="b-icons">
        <span class="b-icon-container heart" @click="handleToggleFavourite">
          <b-icon-heart-fill v-if="product.favourited" class="b-icon heart active"/>
          <b-icon-heart v-else class="b-icon heart"/>
        </span>
        <span class="b-icon-container cart">
          <b-icon-cart-plus-fill class="b-icon cart"/>
        </span>
      </span>
    </span>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import ProductCommand from '../../../command/ProductCommand'
import {BIconHeart, BIconHeartFill, BIconCartPlusFill} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_ITEM_USER,

  props: ['product'],

  components: {
    BIconCartPlusFill,
    BIconHeart,
    BIconHeartFill
  },

  methods: {
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    },

    async handleToggleFavourite() {
      if (this.checkLogon()) {
        if (!this.product.favourited) {
          await ProductCommand.addFavourite(this.product, this.$store);
        } else {
          await ProductCommand.removeFavourite(this.product, this.$store);
        }
      }
      
    },

    checkLogon() {
      if (this.$store.getters.user != null) {
        return true;
      }

      if (confirm("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục.")) {
        this.$router.push({path: '/login'});
      }
    }
  }
}
</script>

<style scoped>

.product-item {
  position: relative;
  padding: 8px;
  padding-bottom: 32px;
}

a.image {
  /* position: relative; */
  width: 100%;
  height: 100%;
}

a.image .promotion {
  position: absolute;
  top: 6px;
  right: 6px;
	width: 0;
  height: 0;
  border-top-right-radius: 8px;
  -webkit-border-top-right-radius: 8px;
  -moz-border-top-right-radius: 8px;
  border-top: 50px solid orange;
  border-left: 50px solid transparent;
  z-index: 10;
}

a.image .promotion span {
  position: absolute;
  top: -42px;
  right: 0px;
  font-size: 14px;
  color: #fff;
  transform: rotateZ(45deg);
  font-weight: bold;
}

a.image img{
  background-color: #d3ebcd;
  border-radius: 8px;
  padding: 8%;
  width: 100%;
  object-fit: cover;
  box-shadow: 0px 0px 8px 0px #00000040;
  margin-bottom: 12px;
}

a.name {
  font-weight: 600;
  font-size: 16px;
  display: flex;
}

.price {
  display:flex;
  flex-wrap: wrap;
  align-items: center;
  font-weight: 600;
  font-size: 16px;
  width: 100%;
  color: var(--primary);
}

.price:deep(.decoration-line){
  text-decoration: line-through;
  color: #555;
  margin-right: 8px;
  font-size: 14px;
  font-weight: 500;
}

a {
  color: #000 ;
  transition: all 0.2s ease-in-out;
}

a:hover{
  cursor: pointer;
  color: var(--primary);
}

.b-icons {
  flex: 1;
  text-align: right;
  display: flex;
  justify-content: flex-end; 
}

.b-icon-container {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  width: 28px;
  height: 28px;
  margin-left: 4px;
  border-radius: 50%;
  cursor: pointer;
}

.b-icon-container.heart {
  background-color: #fdeddc;
}

.b-icon-container.cart {
  background-color: var(--primary);
}

.b-icon.heart {
  color: #f7a754;
}

.b-icon.cart {
  color: #fff;
}
</style>