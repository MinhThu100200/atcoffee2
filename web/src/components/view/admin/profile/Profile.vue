<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Hồ sơ</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin cá nhân
        </div>
      </section-header>
      <div class="section-body">
        <personal-info :user="this.$store.getters.user" :type="type" @handleEdit="handleEdit" v-if="!isEdit"></personal-info>
        <action-staff v-if="isEdit" @handleCancel="handleCancel" @handleDone="handleDone"></action-staff>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import UserCommand from '../../../command/UserCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import PersonalInfo from '../common/PersonalInfo.vue'
import ActionStaff from '../common/ActionStaff.vue'

export default {
  name: Constants.COMPONENT_NAME_PROFILE,

  components: {
    Admin,
    SectionHeader,
    PersonalInfo,
    ActionStaff
  },

  data() {
    return {
      title: 'Thông tin cá nhân',
      type: 'profile',
      isEdit: false
    }
  },

  methods: {
    handleEdit() {
      this.isEdit = true;
    },

    async handleDone() {
      this.isEdit = false;
      await this.getUserById();
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getUserById();
    },

    async getUserById() {
      await UserCommand.findOne(this.$store.getters.user.id, this.$store);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.profile.value = true;
    this.$store.getters.menu.profile.submenu.profile = true;
  }
}
</script>

<style>

</style>