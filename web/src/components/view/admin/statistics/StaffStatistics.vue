<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Nhân viên</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách nhân viên
      </div>
    </section-header>
    <div class="section-body">
      <table-staff-statistics></table-staff-statistics>
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableStaffStatistics from '../common/TableStaffStatistics.vue'

export default {
  name: Constants.COMPONENT_NAME_ORDER_STATISTICS,

  components: {
    Admin,
    SectionHeader,
    TableStaffStatistics
  },

  data() {
    return {
      title: 'Thống kê nhân viên',
    }
  },

  methods: {

  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.staff_statistics.value = true;
  }
}
</script>

<style>

</style>