<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-12 col">
              <div class="official-info">
                <span class="title">Thông tin khách hàng</span> 
                <div class="line">
                  <div class="info-group">
                    <label for="code">Mã khách hàng</label>
                    <input type="text" class="form-control custom" id="code" v-model="code" @input="handleChangeCode">
                  </div>
                  <div class="info-group">
                    <label >Tên khách hàng</label>
                    <span>{{user != null ? user.name : ''}}</span>
                  </div>
                  <div class="info-group">
                    <label>Giới tính</label>
                    <span>{{user != null ? user.gender : ''}}</span>
                  </div>
                  <div class="info-group">
                    <label>Tổng điểm</label>
                    <span>{{user != null ? user.currentPoints : ''}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label >Email</label>
                    <span>{{user != null ? user.email : ''}}</span>
                  </div>
                  <div class="info-group">
                    <label >Điện thoại</label>
                    <span>{{user != null ? user.phone : ''}}</span>
                  </div>
                  <div class="info-group">
                    <label>Địa chỉ</label>
                    <span>{{user != null ? user.address : ''}}</span>
                  </div>
                   <div class="info-group">
                    <label>Xếp loại</label>
                    <span>{{type != null ? type.name : ''}}</span>
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
import UserCommand from '../../../command/UserCommand'
import TypeCommand from '../../../command/TypeCommand'
import UserEntity from '../../../entities/UserEntity'
import TypeEntity from '../../../entities/TypeEntity'
import Spinner from '../../common/popup/Spinner.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_CUSTOMER_PAYMENT_INFO,
  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner
  },

  data() {
    return {
      user: new UserEntity(),
      store: {},
      type: new TypeEntity(),
      code: '',
      isSpinner: false,
    }
  },

  methods: {

    handleChangeCode() {
      this.code = this.code.toUpperCase();
      this.loadUserByCode(this.code);
    },

    async loadUserByCode(code) {
      let result = await UserCommand.findOneByCode(code); 
      if (result != null) {
        this.user = result;
        this.type = await this.findTypeById(this.user.typeId);
        this.$emit('handleChangeUser', this.user);
      } else {
        this.user = new UserEntity();
        this.type = new TypeEntity();
        this.$emit('handleChangeUser', null);
      }
      return result;
    },

    async findTypeById(id) {
      return await TypeCommand.findOne(id);
    }
  },

  created() {
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
.line .info-group:nth-child(4) {
  flex: 1;
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

.form-control.custom {
  padding: 2px 8px;
}
</style>