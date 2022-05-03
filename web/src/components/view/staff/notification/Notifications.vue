<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item">
        Thông báo
      </div>
    </section-header>
    <div class="section-body">
      <list-notifications></list-notifications>
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
import ListNotifications from '../common/ListNotifications.vue'

export default {
  name: Constants.COMPONENT_NAME_NOTIFICATION_STAFF,

  components: {
    Staff,
    SectionHeader,
    ListNotifications
  },

  data() {
    return {
      title: 'Thông báo',
      customer: null
    }
  },

  methods: {

  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.notification.value = true;
  }
}
</script>

<style>

</style>