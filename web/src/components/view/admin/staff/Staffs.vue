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
        <table-staffs></table-staffs>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableStaffs from '../common/TableStaffs.vue'

export default {
  name: Constants.COMPONENT_NAME_STAFFS,

  components: {
    Admin,
    SectionHeader,
    TableStaffs
  },

  data() {
    return {
      title: 'Danh sách nhân viên'
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.staff.value = true;
    this.$store.getters.menu.staff.submenu.staffs = true;
  }
}
</script>

<style>

</style>