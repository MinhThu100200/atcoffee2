<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <form class="row" @submit.prevent="handleSubmit">
            <div class="col-3 col-custom col-center info-basic">
              <div id="triangle-left" :class="!user.state && !this.$route.path.includes('add-staff') ? 'visible' : ''">
                <i class="fas fa-lock"></i>
              </div>
              <img :src="user.image" alt="Ảnh" @click="$refs.file.click()">
              <input type="file" accept="image/*" ref="file" name="file" @change="handleSelectedImage" class="invisible"/>
               <div class="form-group">
                 <label></label>
                <input type="text" class="form-control" id="name" v-model="user.name" required placeholder="Tên nhân viên">
              </div>
              <div class="form-group">
                <label></label>
                <input type="text" class="form-control" id="code" v-model="user.code" required placeholder="Mã nhân viên" :readonly="this.$route.path.includes('staff-info')">
              </div>
            </div>
            <div class="col-9 col">
              <div class="official-info">
                <span class="title">Thông tin chính thức</span> 
                <div class="line">
                  <div class="info-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" v-model="user.email" required>
                  </div>
                  <div class="info-group">
                    <label for="phone">Điện thoại</label>
                    <input type="tel" class="form-control" id="phone" v-model="user.phone" required>
                  </div>
                  <div class="info-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" v-model="user.address" required>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label for="identity-card">CMND/CCCD</label>
                    <input type="text" class="form-control" id="identity-card" v-model="user.identityCard" required>
                  </div>
                  <div class="info-group">
                    <label for="dob">Ngày sinh</label>
                    <input type="date" timezone="[[timezone]]" data-date-format="DD MMMM YYYY" class="form-control" id="dob" v-model="user.dob" required>
                  </div>
                  <div class="line">
                    <div class="info-group">
                      <label for="gender">Giới tính</label>
                      <select class="form-control" v-model="user.gender" required>
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                        <option value="Khác">Khác</option>
                      </select>
                    </div>
                    <div class="info-group">
                      <label for="role-name">Chức vụ</label>
                      <select class="form-control" v-model="user.roleName" id="role-name">
                        <option v-for="role in this.$store.getters.roles" :key="role.name" :value="role.name">{{role.name}}</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="official-info">
                <span class="title">Thông tin của hàng</span>
                <div class="line">
                  <div class="info-group">
                    <label for="store-code">Mã cửa hàng</label>
                    <select class="form-control" id="store-code" v-model="user.storeId" @change="handleChangeStore">
                      <option v-for="store in this.$store.getters.stores" :key="store.code"
                        :value="store.id">{{store.code}}</option>
                    </select>
                  </div>
                  <div class="info-group">
                    <label for="store-name">Tên cửa hàng</label>
                    <input type="text" class="form-control" id="store-name" disabled v-model="storeSelected.name">
                  </div>
                  <div class="info-group">
                    <label for="store-address">Địa chỉ</label>
                    <input type="text" class="form-control" id="store-address" disabled v-model="storeSelected.address">
                  </div>
                </div>
              </div>
              <div class="official-info">
                <span class="title">Thông tin đăng nhập</span>
                <div class="line">
                  <div class="info-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" class="form-control" id="username" v-model="user.username" 
                      :required="this.$route.path.includes('add-staff')" :readonly="!this.$route.path.includes('add-staff')">
                  </div>
                  <div class="info-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" v-model="user.password" 
                      :required="this.$route.path.includes('add-staff')" :readonly="!this.$route.path.includes('add-staff')">
                  </div>
                </div>
              </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="btnValue == 'Thêm'" type="submit" :value="btnValue">
              <div class="action-edit" v-else> 
                <input class="btn btn-info" type="submit" :value="btnValue">
                <input class="btn btn-danger" v-if="btnValue != 'Thêm'" type="button" value="Hủy" @click="handleCancel">
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
    <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import UserCommand from '../../../command/UserCommand'
