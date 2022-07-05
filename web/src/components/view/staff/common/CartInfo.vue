<template> 
  <div class="row">
    <div class="col-8">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách sản phẩm</h4>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-12 col">
              <cart-popup-item v-for="(cart, index) in $store.getters.carts" :key="index"
                :cart="cart"
              ></cart-popup-item>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-4">
      <div class="card">
        <div class="card-header">
          <h4>Thông tin thanh toán</h4>
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-12 col">
              <div class="row-custom">
                <span>Tổng tiền tạm tính</span>
                <span>{{formatPrice(price)}}</span>
              </div>
              <div class="row-custom">
                <span>Giảm giá</span>
                <span>{{formatPrice(discount)}}</span>
              </div>
              <div class="row-custom">
                <span>Tổng tiền</span>
                <span>{{formatPrice(price - discount)}}</span>
              </div>
              <div class="row-custom">
                <span>Mã giảm giá</span>
                <div class="row-custom">
                  <div class="position" v-if="promotionCode != ''">
                    <div class="tooltip-custom show" :class="this.errorPromotionCode.length < 10 ? 'success' : ''">
                      <span>{{this.errorPromotionCode}}</span>
                    </div>
                    <i class="far fa-check-circle" v-if="verifyPromotion"></i>
                    <i class="fas fa-exclamation-circle" v-else></i>
                  </div>
                  <input type="text" class="form-control" v-model="promotionCode"
                    @keyup.enter="handleHidePromotionPopup"
                    @input="handleChangePromotion"
                    @focus="handleShowPromotionPopup"
                    @blur="handleHidePromotionPopup">
                  <div class="promotion-popup">
                    <promotion-popup :isPromotionPopup="isPromotionPopup" @select="handleSelect"></promotion-popup>
                  </div>
                </div>
              </div>
              <div class="row-custom" v-if="false">
                <span>Sử dụng điểm</span>
                <div class="row-custom-2">
                  <span>{{user != null ? user.currentPoints : 0}}</span>
                  <input type="checkbox" v-model="isUsePoint" :disabled="user == null" @change="handleChangePoint">
                </div>
              </div>
              <div class="row-custom">
                <span>Phương thức thanh toán</span>
                <select v-model="paymentId" class="form-control">
                  <option v-for="item in payments" :value="item.id" :key="item.id">{{item.name}}</option>
                </select>
              </div>
              <div class="row-custom">
                <input type="button" class="btn btn-success" value="Thanh toán" @click="handlePayment">
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="popup">
      <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
      <spinner-success :isSpinner="isSpinnerSuccess" :src="src"></spinner-success>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import PaymentCommand from '../../../command/PaymentCommand'
import PromotionCommand from '../../../command/PromotionCommand'
import BillCommand from '../../../command/BillCommand'
import StoreCommand from '../../../command/StoreCommand'
import TypeCommand from '../../../command/TypeCommand'
import BillDataService from '../../../services/BillDataService'
import CartPopupItem from './CartPopupItem.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import PromotionPopup from '../popup/PromotionPopup.vue'
import SpinnerSuccess from '../../common/popup/SpinnerSuccess.vue'

