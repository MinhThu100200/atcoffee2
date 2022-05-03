<template>
  <div class="select" :class="isCartPopup ? 'open-popup' : ''">
    <div class="select-inner" v-click-outside="handleHide">
      <div class="cart" :class="isShowCart ? 'active' : ''">
        <div class="dropdown-header">
          Giỏ hàng
          <div class="float-right">
            <a @click="handleRemoveCarts">Làm sạch giỏ hàng</a>
          </div>
        </div>
        <!-- List item -->
        <div class="carts" v-if="$store.getters.carts.length">
          <cart-popup-item v-for="(cart, index) in $store.getters.carts" :key="index"
            :cart="cart"
          ></cart-popup-item>
        </div>
        <div class="carts empty" v-else>
          Chưa có sản phẩm nào được chọn
        </div>
        <div class="dropdown-header dropdown-custom">
          <button class="btn btn-outline-success" @click="handlePayment">Thanh toán</button>
        </div>
      </div>
      <div class="icons" @click="handleShowCart" v-if="!isShowCart" :class="isShowCart ? 'none' : ''">
         <b-icon-basket2-fill></b-icon-basket2-fill>
      </div>
      <div class="icons" @click="handleHideCart" :class="isShowCart ? 'active' : 'none'">
         <b-icon-x></b-icon-x>
      </div>
      <div class="count">{{$store.getters.carts.length}}</div>
    </div>
  </div>
  <div class="popup">
    <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CartPopupItem from '../common/CartPopupItem.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import {BIconBasket2Fill, BIconX} from 'bootstrap-icons-vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_CART_POPUP,

  props: ['isCartPopup'],
  
  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
      CartPopupItem,
      AlertPopup,
      BIconBasket2Fill,
      BIconX
  },

  data(){
    return {
      count: 0,
      isShowCart: false,
      isAlertPopup: false,
      msg: ''
    }
  },

  methods: {

    handleShowCart() {
      this.isShowCart = true;
    },

    handleHideCart() {
      this.isShowCart = false;
    },

    handleMinusQuantity() {
      var quantity = this.quantity == 1 ? this.quantity : this.quantity - 1;
      this.$emit('handleChange', quantity);
    },

    handlePlusQuantity() {
      var quantity = this.quantity + 1;
      this.$emit('handleChange', quantity);
    },

    handleSubmit() {
      this.$emit('handleSubmit');
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handlePayment() {
      if (this.$store.getters.carts == null || this.$store.getters.carts.length == 0) {
        this.isAlertPopup = true;
        this.msg = 'Chưa có sản phẩm nào được chọn';
        return;
      }
      this.$router.push({path: '/staff/payment'})
    },

    handleRemoveCarts() {
      this.$store.commit(MutationsName.MUTATION_NAME_SET_CARTS, []);
    },

    handleHide() {
      this.count += this.isSelectPopup ? 1 : 0;
      this.count % 2 == 0 ? this.$emit('handleHide') : null;
    }
  }
}
</script>

<style scoped>
.select {
  position: fixed;
  bottom: 60px;
  right: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  transition: all .3s;
  visibility: hidden;
  opacity: 0;
  transform: scale(0.8);
  z-index: 20000;
  cursor: default;
}

.open-popup {
  visibility: visible;
  opacity: 1;
  transform: scale(1);
}

.select-inner {
  display: flex;
  position: absolute;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: transparent;
  border-radius: 4px;
}

.row-custom {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  width: 100%;
  justify-content: center;
  align-items: center;
  margin-top: 8px;
}

.row-custom input[type="number"] {
  text-align: center;
  padding: 4px;
  width: 50px !important;
}

.row-custom button {
  width: 32px !important; 
  text-align: center;
  padding: 4px 0px;
  margin: 0px 4px;
}

.icons {
  position: absolute;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
  font-size: 24px;
  background: #fff;
  box-shadow: 2px 6px 12px rgba(0, 0, 0, 0.3);
  border-radius: 50%;
  transition: all .3s;
}

.icons.none {
  visibility: hidden;
  opacity: 0;
}

.icons.active {
  transform: rotateZ(90deg);
}

.cart {
  position: absolute;
  bottom: -24px;
  right: 40px;
  background: #fff;
  width: 320px;
  border-radius: 4px;
  box-shadow: 2px 6px 12px rgba(0, 0, 0, 0.3);
  transition: all .3s ease-in;
  visibility: hidden;
  opacity: 0;
}

.cart.active {
  visibility: visible;
  opacity: 1;
}

.carts {
  transition: all .3s;
}

.carts.empty {
  transition: all .3s;
  text-align: center;
  margin: 20px 0px 24px 0;
  font-size: 16px;
  font-weight: 500;
  color: #777;
}

hr {
  width: 100%;
  border: 0.5px solid #ccc;
  margin-top: 0px;
  margin-bottom: 0;
}

.action {
  width: 100%;
  text-align: center;
  margin-top: 8px;
}

.dropdown-header {
  font-weight: bold;
  padding-bottom: 16px;
  margin-top: 8px;
}

.dropdown-header .float-right a{
  color: var(--primary);
  font-weight: bold;
  font-size: 13px;
  cursor: pointer;
}

.dropdown-header .float-right a:hover{
  color: var(--primary);
  font-weight: bold;
  font-size: 13px;
  cursor: pointer;
  text-decoration: underline;
}

.float-right {
  float: right !important;
}

.dropdown-header.dropdown-custom {
  padding: 0px;
  display: flex;
  align-items: center;
  text-align: center;
  height: 48px !important;
  margin-bottom: 8px;
}

.dropdown-header.dropdown-custom button{
  padding: 4px 16px !important;
  margin: 0 auto;
}


.count {
  position: absolute;
  top: -30px;
  right: -30px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fda427;
  font-size: 13px;
  padding: 2px;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  font-weight: 600;
  color: #fff;
  box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.1);
  transition: all .3s;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
</style>