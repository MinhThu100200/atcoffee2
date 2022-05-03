<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link :to="backToStatistics">Danh sách đơn hàng</router-link>
      </div>
      <div class="breadcrumb-item">
        Chi tiết đơn hàng
      </div>
    </section-header>
    <div class="section-body">
      <basic-order-info></basic-order-info>
    </div>
    <div class="popup">
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Admin from '../main/Admin.vue'
import BillDataService from '../../../services/BillDataService'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicOrderInfo from '../../staff/common/BasicOrderInfo.vue'

export default {
  name: Constants.COMPONENT_NAME_ORDER_INFO_STATISTICS,

  components: {
    Admin,
    SectionHeader,
    BasicOrderInfo
  },

  data() {
    return {
      title: 'Chi tiết đơn hàng',
      customer: null,
      orderCode: '',
    }
  },

  computed: {

    backToStatistics() {
      var sortBill = this.$store.getters.sortBill;
      var urlStoreId = '', urlKeyword = '', urlType = '';
      if (sortBill.storeId != null && sortBill.storeId > 0) {
        urlStoreId += '&storeId=' + sortBill.storeId;
      }
      if (sortBill.keyword != '') {
        urlKeyword += '&keyword=' + sortBill.keyword;
      }
      if (sortBill.type != null && sortBill.type != '') {
        urlType += `&t=${sortBill.type}&d=${sortBill.selectedDate}`;
      }
      return '/admin/statistics/orders?page=' + this.$store.getters.sortBill.page + urlStoreId + urlKeyword + urlType;
    }
  },

  methods: {

    init() {
      this.orderCode = this.$route.query.code;
      if (typeof this.orderCode == 'undefined') {
        var url = window.location.href;
        let searchParams = new URLSearchParams(url.split('?')[1]);
        this.orderCode = searchParams.get('code');
        if (this.orderCode == ''){
          this.$router.push({path: '/admin/statistics/orders'})
        }
      }
    },

    loadBill() {
      BillDataService.findOne(this.orderCode, this.$store);
    },
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.order.value = true;
    this.init();
    this.loadBill();
  }
}
</script>

<style>

</style>