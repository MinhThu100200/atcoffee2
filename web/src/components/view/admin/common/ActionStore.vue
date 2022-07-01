<template>
  <div class="row">
    <div class="col-12">
      <div class="card" :class="this.$route.path.includes('stores') ? 'card-none-margin' : ''">
        <div class="alert alert-danger" role="alert" v-if="error != ''">
            {{error}}
        </div>
        <div class="card-body">
          <form @submit.prevent="handleSave">
            <div class="row">
              <div class="col-9 col">
              <div class="official-info">
                <span class="title">Thông tin cửa hàng</span> 
                <div class="line">
                  <div class="info-group">
                    <label for="code">Mã cửa hàng</label>
                    <input type="text" class="form-control" id="code" v-model="store.code" required :readonly="this.$route.path.includes('store-info')">
                  </div>
                  <div class="info-group flex-3">
                    <label for="name">Tên cửa hàng</label>
                    <input type="text" class="form-control" id="name" v-model="store.name" required>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Thời gian hoạt động</label>
                    <span class="line">
                      <input type="text" class="form-control" id="time-open" v-model="store.timeOpen" required placeholder="hh:mm"> 
                      <span class="sign">-</span>
                      <input type="text" class="form-control" id="time-close" v-model="store.timeClose" required placeholder="hh:mm">
                    </span>
                  </div>
                  <div class="info-group flex-3">
                    <label for="address">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" v-model="store.address" required>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Vĩ độ - Kinh độ</label>
                    <span class="line">
                      <input type="text" class="form-control" id="latitude" v-model="store.latitude" required placeholder="0.00"> 
                      <span class="sign">-</span>
                      <input type="text" class="form-control" id="longitude" v-model="store.longitude" required placeholder="0.00">
                    </span>
                  </div>
                  <div class="info-group flex-3">
                    
                  </div>
                </div>
              </div>
            </div>
            <div class="col-3 col-custom custom-logo col-center info-basic-left image-content">
                <img :src="store.image || url" alt="Ảnh" @click="$refs.file.click()" style="cursor: pointer;">
                <input type="file" accept="image/*" ref="file" name="file" @change="handleSelectedImage" class="invisible"/>
              <!-- <img src="https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png" alt="Hình ảnh"> -->
            </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="this.$route.path.includes('stores')" type="submit" value="Thêm">
              <div class="action-edit" v-else> 
                <input class="btn btn-info" type="submit" value="Cập nhật">
                <input class="btn btn-danger" type="button" value="Hủy" @click="handleCancel">
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
import StoreCommand from '../../../command/StoreCommand'
import StoreEntity from '../../../entities/StoreEntity'
import Spinner from '../../common/popup/Spinner.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_ACTION_STORE,

  components: {
    Spinner,
    AlertPopup
  },

  data() {
    return {
      url: 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png',
      formData: null,
      store: new StoreEntity(),
      error: '',
      isSpinner: false,
      isAlertPopup: false,
      msg: ''
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

    handleSelectedImage() {
      let file = this.$refs.file.files[0];
      this.url = URL.createObjectURL(file);
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleCancel() {
      this.$emit('handleCancel');
    },

    async handleSave() {
      let file = typeof this.$refs.file.files[0] == 'undefined' ? null : this.$refs.file.files[0];
      var validate = await this.validate();
      if (!validate) {
        return;
      }
      this.formData = new FormData();
      this.store.state = this.$route.path.includes('stores') ? true : this.store.state;
      this.formData.append('store', JSON.stringify(this.store));
      this.formData.append('file', file);
      this.isSpinner = true;
      let result = await StoreCommand.save(this.formData);
      this.isSpinner = false;
      result != null && this.$route.path.includes('stores') ? this.clearData() : '';
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('stores') ? 'Thêm cửa hàng thành công' : 'Chỉnh sửa cửa hàng thành công';
      } else {
        text = this.$route.path.includes('stores') ? 'Thêm cửa hàng thất bại' : 'Chỉnh sửa cửa hàng thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$emit('handleDone');
    },

    async validate() {
       if (!this.$route.path.includes('store-info') && this.$refs.file.files[0] == null) {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng chọn ảnh cửa hàng!';
        return false;
      }

      if (this.store.code.trim() == '' || this.store.name.trim() == '' || this.store.timeOpen.trim() == ''
        || this.store.timeClose.trim() == '' || this.store.address.trim() == '') {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng không để trống dữ liệu!';
        return false;
      }
      var store = await this.findStoreByCode(this.store.code);
      if (store != null && store.id != this.store.id) {
        this.isAlertPopup = true;
        this.msg = 'Mã cửa hàng đã tồn tại!';
        return false;
      }
      if (!this.regexTime(this.store.timeOpen) || !this.regexTime(this.store.timeClose)) {
        this.isAlertPopup = true;
        this.msg = 'Thời gian không hợp lệ!';
        return false;
      } else if (this.timeMinutes(this.store.timeOpen) > this.timeMinutes(this.store.timeClose) ){
        this.isAlertPopup = true;
        this.msg = 'Thời gian đóng cửa phải muộn hơn thời gian mở cửa!';
        return false;
      }
      return true;
    },

    regexTime(time) {
      var regex = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/
      return regex.test(time);
    },

    timeMinutes(time) {
      return parseInt(time.split(':')[0]) * 60 + parseInt(time.split(':')[1]);
    },

    clearData() {

      this.url = 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png';
      this.formData = null;
      this.store = new StoreEntity();
      this.error = '';
    },

    async findStoreByCode(code) {
      let result = await StoreCommand.findOneByCode(code);
      return result;
    },

    async loadData() {
      this.isSpinner = true;
      if(this.$route.path.includes('store-info')) {
        this.store = await this.loadStore(this.$route.query.id);
      }
      this.isSpinner = false;
    },

    async loadStore(id) {
      let result = await StoreCommand.findOne(id);
      return result;
    } 
  },

  created(){
    this.loadData();
  }
}
</script>

<style>


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


.card .card-body {
  padding: 15px 25px;
}

.card.card-none-margin {
  margin: 0px;
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

.sign {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0px 4px !important;
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
</style>