import StoreCommand from '../../../command/StoreCommand'
import RoleCommand from '../../../command/RoleCommand'
import UserEntity from '../../../entities/UserEntity'
import Spinner from '../../common/popup/Spinner.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import vClickOutside from 'click-outside-vue3'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_ACTION_STAFF,

  props: ['type'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner,
    AlertPopup
  },

  data() {
    return {
      user: new UserEntity(),
      isSpinner: false,
      isAlertPopup: false,
      msg: '',
      isSetting: false,
      isEdit: false,
      count: 0,
      storeSelected: {},
      btnValue: 'Thêm'
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

    async init() {
      if (this.$route.path.includes('add-staff') && (typeof this.$route.query.id == 'undefined')) {
        this.user.image = 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png'
        this.user.roleName = Constants.ROLE.ROLE_STAFF;
        this.user.storeId = 1;
        this.user.gender = 'Nam';
        this.user.dob = CommonUtils.formatDateReverse(new Date());
      } else if (this.$route.path.includes('staff-info')){
        var id = this.$route.query.id;
        this.btnValue = 'Sửa';
        if (typeof id != 'undefined') {
          this.isSpinner = true;
          this.user = await this.loadUser(id);
          this.isSpinner = false;
          this.user.dob = CommonUtils.formatDateReverse(new Date(this.user.dob));
        }
      } else if (this.$route.path.includes('profile')) {
        this.btnValue = 'Sửa';
        this.user = {...this.$store.getters.user};
        this.user.dob = CommonUtils.formatDateReverse(new Date(this.user.dob));
      }
      this.storeSelected = this.$store.getters.stores.find(store => store.id == this.user.storeId);      
    },

    handleToggleSetting() {
      this.isSetting = !this.isSetting;
    },

    handleHideSetting() {
      this.isSetting = false;
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleEdit() {
      this.isEdit = true;
    },

    handleCancel() {
      this.$emit('handleCancel');
    },

    handleChangeStore() {
      this.storeSelected = this.$store.getters.stores.find(store => store.id == this.user.storeId);
    },

    handleSelectedImage() {
      let file = this.$refs.file.files[0];
      this.user.image = URL.createObjectURL(file);
    },

    formatDate(date) {
      return CommonUtils.formatDate(date);
    },  

    async handleSubmit() {
      if (await this.validate()) {
        this.$route.path.includes('add-staff') ? this.user['state'] = true : '';
        let file = typeof this.$refs.file.files[0] == 'undefined' ? null : this.$refs.file.files[0];
        this.formData = new FormData();
        this.formData.append('file', file);
        this.formData.append('user', JSON.stringify(this.user));
        this.isSpinner = true;
        let result = await UserCommand.save(this.formData);
        this.isSpinner = false;
        result != null && this.$route.path.includes('add-staff') ? this.clearData() : this.$emit('handleDone');
        var text = '', type = 'success';
        if (result != null) {
          text = this.$route.path.includes('add-staff') ? 'Thêm nhân viên thành công' : 'Chỉnh sửa nhân viên thành công';
        } else {
          text = this.$route.path.includes('add-staff') ? 'Thêm nhân viên thất bại' : 'Chỉnh sửa nhân viên thất bại';
          type = 'danger';
        }
        this.toast(text, type);
      } 
    },

    async validate() {
      if (this.$route.path.includes('add-staff') && this.$refs.file.files[0] == null) {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng chọn ảnh đại diện!';
        return false;
      }
      let result = await UserCommand.validate(this.user.username, this.user.code, this.user.email, this.user.phone, this.user.identityCard);
      if (this.$route.path.includes('add-staff')) {
        for (let i = 0; i < result.length; i++) {
          if (this.user.username == result[i].username) {
            this.isAlertPopup = true;
            this.msg = 'Tên đăng nhập đã tồn tại!';
            return false;
          } else if (this.user.code == result[i].role) {
            this.isAlertPopup = true;
            this.msg = 'Mã nhân viên đã tồn tại!';
            return false;
          } else if (this.user.email == result[i].email) {
            this.isAlertPopup = true;
            this.msg = 'Email đã tồn tại!';
            return false;
          } else if (this.user.phone == result[i].phone) {
            this.isAlertPopup = true;
            this.msg = 'Số điện thoại đã tồn tại!';
            return false;
          } else if (this.user.identityCard == result[i].identityCard) {
            this.isAlertPopup = true;
            this.msg = 'CMND/CCCD đã tồn tại!';
            return false;
          }
        }
      } else {
        for (let i = 0; i < result.length; i++) {
          if (this.user.username == result[i].username && this.user.id != result[i].id) {
            this.isAlertPopup = true;
            this.msg = 'Tên đăng nhập đã tồn tại!';
            return false;
          } else if (this.user.code == result[i].role && this.user.id != result[i].id) {
            this.isAlertPopup = true;
            this.msg = 'Mã nhân viên đã tồn tại!';
            return false;
          } else if (this.user.email == result[i].email && this.user.id != result[i].id) {
            this.isAlertPopup = true;
            this.msg = 'Email đã tồn tại!';
            return false;
          } else if (this.user.phone == result[i].phone && this.user.id != result[i].id) {
            this.isAlertPopup = true;
            this.msg = 'Số điện thoại đã tồn tại!';
            return false;
          } else if (this.user.identityCard == result[i].identityCard && this.user.id != result[i].id) {
            this.isAlertPopup = true;
            this.msg = 'CMND/CCCD đã tồn tại!';
            return false;
          }
        }
      }
      return true;
    },

    clearData() {
      this.user = new UserEntity();
      this.init()
    },

    async loadStores() {
      await StoreCommand.findAll(this.$store);
    },

    async loadRoles() {
      await RoleCommand.findAll(this.$store);
      this.$store.commit(MutationsName.MUTATION_NAME_REMOVE_ROLE_BY_NAME, Constants.ROLE.ROLE_USER);
    },

    async loadUser(id) {
      let result = await UserCommand.findOne(id);
      return result;
    }
  },

  created() {
    this.init();
    this.loadStores();
    this.loadRoles();
  },
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
  cursor:pointer;
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
  flex: 2;
}

.line .line {
  flex: 2;
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

.btn.btn-success, .btn.btn-info, .btn.btn-danger {
  width: 200px;
  margin: 20px auto;
}

form .action .action-edit input:nth-child(1){
  margin-right: 10px;
}

form .action .action-edit input:nth-child(2){
  margin-left: 10px;
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
  display: none;
  border-top-left-radius: .25rem;
  border-top: 80px solid #ccc;
  border-right: 80px solid transparent;
}

#triangle-left.visible {
  display: flex;
}

#triangle-left i {
  position: absolute;
  font-size: 20px;
  top: -68px;
  left: 15px;
  color: #333;
}
</style>