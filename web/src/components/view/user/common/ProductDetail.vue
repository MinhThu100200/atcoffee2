<template>
  <div v-if="product != null" class="container-fluid">
    <div class="container bootdey">
        <div class="col-md-12">
            <section class="panel">
                <div class="panel-body col-md-12 flex">
                    <div class="col-md-5 col-md">
                        <div class="pro-img-details">
                            <img :src="product.image" alt="">
                        </div>
                    </div>
                    <div class="col-md-7 col-12 col-md">
                        <h4 class="pro-d-title">
                            <span>{{product.name}}</span>
                        </h4>
                        <p>
                            {{product.description}}
                        </p>
                        
                        <div v-if="product.sizes?.length > 0" class="m-bot15 price">
                          <span>{{formatPrice(product.sizes[selectedSize].price * (1 - product.discount / 100))}} &nbsp;</span>
                          <span v-if="product.discount > 0" v-html="processPrice(product.sizes[selectedSize].price)"></span>
                          <span class="discount" v-if="product.discount > 0">giảm {{product.discount}}%</span>
                        </div>
                        <div class="option option-size">
													<span class="span-title">Kích thước</span>
													<div v-if="product.sizes?.length > 0" class="sizes">
															<span class="size-item" :class="selectedSize == 0 ? 'active' : ''" @click="changeSelectedSize(0);">
																	<span class="size-icon">
																		<svg width="15" height="20" viewBox="0 0 13 16" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M11.6511 1.68763H10.3529V0.421907C10.3529 0.194726 10.1582 0 9.93104 0H2.17444C1.94726 0 1.75254 0.194726 1.75254 0.421907V1.65517H0.454361C0.194726 1.68763 0 1.88235 0 2.10953V4.18661C0 4.41379 0.194726 4.60852 0.421907 4.60852H1.33063L1.72008 8.8925L1.78499 9.76876L2.30426 15.6105C2.33671 15.8377 2.49899 16 2.72617 16H9.28195C9.50913 16 9.70385 15.8377 9.70385 15.6105L10.2231 9.76876L10.288 8.8925L10.6775 4.60852H11.5862C11.8134 4.60852 12.0081 4.41379 12.0081 4.18661V2.10953C12.073 1.88235 11.8783 1.68763 11.6511 1.68763ZM2.56389 8.40568H3.50507C3.47262 8.56795 3.47262 8.73022 3.47262 8.8925C3.47262 9.02231 3.47262 9.15213 3.50507 9.28195H2.66126L2.6288 8.92495L2.56389 8.40568ZM9.47667 8.92495L9.44422 9.28195H8.56795C8.60041 9.15213 8.60041 9.02231 8.60041 8.8925C8.60041 8.73022 8.56795 8.56795 8.56795 8.40568H9.50913L9.47667 8.92495ZM7.72414 8.8925C7.72414 9.83367 6.97769 10.5801 6.03651 10.5801C5.09534 10.5801 4.34888 9.83367 4.34888 8.8925C4.34888 7.95132 5.09534 7.20487 6.03651 7.20487C6.97769 7.20487 7.72414 7.95132 7.72414 8.8925ZM8.92495 15.1562H3.18053L2.72617 10.1582H3.82961C4.28398 10.9371 5.09534 11.4564 6.03651 11.4564C6.97769 11.4564 7.8215 10.9371 8.24341 10.1582H9.34686L8.92495 15.1562ZM9.60649 7.52941H8.21095C7.75659 6.81542 6.94523 6.3286 6.03651 6.3286C5.12779 6.3286 4.31643 6.81542 3.86207 7.52941H2.49899L2.23935 4.60852H9.86613L9.60649 7.52941ZM11.1968 3.73225H10.3205H1.75254H0.876268V2.56389H2.17444H2.2069H2.23935H8.27586C8.50304 2.56389 8.69777 2.36917 8.69777 2.14199C8.69777 1.91481 8.50304 1.72008 8.27586 1.72008H2.6288V0.876268H9.47667V2.10953C9.47667 2.33671 9.6714 2.53144 9.89858 2.53144H11.1968V3.73225Z" :fill="selectedSize == 0 ? 'white' : 'gray'"></path> </svg>
																	</span>
																	<span class="size-name">Nhỏ</span>
															</span>
															<span class="size-item" :class="selectedSize == 1 ? 'active' : ''" @click="changeSelectedSize(1);">
																	<span class="size-icon">
																		<svg width="15" height="20" viewBox="0 0 13 16" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M11.6511 1.68763H10.3529V0.421907C10.3529 0.194726 10.1582 0 9.93104 0H2.17444C1.94726 0 1.75254 0.194726 1.75254 0.421907V1.65517H0.454361C0.194726 1.68763 0 1.88235 0 2.10953V4.18661C0 4.41379 0.194726 4.60852 0.421907 4.60852H1.33063L1.72008 8.8925L1.78499 9.76876L2.30426 15.6105C2.33671 15.8377 2.49899 16 2.72617 16H9.28195C9.50913 16 9.70385 15.8377 9.70385 15.6105L10.2231 9.76876L10.288 8.8925L10.6775 4.60852H11.5862C11.8134 4.60852 12.0081 4.41379 12.0081 4.18661V2.10953C12.073 1.88235 11.8783 1.68763 11.6511 1.68763ZM2.56389 8.40568H3.50507C3.47262 8.56795 3.47262 8.73022 3.47262 8.8925C3.47262 9.02231 3.47262 9.15213 3.50507 9.28195H2.66126L2.6288 8.92495L2.56389 8.40568ZM9.47667 8.92495L9.44422 9.28195H8.56795C8.60041 9.15213 8.60041 9.02231 8.60041 8.8925C8.60041 8.73022 8.56795 8.56795 8.56795 8.40568H9.50913L9.47667 8.92495ZM7.72414 8.8925C7.72414 9.83367 6.97769 10.5801 6.03651 10.5801C5.09534 10.5801 4.34888 9.83367 4.34888 8.8925C4.34888 7.95132 5.09534 7.20487 6.03651 7.20487C6.97769 7.20487 7.72414 7.95132 7.72414 8.8925ZM8.92495 15.1562H3.18053L2.72617 10.1582H3.82961C4.28398 10.9371 5.09534 11.4564 6.03651 11.4564C6.97769 11.4564 7.8215 10.9371 8.24341 10.1582H9.34686L8.92495 15.1562ZM9.60649 7.52941H8.21095C7.75659 6.81542 6.94523 6.3286 6.03651 6.3286C5.12779 6.3286 4.31643 6.81542 3.86207 7.52941H2.49899L2.23935 4.60852H9.86613L9.60649 7.52941ZM11.1968 3.73225H10.3205H1.75254H0.876268V2.56389H2.17444H2.2069H2.23935H8.27586C8.50304 2.56389 8.69777 2.36917 8.69777 2.14199C8.69777 1.91481 8.50304 1.72008 8.27586 1.72008H2.6288V0.876268H9.47667V2.10953C9.47667 2.33671 9.6714 2.53144 9.89858 2.53144H11.1968V3.73225Z" :fill="selectedSize == 1 ? 'white' : 'gray'"></path> </svg>
																	</span>
																	<span class="size-name">Vừa</span>
																	<span class="size-difference">
																		<span>+</span>{{formatPrice(product.sizes[1].price - product.sizes[0].price)}}
																	</span>
															</span>
															<span class="size-item" :class="selectedSize == 2 ? 'active' : ''" @click="changeSelectedSize(2);">
																	<span class="size-icon">
																		<svg width="15" height="20" viewBox="0 0 13 16" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M11.6511 1.68763H10.3529V0.421907C10.3529 0.194726 10.1582 0 9.93104 0H2.17444C1.94726 0 1.75254 0.194726 1.75254 0.421907V1.65517H0.454361C0.194726 1.68763 0 1.88235 0 2.10953V4.18661C0 4.41379 0.194726 4.60852 0.421907 4.60852H1.33063L1.72008 8.8925L1.78499 9.76876L2.30426 15.6105C2.33671 15.8377 2.49899 16 2.72617 16H9.28195C9.50913 16 9.70385 15.8377 9.70385 15.6105L10.2231 9.76876L10.288 8.8925L10.6775 4.60852H11.5862C11.8134 4.60852 12.0081 4.41379 12.0081 4.18661V2.10953C12.073 1.88235 11.8783 1.68763 11.6511 1.68763ZM2.56389 8.40568H3.50507C3.47262 8.56795 3.47262 8.73022 3.47262 8.8925C3.47262 9.02231 3.47262 9.15213 3.50507 9.28195H2.66126L2.6288 8.92495L2.56389 8.40568ZM9.47667 8.92495L9.44422 9.28195H8.56795C8.60041 9.15213 8.60041 9.02231 8.60041 8.8925C8.60041 8.73022 8.56795 8.56795 8.56795 8.40568H9.50913L9.47667 8.92495ZM7.72414 8.8925C7.72414 9.83367 6.97769 10.5801 6.03651 10.5801C5.09534 10.5801 4.34888 9.83367 4.34888 8.8925C4.34888 7.95132 5.09534 7.20487 6.03651 7.20487C6.97769 7.20487 7.72414 7.95132 7.72414 8.8925ZM8.92495 15.1562H3.18053L2.72617 10.1582H3.82961C4.28398 10.9371 5.09534 11.4564 6.03651 11.4564C6.97769 11.4564 7.8215 10.9371 8.24341 10.1582H9.34686L8.92495 15.1562ZM9.60649 7.52941H8.21095C7.75659 6.81542 6.94523 6.3286 6.03651 6.3286C5.12779 6.3286 4.31643 6.81542 3.86207 7.52941H2.49899L2.23935 4.60852H9.86613L9.60649 7.52941ZM11.1968 3.73225H10.3205H1.75254H0.876268V2.56389H2.17444H2.2069H2.23935H8.27586C8.50304 2.56389 8.69777 2.36917 8.69777 2.14199C8.69777 1.91481 8.50304 1.72008 8.27586 1.72008H2.6288V0.876268H9.47667V2.10953C9.47667 2.33671 9.6714 2.53144 9.89858 2.53144H11.1968V3.73225Z" :fill="selectedSize == 2 ? 'white' : 'gray'"></path> </svg>
																	</span>
																	<span class="size-name">Lớn</span>
																	<span class="size-difference">
																		<span>+</span>{{formatPrice(product.sizes[2].price - product.sizes[0].price)}}
																	</span>
															</span>
													</div>
                          <div v-if="product.sizes?.length > 0" class="sizes-mini">
															<span class="size-item" :class="selectedSize == 0 ? 'active' : ''" @click="changeSelectedSize(0);">
                                <input type="radio" name="size" v-model="selectedSize" value="0"/>
																<span class="size-name">Nhỏ</span>
															</span>
                              <hr/>
															<span class="size-item" :class="selectedSize == 1 ? 'active' : ''" @click="changeSelectedSize(1);">
																	<input type="radio" name="size" v-model="selectedSize" value="1"/>
																	<span class="size-name">Vừa</span>
																	<span class="size-difference">
																		<span>+</span>{{formatPrice(product.sizes[1].price - product.sizes[0].price)}}
																	</span>
															</span>
                              <hr/>
															<span class="size-item" :class="selectedSize == 2 ? 'active' : ''" @click="changeSelectedSize(2);">
																	<input type="radio" name="size" v-model="selectedSize" value="2"/>
																	<span class="size-name">Lớn</span>
																	<span class="size-difference">
																		<span>+</span>{{formatPrice(product.sizes[2].price - product.sizes[0].price)}}
																	</span>
															</span>
													</div>
												</div>
                        <div class="option option-quantity form-group">
														<span class="span-title">Số lượng</span>
                            <div class="option-adjust-quantity">
                              <button class="btn btn-minus" @click="handleQuantity(-1)"><b-icon-dash class="b-icon"/></button>
                              <input type="text" placeholder="" pattern="^[0-9]*$" v-model="cart.quantity" 
                                @keypress="isNumber(event)"  @input="handleQuantityInput" @blur="handleQuantityBlur"
                                class="form-control quantity center">
                              <button class="btn btn-add" @click="handleQuantity(1)"><b-icon-plus class="b-icon"/></button>
                              &nbsp;&nbsp;&nbsp;&nbsp;
                              <span v-if="product.sizes?.length > 0">({{formatPrice(product.sizes[selectedSize].price * (1 - product.discount / 100) * preQuantity)}})</span>
                            </div>
                        </div>
                        <div class="buttons">
                            <button class="btn btn-round buy-now" type="button">Mua ngay </button>
														<div class="flex">
															<button class="btn btn-round add-to-cart" type="button"><b-icon-cart-plus class="b-icon"/> <span class="text-hidden">Thêm vào giỏ hàng</span></button>
															<button class="btn btn-round heart" type="button"><b-icon-heart class="b-icon heart"/> <span class="text-hidden">Yêu thích</span> (25)</button>
														</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

