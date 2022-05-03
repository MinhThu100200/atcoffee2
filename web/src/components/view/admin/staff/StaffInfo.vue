<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Nhân viên</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link :to="linkBackStaffs">Danh sách nhân viên</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin nhân viên
        </div>
      </section-header>
      <div class="section-body">
        <personal-info :user="user" :type="type" @handleEdit="handleEdit" @handleLock="handleLock" v-if="!isEdit"></personal-info>
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
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_STAFF_INFO,

  components: {
    Admin,
    SectionHeader,
    PersonalInfo,
    ActionStaff
  },

  data() {
    return {
      title: 'Thông tin nhân viên',
      user: {},
      type: 'info',
      userId: 0,
      isEdit: false
    }
  },

  computed: {
    linkBackStaffs() {
      var sortUser = this.$store.getters.sortUser;
      var urlStore = '', urlRole = '', urlState = '', urlKeyword = '';
      if (sortUser.store != '') {
        urlStore += '&store=' + sortUser.store;
      }
      if (sortUser.role != '') {
        urlRole += '&role=' + sortUser.role;
      }
      if (sortUser.state != '') {
        if (sortUser.state) {
          sortUser.state = 'active'
        } else {
          sortUser.state = 'lock'
        }
        urlState += '&state=' + sortUser.state;
      }
      if (sortUser.keyword != '') {
        urlKeyword += '&keyword=' + sortUser.keyword;
      }
      return `/admin/staffs?page=${this.$store.getters.sortUser.page + urlStore + urlRole + urlState + urlKeyword}`;
    }
  },

  methods: {

    toast(description, type) {

      var color = type == 'success' ? '#40b883' : '#e76666';
      createToast( {description: description},
        {
          showIcon: 'true',
          hideProgressBar: 'true',
          position: 'top-right',
          toastBackgroundColor: color,
          timeout: 2000,
          type: type,
        })
    },

    init() {
      this.userId = this.$route.query.id;
      if (typeof this.userId == 'undefined') {
        this.userId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async handleLock(isLock) {
      let result = await UserCommand.findOne(this.userId);
      result['state'] = !isLock;
      this.$router.push({path: '/admin/staff-info', query: {id: this.userId}});
      this.formData = new FormData();
      this.formData.append('user', JSON.stringify(result));
      let res = await UserCommand.save(this.formData);
      var text = '', type = 'success';
      if (res != null) {
        text = 'Khóa tài khoản thành công';
        await this.getUserById(this.userId);
      } else {
        text = 'Khóa tài khoản thất bại';
        type = 'danger';
      }
      this.toast(text, type);
    },

    async handleDone() {
      this.isEdit = false;
      await this.getUserById(this.userId);
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getUserById(this.userId);
    },

    async getUserById(id) {
      this.user = await UserCommand.findOne(id);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.staff.value = true;
    this.$store.getters.menu.staff.submenu.staffs = true;
    this.init();
    this.getUserById(this.userId);
  }
}
</script>

<style>

</style>