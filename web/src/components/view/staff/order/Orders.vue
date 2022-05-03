<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item">
        Đơn hàng
      </div>
    </section-header>
    <div class="section-body">
      <table-orders></table-orders>
    </div>
    <div class="popup">
    </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableOrders from '../common/TableOrders.vue'

export default {
  name: Constants.COMPONENT_NAME_ORDERS_STAFF,

  components: {
    Staff,
    SectionHeader,
    TableOrders
  },

  data() {
    return {
      title: 'Đơn hàng',
      customer: null
    }
  },

  methods: {

    
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.order.value = true;
  }
}
</script>

<style>

</style>