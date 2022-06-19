<template>
  <div class="col-lg-3 col-md-6 col-6 mb-30 product-item">
    <a href="#" class="image">
      <span class="promotion" v-if="product.discount != 0">
        <span>
          {{product.discount}}%
        </span>
      </span>
      <img :src="product.image"/>
    </a>
    <a href="#" class="name">{{product.name}}</a>
    <span class="price">
      <span v-html="processPrice(product.sizes[0].price)"></span>
        {{formatPrice(product.sizes[0].price * (1 - product.discount / 100))}}
    </span>
    <i class="fa-solid fa-moped"></i>


  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_ITEM_USER,

  props: ['product'],

  methods: {
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    }
  }
}
</script>

<style scoped>

.product-item {
  padding: 8px;
  padding-bottom: 40px;
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
  font-weight: 500;
  font-size: 16px;
  width: 100%;
  color: #555
}

.price:hover {
  color: #555
}

.price >>> .decoration-line{
  text-decoration: line-through;
  color: lightcoral;
  margin-right: 8px;
}

a {
  color: #000 ;
  transition: all 0.2s ease-in-out;
}

a:hover{
  cursor: pointer;
  color: var(--primary);
}

</style>