export default {
  name: Constants.COMPONENT_NAME_CART_INFO_STAFF,

  props: ['user'],

  components: {
    CartPopupItem,
    AlertPopup,
    SpinnerSuccess,
    PromotionPopup
  },

  data() {
    return {
      payments: [],
      paymentId: 1,
      isUsePoint: false,
      promotionCode: '',
      promotion: null,
      discountPromotion: 0,
      point: 0,
      types: [],
      errorPromotionCode: '',
      verifyPromotion: false,
      store: {},
      isAlertPopup: false,
      isPromotionPopup: false,
      msg: 'Chưa có sản phẩm nào được chọn',
      isSpinnerSuccess: false,
      src: ''
    }
  },

  computed: {

    price() {
      var total = 0;
      this.$store.getters.carts.forEach(cart => {
        total += cart.amount;
      });
      return total;
    },

    discount() {
      return this.discountPromotion + this.point;
    }

  },

  methods: {
    async init() {
      await Promise.all([
        this.loadPayments(),
        this.loadTypes(),
        this.loadStore(),
        this.loadPromotions(),
      ]);
    },

    handleChangePromotion() {
      this.promotionCode = this.promotionCode.toUpperCase();
      this.promotion = this.$store.getters.promotions.find(item => item.code == this.promotionCode);
      this.verifyPromotion = this.verifyPromotionCode(this.promotion);

      this.$store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION_KEY_SEARCH, this.promotionCode);
    },

    handleSelect(promotionCode) {
      this.promotionCode = promotionCode.toUpperCase();
      this.promotion = this.$store.getters.promotions.find(item => item.code == this.promotionCode);
      this.verifyPromotion = this.verifyPromotionCode(this.promotion);

      this.handleHidePromotionPopup();
    },

    handleShowPromotionPopup() {
      this.$store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION_KEY_SEARCH, this.promotionCode);
      this.isPromotionPopup = true;
    },

    handleHidePromotionPopup() {
      this.isPromotionPopup = false;
      setTimeout(() => {
        this.$store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION_KEY_SEARCH, '');
      }, 300);
    },

    handleChangePoint() {
      this.point = 0;
      if (!this.isUsePoint) {
        return;
      }
      if (this.price - this.discountPromotion > this.user.currentPoints) {
        this.point = this.user.currentPoints;
      } else {
        this.point = this.user.currentPoints - (this.price + this.discountPromotion);
      }
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    processSpinnerSuccess() {
      this.isSpinnerSuccess = true;
      this.src = 'https://res.cloudinary.com/tranan2509/image/upload/v1637987235/loading-success_fvohb1.gif';
      setTimeout(()=> {
        this.isSpinnerSuccess = false;
        this.src = '';
        this.$router.push({path: '/staff/products'});
      }, 1000);
    },

    async loadPromotions(){
      await PromotionCommand.findAll(this.$store);
    },

    async handlePayment() {

      if (this.$store.getters.carts == null || this.$store.getters.carts.length == 0) {
        this.isAlertPopup = true;
        this.msg = 'Chưa có sản phẩm nào được chọn';
        return;
      }
      var userId = this.user == null ? 1 : this.user.id;
      var now = new Date();
      let code = `BI${now.getTime().toString().slice(1, 9)}`;
      var bill = {
        code,
        amount: this.price - this.discount,
        price: this.price,
        discount: this.discountPromotion, //this.promotion != null ? this.promotion.discount : 0,
        point: parseInt(((this.price - this.discount) * Constants.POINTS_REFUND).toFixed(0)),
        address: '',
        status: Constants.STATUS_BILL.PAID,
        rewardId: 0,
        promotionId: this.verifyPromotionCode(this.promotion) ? this.promotion.id : 0,
        promotionCode: this.promotionCode,
        paymentId: this.paymentId,
        paymentName: this.payments.find(item => item.id = this.paymentId).name,
        storeId: this.store.id,
        staffId: this.$store.getters.user.id,
        staffName: this.$store.getters.user.name,
        customerId: userId,
        customerName: this.user == null ? '' : this.user.name,
        billDetails: this.$store.getters.carts.map((cart, index) => {
          cart.code = `${code}D${index + 1}`;
          return cart;
        }),
        createdDate: new Date().getTime(),
        state: true,
        read: true,
        token: ''
      }
     
      let result = await BillCommand.save(bill);
      if (result != null) {
        bill.id = result.id;
        BillDataService.save(bill);
        this.$store.commit(MutationsName.MUTATION_NAME_SET_CARTS, []);
        await this.processSpinnerSuccess();
      } else {
        this.isAlertPopup = true;
        this.msg = 'Thanh toán không thành công!';
        return;
      }
    },

    verifyPromotionCode(promotion){
      this.discountPromotion = 0;
      if (promotion == null || typeof promotion == 'undefined') {
        this.errorPromotionCode = `Mã khuyến mãi không tồn tại!`;
        return false;
      }
      var now = new Date();
      var nowStr = CommonUtils.formatDateReverse(now);
      now = new Date(nowStr);
      if (now < new Date(promotion.startDate)) {
        this.errorPromotionCode = `Mã khuyến mãi sẽ được áp dụng từ ngày ${CommonUtils.formatDate(new Date(promotion.startDate))}!`;
        return false;
      } else if (now > new Date(promotion.endDate)) {
        this.errorPromotionCode = `Mã khuyến mãi đã hết hạng từ ngày ${CommonUtils.formatDate(new Date(promotion.endDate))}!`;
        return false;
      }
      var type = this.types.find(item => item.code == promotion.object);      
      if ((this.user == null && type.id > 1) || (this.user != null && this.user.typeId < type.id)) {
        this.errorPromotionCode = `Mã khuyến mãi chỉ áp dụng từ người dùng hạng ${type.name} trở lên!`;
        return false;
      }
      if (this.price < promotion.proviso) {
        this.errorPromotionCode = `Mã khuyến mãi áp dụng đơn hàng tối thiểu ${promotion.proviso}!`;
        return false;
      }
      this.errorPromotionCode = `-${promotion.discount}%`;
      this.discountPromotion = promotion.discount * this.price / 100;
      return true;
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    async loadTypes() {
      this.types = await TypeCommand.findAll();
    },

    async loadPayments() {
      this.payments = await PaymentCommand.findAll();
    },

    async loadStore() {
      this.store = await StoreCommand.findOne(this.$store.getters.user.storeId);
    }
  },

  created() {
    this.init();
  }
}
</script>

<style scoped>
.row-custom {
  display: flex;
  padding: 4px 0;
}

.row-custom span:nth-child(1) {
  flex: 1;
  font-weight: bold;
  font-size: 16px;
  color: #6a6a6a;
  display: inline-block;
  display: flex;
  align-items: center;
}

.row-custom span:nth-child(2) {
  font-size: 16px;
}

.row-custom input[type="text"] {
  text-align: right;
  padding: 2px 4px !important;
  max-width: 150px !important;
  flex: 1;
}

.row-custom select{
  text-align: right;
  padding: 2px 4px !important;
  max-width: 150px !important;
}

.row-custom-2 {
  display: flex;
}

.row-custom-2 span {
  font-size: 16px !important;
  margin-right: 8px;
  color: #000 !important;
  font-weight: 500 !important;
}

.row-custom-2 input[type="checkbox"] {
  width: 24px;
  height: 24px;
  border: 0.5px solid #444 !important;
  border-radius: 50%;
}

.row-custom i {
  font-size: 20px;
  display: flex;
  height: 100%;
  text-align: center;
  align-items: center;
  justify-content: center;
  margin-right: 8px;
}

.far.fa-check-circle {
  color: var(--primary);
}

.fas.fa-exclamation-circle {
  color: red;
}

.position {
  position: relative;
}

.tooltip-custom.show {
  position: absolute;
  right: 6px;
  bottom: 28px;
  width: 200px;
  z-index: 50;
  padding: 4px 8px;
  border-radius: 4px;
  background: rgba(0, 0, 0, 0.1) ;
}

.tooltip-custom.show.success{
  width: auto;
}

.tooltip-custom.show.success span {
  color: green;
  font-weight: bold;
}

.tooltip-custom.show span {
  font-size: 13px !important;
  font-weight: 500 !important;
  color: #000;
}

</style>