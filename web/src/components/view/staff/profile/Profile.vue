<template>
  <staff>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/staff/products">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Hồ sơ</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin cá nhân
        </div>
      </section-header>
      <div class="section-body">
        <personal-info :user="this.$store.getters.user" :type="type"></personal-info>
      </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import UserCommand from '../../../command/UserCommand'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import PersonalInfo from '../../admin/common/PersonalInfo.vue'

export default {
  name: Constants.COMPONENT_NAME_PROFILE_STAFF,

  components: {
    Staff,
    SectionHeader,
    PersonalInfo
  },

  data() {
    return {
      title: 'Thông tin cá nhân',
      type: 'profile'
    }
  },

  methods: {
    async getUserById() {
      await UserCommand.findOne(this.$store.getters.user.id, this.$store);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.profile.value = true;
    this.$store.getters.menuStaff.profile.submenu.profile = true;
  }
}
</script>

<style>

</style>