import {BIconCartPlus, BIconHeart, BIconPlus, BIconDash} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_DETAIL_USER,

  props: ['product'],

  components: {
		BIconCartPlus,
		BIconHeart,
    BIconPlus,
    BIconDash
	},

  data() {
    return {
      cart: {
        quantity: 1
      },
      preQuantity: 1,
			selectedSize: 0,
    }
  },

  methods: {
    
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processPrice(price) {
      return `<span class="decoration-line">${this.formatPrice(price)}</span>`
    },

		changeSelectedSize(index) {
			this.selectedSize = index;
		},

    handleQuantity(valueChange) {
      valueChange = valueChange < 0 && Number(this.cart.quantity) + valueChange <= 0 ? 0 : valueChange;
      this.cart.quantity = Number(this.cart.quantity) + valueChange;
      this.preQuantity = this.cart.quantity;
    },

    handleQuantityInput() {

      if (this.cart.quantity != ''){
          if (!isNaN(this.cart.quantity) && this.cart.quantity > 0) {
          this.preQuantity = this.cart.quantity;
        } else {
          this.cart.quantity = this.preQuantity;
        }
      }
    },

    handleQuantityBlur() {
      if (this.cart.quantity == ''){
         this.cart.quantity = this.preQuantity;
      }
    },

    isNumber(evt) {
      evt = (evt) ? evt : window.event;
      var charCode = (evt.which) ? evt.which : evt.keyCode;
      if (charCode > 31 && (charCode < 48 || charCode > 57)) {
          return false;
      }
      return true;
    }
  },
}
</script>

