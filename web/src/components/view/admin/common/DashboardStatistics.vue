<template>
  <div class="row">
      <item-statistics :color="'bg-purple-1'" :value="value.countBills">
        <template v-slot:icon> <i class="fas fa-shopping-cart"></i> </template>
        <template v-slot:title> Tổng đơn hàng trong tháng</template>
      </item-statistics>
      <item-statistics :color="'bg-orangered'" :value="formatPrice(value.amount)">
        <template v-slot:icon> <i class="fas fa-wallet"></i> </template>
        <template v-slot:title> Tổng doanh thu trong tháng</template>
      </item-statistics>
      <item-statistics :color="'bg-orange'" :value="value.countPromotions">
        <template v-slot:icon> <i class="far fa-user"></i> </template>
        <template v-slot:title> Tổng mã khuyến mãi sử dụng </template>
      </item-statistics>
      <item-statistics :color="'bg-green-1'" :value="value.countUsers">
        <template v-slot:icon> <i class="fas fa-user-plus"></i> </template>
        <template v-slot:title> Số lượng người dùng mới </template>
      </item-statistics>  
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import BillCommand from '../../../command/BillCommand'
import UserCommand from '../../../command/UserCommand'
import ItemStatistics from '../../common/common/ItemStatistics.vue'

export default {
  name: Constants.COMPONENT_NAME_DASHBOARD_STATISTICS,

  components: {
    ItemStatistics
  },

  data() {
    return {
      category: {},
      value: {
        countBills: 0,
        amount: 0,
        countUsers: 0,
        countPromotions: 0
      }
    }
  },

  methods: {

    async init() {
      this.getBillsByMonth();
      this.getUsersByMonth();
    },

    async getBillsByMonth() {
      var now = new Date();
      let result = await BillCommand.findByDateBetweenOfMonth(now.getMonth() + 1, now.getFullYear());
      this.value.countBills = result.length;
      let total = 0;
      let countPromotions= 0;
      result.forEach(item => {
        if (item.amount != null) {
          total += item.amount;
        }
        if (item.promotionId != null) {
          countPromotions += 1;
        }
      });
      this.value.countPromotions = countPromotions;
      this.value.amount = total;
    },

    async getUsersByMonth() {
      var now = new Date();
      let result = await UserCommand.findByDateBetweenOfMonth(Constants.ROLE.ROLE_USER, now.getMonth() + 1, now.getFullYear());
      this.value.countUsers = result.length;
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    }
    
  },

  created() {
    this.init();
  }
}
</script>

<style>

</style>