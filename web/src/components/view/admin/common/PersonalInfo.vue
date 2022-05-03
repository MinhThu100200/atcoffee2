<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-3 col-custom col-center info-basic">
              <div id="triangle-left" v-if="!user.state">
                <i class="fas fa-lock"></i>
              </div>
              <img :src="user.image" alt="Ảnh đại diện">
              <span class="name">{{user.name}}</span>
              <span class="code">{{user.code}}</span>
              <span class="createdDate">Thành viên kể từ: {{formatDate(new Date(user.createdDate))}}</span>
            </div>
            <div class="col-9 col">
              <div class="official-info">
                <div class="dropdown dropdown-setting">
                  <i class="fas fa-cog icon-absolute" @click="handleToggleSetting"></i>
                  <div class="dropdown-menu dropdown-menu-right show" v-if="isSetting" v-click-outside="handleHideSetting">
                    <a class="dropdown-item has-icon" @click="handleEdit" v-if="this.$store.getters.user.roleName == 'ADMIN'">
                      <i class="fas fa-user-edit"></i>
                      Chỉnh sửa
                    </a>
                    <router-link :to="$route.path.includes('admin') ? '/admin/profile/change-password' : '/staff/profile/change-password'"
                     class="dropdown-item has-icon" v-if="type == 'profile'">
                      <i class="fas fa-lock"></i>
                      Đổi mật khẩu
                    </router-link>
                    <router-link to="" 
                      class="dropdown-item has-icon" v-if="type == 'info' && this.$store.getters.user.id != user.id"
                      @click="handleLock(user.state)">
                      <i class="fas" :class="user.state ? 'fa-lock' : 'fa-unlock'"></i>
                      {{user.state ? 'Khóa tài khoản' : 'Mở khóa tài khoản'}}
                    </router-link>
                  </div>
                </div>
                <span class="title">Thông tin chính thức</span> 
                <div class="line">
                  <div class="info-group">
                    <label >Email</label>
                    <span>{{user.email}}</span>
                  </div>
                  <div class="info-group">
                    <label >Điện thoại</label>
                    <span>{{user.phone}}</span>
                  </div>
                  <div class="info-group">
                    <label>Địa chỉ</label>
                    <span>{{user.address}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label >CMND/CCCD</label>
                    <span>{{user.identityCard}}</span>
                  </div>
                  <div class="info-group">
                    <label >Ngày sinh</label>
                    <span>{{formatDate(new Date(user.dob))}}</span>
                  </div>
                  <div class="line">
                    <div class="info-group">
                      <label >Giới tính</label>
                      <span>{{user.gender}}</span>
                    </div>
                    <div class="info-group">
                      <label >Chức vụ</label>
                      <span>{{user.roleName}}</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="official-info">
                <span class="title">Thông tin của hàng</span>
                <div class="line">
                  <div class="info-group">
                    <label >Mã cửa hàng</label>
                    <span>{{store.code}}</span>
                  </div>
                  <div class="info-group">
                    <label >Tên cửa hàng</label>
                    <span>{{store.name}}</span>
                  </div>
                  <div class="info-group">
                    <label >Địa chỉ</label>
                    <span>{{store.address}}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import StoreCommand from '../../../command/StoreCommand'
import Spinner from '../../common/popup/Spinner.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_PERSONAL_INFO,

  props: ['user', 'type'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner
  },

  data() {
    return {
      store: {},
      isSpinner: false,
      isSetting: false,
      isEdit: false,
      count: 0
    }
  },

  methods: {

    handleToggleSetting() {
      this.isSetting = !this.isSetting;
    },

    handleHideSetting() {
      this.isSetting = false;
    },

    handleEdit() {
      this.$emit('handleEdit');
    },

    formatDate(date) {
      return CommonUtils.formatDate(date);
    },  

    handleLock(isLock) {
      this.isSetting = false;
      this.$emit('handleLock', isLock);
    },

    async getStore(id) {
      let store = await StoreCommand.findOne(id);
      if (store != null) {
        this.store = store;
      }
    }
  },

  created() {
  },

  updated() {
    this.$nextTick(() => {
      if (this.count++ == 0) {
        this.getStore(this.user.storeId);
      }
    })
  }
}
</script>

<style scoped>

.col-center {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.info-basic {
  border-right: 0.5px solid #c2c2c2;
}

.col-custom img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  border: 5px solid #eaeaea;
}

.col-custom .name {
  font-size: 20px;
  font-weight: 600;
  color: #626262;
  margin-top: 28px;
}

