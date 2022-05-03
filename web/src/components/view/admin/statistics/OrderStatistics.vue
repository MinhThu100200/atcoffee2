<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Đơn hàng</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách đơn hàng
      </div>
    </section-header>
    <div class="section-body">
      <order-statistics-info-header :bills="bills"></order-statistics-info-header>
      <table-order-statistics @handleChangeType="handleChangeType" @handleChangeSelectedDate="handleChangeSelectedDate"
      @handleChangeStore="handleChangeStore"></table-order-statistics>
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import BillCommand from '../../../command/BillCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import OrderStatisticsInfoHeader from '../common/OrderStatisticsInfoHeader'
import TableOrderStatistics from '../common/TableOrderStatistics.vue'

export default {
  name: Constants.COMPONENT_NAME_ORDER_STATISTICS,

  components: {
    Admin,
    SectionHeader,
    OrderStatisticsInfoHeader,
    TableOrderStatistics
  },

  data() {
    return {
      title: 'Thống kê đơn hàng',
      type: null,
      selectedDate: CommonUtils.formatDateReverse(new Date()),
      storeId: -1,
      bills: []
    }
  },

  methods: {

    init() {
      this.storeId = this.$route.query.storeId;
      if (typeof this.storeId == 'undefined') {
        this.storeId = -1;
      }
      this.type = this.$route.query.t;
      if (typeof this.type == 'undefined') {
        this.type = null;
      }
      this.selectedDate = this.$route.query.d;
      if (typeof this.selectedDate == 'undefined') {
        this.selectedDate = CommonUtils.formatDateReverse(new Date());
      }
      this.loadBills();
    },

    handleChangeType(type) {
      this.type = type;
      this.loadBills();
    },

    handleChangeSelectedDate(selectedDate) {
      this.selectedDate = selectedDate;
      this.loadBills();
    },

    handleChangeStore(storeId) {
      this.storeId = storeId;
      this.loadBills();
    },

    async loadBills() {
      if (this.type == 'month') {
        var items = this.selectedDate.split('-');
        this.bills = await BillCommand.findByDateBetweenOfMonth(parseInt(items[1]), parseInt(items[0]));
      } else if (this.type == 'week') {
        this.bills = await BillCommand.findByDateBetweenOfWeek(this.selectedDate);
      } else {
         this.bills = await BillCommand.findByDateBetween('2020-01-01', '2200-01-01');
      }
      if (this.storeId != null && this.storeId > 0) {
        this.bills = this.bills.filter(item => item.storeId == this.storeId);
      }
    },
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.order_statistics.value = true;
    this.init();
  }
}
</script>

<style>

</style>