<style scoped>

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
    padding: 0px 0px;
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
  border-radius: 8px;
  font-size: 14px;
  padding: 2px 12px;
  border: 1px solid var(--primary);
  background: var(--primaryBackground);
}

.option {
	padding-top: 16px;
	display: flex;
	flex-direction: column;
}

.span-title {
	font-size: 16px;
	flex: 100%;
}

.sizes {
	display: flex;
	flex-wrap: wrap;
}

.sizes .size-item {
	display: flex;
	align-items: center;
	font-size: 16px;
	color: #777;
	font-weight: bold;
	padding: 8px 12px;
	border: 1px solid #ccc;
	cursor: pointer;
	margin-right: 16px;
	margin-top: 10px;
}

.sizes .size-item .size-icon {
	display: flex;
	align-items: center;

}

.sizes .size-item span {
	padding: 0 4px;
}

.sizes .size-item.active {
	color: white;
	font-weight: bold;
	padding: 8px 12px;
	background-color: var(--primary);
	border: 1px solid var(--primary);
}

.sizes-mini {
  display: none;
  flex-direction: column;
  margin-top: 12px;
}
.sizes-mini hr {
  margin-top: 12px;
  margin-bottom: 12px;
}

.sizes-mini .size-item {
  width: 100%;
  font-size: 16px;
  display: flex;
}

