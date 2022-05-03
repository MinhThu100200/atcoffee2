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
        {{title}}
      </div>
    </section-header>
    <div class="section-body">
      <action-staff/>
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import ActionStaff from '../common/ActionStaff.vue'

export default {
  name: Constants.COMPONENT_NAME_ADD_STAFF,

  data(){
    return {
      title: 'Thêm nhân viên',
    }
  },

  components: {
    Admin,
    SectionHeader,
    ActionStaff
  },

  computed: {
    
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.staff.submenu.add_staff = true;
    this.$store.getters.menu.staff.value = true;

  }
}
</script>

<style>
</style>