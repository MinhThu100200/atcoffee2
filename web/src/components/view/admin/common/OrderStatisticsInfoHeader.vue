<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-12 col">
              <div class="official-info">
                <div class="line">
                  <div class="info-group flex-1">
                    <label>Tổng đơn hàng</label>
                    <span>{{bills.length}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Tổng doanh thu</label>
                    <span>{{formatPrice(processAmount())}}</span>
                </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'

export default {
  name: Constants.COMPONENT_NAME_ORDER_INFO_STATISTICS_HEADER,

  props: ['bills'],

  methods: {

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    processAmount() {
      var amount = 0;
      this.bills.forEach(item => {
        amount += item.amount;
      });
      return amount;
    }
  },

  created() {
  }
}
</script>

<style>

.bold {
  font-weight: bold;
}
</style>