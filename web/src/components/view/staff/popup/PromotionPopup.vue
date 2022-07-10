<template>
  <div class="select" :class="isPromotionPopup ? 'open-popup' : ''">
    <div class="select-inner" v-click-outside="handleHide">
      <div class="promotion" :class="isPromotionPopup ? 'active' : ''">
        <div class="dropdown-header">
          Khuyến mãi
        </div>
        <!-- List item -->
        <div class="promotions" v-if="$store.getters.promotionsSearch.length > 0">
          <promotion-popup-item v-for="(promotion, index) in $store.getters.promotionsSearch" :key="index"
            @select="handleSelect"
            :promotion="promotion"
          ></promotion-popup-item>
        </div>
        <div class="promotions empty" v-else>
          Không có mã khuyến mãi phù hợp
        </div>
      </div>
    </div>
  </div>
  <div class="popup">
    <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import PromotionPopupItem from '../common/PromotionPopupItem.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_PROMOTION_POPUP,

  props: ['isPromotionPopup'],
  
  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
      PromotionPopupItem,
      AlertPopup,
  },

  data(){
    return {
      isAlertPopup: false,
      msg: ''
    }
  },

  methods: {

    handleHide() {
      this.isShowPromotion = false;
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleSelect(promotion) {
      this.$emit('select', promotion);
    },
  }
}
</script>

<style scoped>


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

.promotion {
  position: absolute;
  bottom: 26px;
  right: 0px;
  background: #fff;
  width: 380px;
  border-radius: 4px;
  box-shadow: 2px 6px 12px rgba(0, 0, 0, 0.3);
  transition: all .3s ease-in;
  visibility: hidden;
  opacity: 0;
  max-height: 345px;
}

.promotion.active {
  visibility: visible;
  opacity: 1;
}

.promotions {
  transition: all .3s;
  max-height: 300px;
  overflow-y: auto;
}

.promotions.empty {
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