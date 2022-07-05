<template>
  <staff>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/staff/products">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Hồ sơ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="/staff/profile">Thông tin cá nhân</router-link>
        </div>
        <div class="breadcrumb-item">
          Đổi mật khẩu
        </div>
      </section-header>
      <div class="section-body">
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="col-center card-body">
                <form class="col-change-password" @submit.prevent="handleChangePassword">
                  <div class="alert alert-danger" role="alert" v-if="error != ''">
                      {{error}}
                  </div>
                  <div class="alert alert-success" role="alert" v-if="msg != ''">
                      {{msg}}
                  </div>
                  <div class="form-group form-custom">
                    <label for="old-password">Mật khẩu hiện tại</label>
                    <input type="password" class="form-control" id="old-password" v-model="oldPassword" required>
                  </div>
                  <div class="form-group form-custom">
                    <label for="new-password">Mật khẩu mới</label>
                    <input type="password" class="form-control" id="new-password" v-model="newPassword" required>
                  </div>
                  <div class="form-group form-custom">
                    <label for="confirm-password">Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" id="confirm-password" v-model="confirmPassword" required>
                  </div>
                  <div class="form-group action">
                    <input type="submit" value="Xác nhận" class="btn btn-success">
                  </div>
                </form>
              </div>
            </div>
          </div>
          <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
        </div>
      </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import UserCommand from '../../../command/UserCommand'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import Spinner from '../../common/popup/Spinner.vue'

export default {
  name: Constants.COMPONENT_NAME_CHANGE_PASSWORD_STAFF,

  components: {
    Staff,
    SectionHeader,
    Spinner
  },

  data() {
    return {
      title: 'Đổi mật khẩu',
      isSpinner: false,
      oldPassword: '',
      newPassword: '',
      confirmPassword: '',
      error: '',
      msg: ''
    }
  },

  methods: {
    
    async handleChangePassword() {
      if(this.verify()) {
        this.isSpinner = true;
        let result = await UserCommand.updatePassword(this.$store.getters.user, this.oldPassword, this.newPassword, this.$store);
        this.isSpinner = false;
        if (result == null) {
          this.error = 'Mật khẩu cũ không chính xác!';
          this.msg = '';
        } else {
          this.error = '';
          this.msg = 'Thành công!!!';
          this.oldPassword = '';
          this.newPassword = '';
          this.confirmPassword = '';
        }
      }
    },

    verify() {
      if(this.newPassword !== this.confirmPassword) {
        this.error = 'Mật khẩu xác nhận không trùng khớp!';
        return false;
      }
      this.error = '';
      return this.strengthChecker(this.newPassword);
    },

    strengthChecker(password) {
      let mediumPassword = new RegExp('((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{6,}))|((?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=.{8,}))')
      if (!mediumPassword.test(password)) {
        this.error = 'Mật khẩu phải bao gồm chữ hoa, chữ thường, chữ số và kí tự đặc biệt!';
        this.msg = '';
        return false;
      }
      return true;
    }

  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.profile.value = true;
    this.$store.getters.menuStaff.profile.submenu.change_password = true;
  }
}
</script>

<style>
</style>