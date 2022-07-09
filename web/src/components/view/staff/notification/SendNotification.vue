<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff/products">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách gửi thông báo
      </div>
    </section-header>
    <div class="section-body">
      <table-send-notifications></table-send-notifications>
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
import TableSendNotifications from '../common/TableSendNotifications.vue'
import BillDataService from '../../../services/BillDataService'

export default {
  name: Constants.COMPONENT_NAME_SEND_NOTIFICATION_STAFF,

  components: {
    Staff,
    SectionHeader,
    TableSendNotifications
  },

  data() {
    return {
      title: 'Danh sách thông báo',
      customer: null
    }
  },

  methods: {
    loadTokens() {
      BillDataService.findAllTokens(this.$store);
    },
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.sendNotification.value = true;
    this.loadTokens();
  }
}
</script>

<style>

</style>