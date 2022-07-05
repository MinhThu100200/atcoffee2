<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff/products">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item">
        Thanh toán
      </div>
    </section-header>
    <div class="section-body">
      <customer-payment-info @handleChangeUser="handleChangeUser"></customer-payment-info>
      <cart-info :user="customer"></cart-info>
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
import CustomerPaymentInfo from '../common/CustomerPaymentInfo.vue'
import CartInfo from '../common/CartInfo.vue'

export default {
  name: Constants.COMPONENT_NAME_PAYMENT_STAFF,

  components: {
    Staff,
    SectionHeader,
    CustomerPaymentInfo,
    CartInfo
  },

  data() {
    return {
      title: 'Thanh toán',
      customer: null
    }
  },

  methods: {

    handleChangeUser(customer) {
      this.customer = customer;
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.payment.value = true;
  }
}
</script>

<style>

</style>