<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="/staff/orders">Danh sách đơn hàng</router-link>
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
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Staff from '../main/Staff.vue'
import BillDataService from '../../../services/BillDataService'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicOrderInfo from '../common/BasicOrderInfo.vue'

export default {
  name: Constants.COMPONENT_NAME_ORDER_INFO_STAFF,

  components: {
    Staff,
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

  methods: {

    init() {
      this.orderCode = this.$route.query.code;
      if (typeof this.orderCode == 'undefined') {
        var url = window.location.href;
        let searchParams = new URLSearchParams(url.split('?')[1]);
        this.orderCode = searchParams.get('code');
        if (this.orderCode == ''){
          this.$router.push({path: '/staff/orders'})
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