.col-custom .code {
  font-size: 14px;
  font-weight: 600;
  color: #626262;
  margin-top: 12px;
}

.col-custom .createdDate {
  color: #626262;
  font-size: 14px;
  margin-top: 20px;
}

.official-info {
  position: relative;
  padding: 10px 0;
  width: 100%;
}

.official-info .dropdown-setting {
  position: relative;
  right: 0;
}

.dropdown-setting .icon-absolute {
  position: absolute;
  right: 0;
  font-size: 16px;
  cursor: pointer;
  color: #212529;
} 

.dropdown-setting .dropdown-menu {
  position: absolute;
  right: 0;
  top: 20px;
  background: white;
  border: none;
  box-shadow: 0 5px 20px 0 rgba(51, 73, 94, 0.15);
}

.dropdown-menu a {
  font-size: 13px;
  text-decoration: none;
}

a.dropdown-item {
  padding: 10px 20px;
  font-weight: 500;
  line-height: 1.2;
}

.dropdown-item.has-icon i {
  margin-top: -1px;
  font-size: 13px;
  text-align: center;
  width: 15px;
  float: left;
  margin-right: 10px;
}

.dropdown-setting .dropdown-menu .dropdown-item{
  cursor: pointer;
}

.dropdown-setting .dropdown-menu .dropdown-item:hover{
  text-decoration: none;
}


.official-info .title {
  font-size: 16px;
  font-weight: 500;
  color: #707070;
  margin-left: 40px;
  padding: 5px 0;
}

.line {
  display: flex;
  flex-direction: row;
}

.line .info-group {

  display: flex;
  flex-direction: column;
  margin-left: 40px;
  width: 400px;
  padding: 10px 0;
}

.line .info-group:nth-child(1) {
  flex: 1;
}

.line .info-group:nth-child(2) {
  flex: 1;
}

.line .info-group:nth-child(3) {
  flex: 3;
}

.line .info-group label {
  font-size: 15px;
  font-weight: bold;
  color: #626262;
}

.line .info-group span {
  font-size: 14px;
  color: #707070;
  margin: 4px 0 0 0;
}

.line .line {
  flex: 3;
  margin-left: 40px;
}

.line .line .info-group{
  flex: 1;
  width: auto;
}

.line .line .info-group:nth-child(1){
  flex: 1;
  margin-left: 0px;
  width: auto;
}

input:focus {
  box-shadow: none;
  border: 1px solid var(--primary);
}

textarea:focus {
  box-shadow: none;
  border: 1px solid var(--primary);
}

form .form-group {
  margin-top: 10px;
}

.card .card-body {
  padding: 15px 25px;
}

.row {
  display: flex;
}

.row .col-8 {
  flex: 1;
}

.row .col-4 {
  min-width: 440px;
}

.form-group-horizontal {
  display: flex;
  overflow-x: auto;
  margin-top: 4px;
}

.form-group-horizontal .chip {
  height: 32px;
  min-width: 120px;
  padding: 5px 20px;
  border: 1px solid var(--primary);
  border-radius: 50px;
  margin-right: 10px;
  color: #212529;
  text-align: center;
}

.form-group.horizontal {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-top: 0px;
}

.form-group.horizontal label{
  margin-right: 8px;
}


.form-group.horizontal input {
  flex: 1;
  margin-right: 8px;
}

.form-group.horizontal input[type="number"] {
  text-align: right;
}

input[type="number"] {
  text-align: right;
}


.form-group-horizontal .chip:hover {
  background: var(--primary);
  color: #fff;
  cursor: pointer;
}

.form-group-horizontal .chip.selected {
  background: var(--primary);
  color: #fff;
}

.img-content {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
}

.img-content img{
  width: 400px;
  height: 400px;
  overflow: hidden;
  object-fit: cover;
  cursor: pointer;
  border-radius: 4px;
  margin-top: 8px;
}

.alert.alert-danger {
  margin: 4px !important;
  transition: all .3s;
}

form .action {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.btn.btn-success {
  width: 200px;
  margin: 20px auto;
}

.invisible {
  display: none;
}

#triangle-left {
  position: absolute;
  top: 0px;
  left: 0px;
	width: 0;
  height: 0;
  border-top-left-radius: .25rem;
  border-top: 80px solid #ccc;
  border-right: 80px solid transparent;
}

#triangle-left i {
  position: absolute;
  font-size: 20px;
  top: -68px;
  left: 15px;
  color: #333;
}

</style>