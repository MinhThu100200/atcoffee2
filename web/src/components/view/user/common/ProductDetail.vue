<template>
  <div class="container bootdey">
        <div class="col-md-12">
            <section class="panel">
                <div class="panel-body col-md-12 flex">
                    <div class="col-md-5 col-md">
                        <div class="pro-img-details">
                            <img :src="product.image" alt="">
                        </div>
                    </div>
                    <div class="col-md-7 col-md">
                        <h4 class="pro-d-title">
                            <span>{{product.name}}</span>
                        </h4>
                        <p>
                            {{product.description}}
                        </p>
                        
                        <div v-if="product.sizes?.length > 0" class="m-bot15 price">
                          <span>{{formatPrice(product.sizes[0].price * (1 - product.discount / 100))}} &nbsp;</span>
                          <span v-if="product.discount > 0" v-html="processPrice(product.sizes[0].price)"></span>
                          <span class="discount" v-if="product.discount > 0">giảm {{product.discount}}%</span>
                        </div>
                        
                        <div class="form-group">
                            <label>Quantity</label>
                            <input type="quantiy" placeholder="1" class="form-control quantity">
                        </div>
                        <p>
                            <button class="btn btn-round btn-danger" type="button"><i class="fa fa-shopping-cart"></i> Add to Cart</button>
                        </p>
                    </div>
                </div>
            </section>
        </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

import ProductCommand from '../../../command/ProductCommand'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_DETAIL_USER,

  data() {
    return {
      product: {
        code: '',
        name: '',
        description: '',
        discount: 0,
        categories: [], 
        stores: [],
        sizes: []
      },
      id: 0
    }
  },

  methods: {
    
    async init(){
      this.id = this.$route.query.id;
      if (typeof this.id == 'undefined') {
        this.id = 0;
      }

      await this.loadProduct(this.id);
    },

    async loadProduct(id) {
      this.product = await ProductCommand.findOne(id);
      console.log(this.product);
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    }
  },

  created() {
    console.log('created');
    this.init();
  }
}
</script>

<style scoped>

body{
    margin-top:20px;
    background:#eee;
}

.flex {
    display: flex;
    flex-wrap: wrap;
}

/*panel*/
.panel {
    border: none;
    box-shadow: none;
    margin-bottom: 20px;
    background-color: #fff;
    border-radius: 4px;
}

.panel-heading {
    border-color:#eff2f7 ;
    font-size: 16px;
    font-weight: 300;
}

.panel-body {
    padding: 15px;
}

.panel-title {
    color: #2A3542;
    font-size: 14px;
    font-weight: 400;
    margin-bottom: 0;
    margin-top: 0;
    font-family: 'Open Sans', sans-serif;
}

/*product list*/

.prod-cat li a{
    border-bottom: 1px dashed #d9d9d9;
}

.prod-cat li a {
    color: #3b3b3b;
}

.prod-cat li ul {
    margin-left: 30px;
}

.prod-cat li ul li a{
    border-bottom:none;
}
.prod-cat li ul li a:hover,.prod-cat li ul li a:focus, .prod-cat li ul li.active a , .prod-cat li a:hover,.prod-cat li a:focus, .prod-cat li a.active{
    background: none;
    color: #ff7261;
}

.pro-lab{
    margin-right: 20px;
    font-weight: normal;
}

.pro-sort {
    padding-right: 20px;
    float: left;
}

.pro-page-list {
    margin: 5px 0 0 0;
}

.product-list img{
    width: 100%;
    border-radius: 4px 4px 0 0;
    -webkit-border-radius: 4px 4px 0 0;
}

.product-list .pro-img-box {
    position: relative;
}
.adtocart {
    background: #fc5959;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    -webkit-border-radius: 50%;
    color: #fff;
    display: inline-block;
    text-align: center;
    border: 3px solid #fff;
    left: 45%;
    bottom: -25px;
    position: absolute;
}

.adtocart i{
    color: #fff;
    font-size: 25px;
    line-height: 42px;
}

.pro-title {
    color: #5A5A5A;
    display: inline-block;
    margin-top: 20px;
    font-size: 16px;
}

.product-list .price {
    color:#fc5959 ;
    font-size: 15px;
}

.col-md {
    position: relative;
    min-height: 1px;
    padding-left: 15px;
    padding-right: 15px;
    padding-top: 15px;
    padding-bottom: 15px;
}

.pro-img-details {
    background-color: #d3ebcd;
    padding: 20px;
    border-radius: 4px;
}

.pro-img-details img {
    width: 100%;
}

.pro-d-title {
    font-size: 18px;
    margin-top: 0;
    font-weight: 600;
}

.product_meta {
    border-top: 1px solid #eee;
    border-bottom: 1px solid #eee;
    padding: 10px 0;
    margin: 15px 0;
}

.product_meta span {
    display: block;
    margin-bottom: 10px;
}
.product_meta a, .pro-price{
    color:#fc5959 ;
}

.pro-price, .amount-old {
    font-size: 18px;
    padding: 0 10px;
}

.amount-old {
    text-decoration: line-through;
}

.quantity {
    width: 120px;
}

.pro-img-list {
    margin: 10px 0 0 -15px;
    width: 100%;
    display: inline-block;
}

.pro-img-list a {
    float: left;
    margin-right: 10px;
    margin-bottom: 10px;
}

.pro-d-head {
    font-size: 18px;
    font-weight: 300;
}

.price {
  display:flex;
  flex-wrap: wrap;
  align-items: center;
  font-weight: 600;
  font-size: 28px;
  width: 100%;
  color: var(--primary);
  letter-spacing: 0.3px;
}

.price:deep(.decoration-line){
  text-decoration: line-through;
  color: #555;
  margin-right: 8px;
  font-size: 13px;
  font-weight: 500;
}

.price .discount {
  border-radius: 10px;
  font-size: 14px;
  padding: 2px 12px;
  border: 1px solid var(--primary);
  
  background: #37a37211;
}
</style>