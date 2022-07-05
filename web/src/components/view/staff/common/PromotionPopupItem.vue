<template>
  <div class="col-custom">
    <div class="card card-promotion-1" :class="$route.path.includes('payment') ? 'payment' : ''" @click="handleSelect(promotion.code)">
      <div class="card-icon">
        <span class="discount">{{promotion.discount}}%</span>
      </div>
      <div class="card-wrap">
        <div class="card-body flex">
          <div class="content">
            <span class="code">{{promotion.code}}</span>
            <span class="description">{{promotion.description}}</span>
          </div>
          <button class="btn btn-apply" @click="handleSelect(promotion.code)"><b-icon-arrow-right-circle class="b-icon"/></button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

import {BIconArrowRightCircle} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_PROMOTION_POPUP_ITEM,

  props: ['promotion'],

  components: {
    BIconArrowRightCircle
  },

  data(){
    return {
      isSelectPromotionPopup: false,
    }
  },
  
  methods: {

    handleSelect(promotionCode) {
      this.$emit('select', promotionCode);
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

  },

  created() {
  }
}
</script>

<style scoped>
.col-custom {
  position: relative;
  cursor: pointer;
  /* max-width: auto; */
  min-width: 380px;
  transition: all .3s;
}

.card.card-promotion-1 {
  display: inline-block;
  width: 100%;
  margin-bottom: 12px;
  padding-left: 8px;
}

.card.card-promotion-1 .card-icon{
  width: 40px;
  height: 88px;
  margin: 4px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-promotion-1 span.discount {
  position: relative;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: bold;
  color: var(--primary);
}

.card.card-promotion-1 span.discount::after {
  position: absolute;
  right: 0;
  content: '';
  height: 80%;
  width: 1px;
  background-color: #ccc;
}


.card.card-promotion-1 .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-top: 4px;
  padding-bottom: 4px;
}

.card.card-promotion-1 .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 13px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #37A372;
}

.card.card-promotion-1 .card-body {
  font-weight: 500;
  color: #34395e;
  padding-bottom: 0px;
  padding-top: 0px;
  font-size: 14px;
  display: flex;
  align-items: center;
}


.card.card-promotion-1 .card-body .content{
  display: flex;
  height: 88px;
  flex-direction: column;
  flex: 1;
}

.card.card-promotion-1 .card-body span.code{
  color: #34395e;
}

.card.card-promotion-1 .card-body span.description{
  display: flex;
  align-items: center;
}

.card.card-promotion-1 .card-body .btn-apply{
  margin: 4px;
  font-size: 18px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px;
}

.card.card-promotion-1 .card-body.flex {
  display: flex !important;
  justify-content: left;
  padding: 0;
}

.card.card-promotion-1 .card-body.flex .decoration-line{
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

.card.card-promotion-1.payment {
  display: inline-block;
  width: 100%;
  margin-bottom: 12px;
  padding-left: 8px;
}

.card.card-promotion-1.payment .card-icon{
  width: 60px;
  height: 80px;
  margin: 4px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-promotion-1.payment .card-icon img {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 3px;
  margin-left: 0px;
}

.card.card-promotion-1.payment .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-top: 12px;
  padding-bottom: 4px;
}

.card.card-promotion-1.payment .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 14px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #37A372;
}

</style>