.sizes-mini .size-item input{
  margin-right: 12px;
}

.sizes-mini .size-item .size-name {
  flex: 1;
}


.buttons {
	margin-top: 32px;
	width: 100%;
	display: flex;
	flex-direction: column;
}

.b-icon {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 4px 12px 4px 0px;
	font-size: 18px;
}

.b-icon.arrow {
	margin: 4px 0px 4px 12px;
}

.buttons button {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 8px 16px;
	border-radius: 8px;
	font-weight: 600;
}

.buttons button.buy-now {
	background: var(--primary) !important;
	font-weight: 600;
	color: #fff;
	flex: 100%;
}

.buttons .flex {
	flex: 1;
	display: flex;
	flex-wrap: wrap;
	flex-direction: row;
	justify-content: space-between;
}

.buttons .flex button {
	margin-top: 16px;
	flex: 0 0 calc(50% - 8px);
	background: var(--primaryBackground);
	color: var(--primary);
	white-space: nowrap;
}

.buttons .flex button.add-to-cart {
	background: var(--primaryBackground);
	color: var(--primary);
}

.buttons .flex button.heart {
	background: #f7a75411;
	color: #f7a754;
}
.option-adjust-quantity {
  display: flex;
  align-items: center;
  margin-top: 10px;
}

.option-adjust-quantity .quantity {
  padding: 6px 10px !important;
  width: 80px !important;
}


.option-adjust-quantity button {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 4px;
  width: 38px;
  height: 38px;
}

.option-adjust-quantity button.btn-add {
  background-color: var(--primaryBackground);
  color: var(--primary);
  margin-left: 4px;
}

.option-adjust-quantity button.btn-minus {
  background-color: #ff615011;
  color: #ff6150;
  margin-right: 4px;
}

.option-adjust-quantity button .b-icon {
  margin: 4px;
}


.center {
  text-align: center;
}

/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}

@media (max-width: 766px){
  .col-md {
    padding-left: 0;
		padding-right: 0;
  }

	.panel-body {
    padding: 0;
  }
}

@media (min-width: 1400px){
  .container {
  max-width: 1200px;
  }
}

@media (max-width: 517px){
  .sizes {
    display: none;
  }

  .sizes-mini {
    display: flex;
  }

  .text-hidden {
    display: none;
  }
}
</style>