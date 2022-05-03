<template>
  <div class="row">
    <div class="col-12">
      <div class="card" :class="this.$route.path.includes('categories') ? 'card-none-margin' : ''">
        <div class="alert alert-danger" role="alert" v-if="error != ''">
            {{error}}
        </div>
        <div class="card-body">
          <form @submit.prevent="handleSave">
            <div class="row">
              <div class="col-9 col">
                <div class="official-info">
                  <span class="title">Thông tin loại sản phẩm</span> 
                  <div class="line">
                    <div class="info-group">
                      <label for="code">Mã loại sản phẩm</label>
                      <input type="text" class="form-control" id="code" v-model="category.code" required :readonly="this.$route.path.includes('category-info')">
                    </div>
                    <div class="info-group flex-3">
                      <label for="name">Tên loại sản phẩm</label>
                      <input type="text" class="form-control" id="name" v-model="category.name" required>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="this.$route.path.includes('categories')" type="submit" value="Thêm">
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
import CategoryCommand from '../../../command/CategoryCommand'
import CategoryEntity from '../../../entities/CategoryEntity'
import Spinner from '../../common/popup/Spinner.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_ACTION_CATEGORY,

  components: {
    Spinner,
    AlertPopup
  },

  data() {
    return {
      url: 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png',
      formData: null,
      category: new CategoryEntity(),
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

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleCancel() {
      this.$emit('handleCancel');
    },

    async handleSave() {
      var validate = await this.validate();
      if (!validate) {
        return;
      }
      this.formData = new FormData();
      this.category.state = this.$route.path.includes('categories') ? true : this.category.state;
      this.formData.append('category', JSON.stringify(this.category));
      this.isSpinner = true;
      let result = await CategoryCommand.save(this.formData);
      this.isSpinner = false;
      result != null && this.$route.path.includes('categories') ? this.clearData() : '';
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('categories') ? 'Thêm loại sản phẩm thành công' : 'Chỉnh sửa loại sản phẩm thành công';
      } else {
        text = this.$route.path.includes('categories') ? 'Thêm loại sản phẩm thất bại' : 'Chỉnh sửa loại sản phẩm thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$emit('handleDone');
    },

    async validate() {
       if (this.category.code.trim() == '' || this.category.name.trim() == '') {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng không để trống dữ liệu!';
        return false;
      }
      var category = await this.findCategoryByCode(this.category.code);
      if (category != null && category.id != this.category.id) {
        this.isAlertPopup = true;
        this.msg = 'Mã loại sản phẩm đã tồn tại!';
        return false;
      }
      return true;
    },

    clearData() {

      this.url = 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png';
      this.formData = null;
      this.category = new CategoryEntity();
      this.error = '';
    },

    async findCategoryByCode(code) {
      let result = await CategoryCommand.findOneByCode(code);
      return result;
    },

    async loadData() {
      this.isSpinner = true;
      if(this.$route.path.includes('category-info')) {
        this.category = await this.loadCategory(this.$route.query.id);
      }
      this.isSpinner = false;
    },

    async loadCategory(id) {
      let result = await CategoryCommand.findOne(id);
      return result;
    } 
  },

  created(){
    this.loadData();
  }
}
</script>

<style>

</style>