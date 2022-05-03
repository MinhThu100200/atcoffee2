<template>
  <div class="row">
    <div class="col-12">
      <div class="card" :class="this.$route.path.includes('promotions') ? 'card-none-margin' : ''">
        <div class="alert alert-danger" role="alert" v-if="error != ''">
            {{error}}
        </div>
        <div class="card-body">
          <form @submit.prevent="handleSave">
            <div class="row">
              <div class="col-12 col">
                <div class="official-info">
                  <span class="title">Thông tin khuyến mãi</span> 
                  <div class="line">
                    <div class="info-group">
                      <label for="code">Mã khuyến mãi</label>
                      <input type="text" class="form-control" id="code" v-model="promotion.code" required :readonly="this.$route.path.includes('promotion-info')">
                    </div>
                    <div class="info-group flex-2">
                      <label for="name">Tên khuyến mãi</label>
                      <input type="text" class="form-control" id="name" v-model="promotion.name" required>
                    </div>
                    <div class="info-group flex-1">
                      <label for="discount">Mức giảm giá (%)</label>
                      <input type="number" class="form-control text-right" id="discount" min="0" max="100" v-model="promotion.discount" required>
                    </div>
                  </div>
                  <div class="line">
                    <div class="info-group">
                      <label for="object">Xếp hạng được sử dụng</label>
                      <select v-model="promotion.object" class="form-control">
                        <option v-for="type in types" :key="type.code" :value="type.code"> {{type.name}}</option>
                      </select>
                    </div>
                    <div class="info-group flex-2">
                      <label>Thời gian hoạt động</label>
                      <span class="line">
                        <input type="date" class="form-control" id="start-date" v-model="promotion.startDate" required placeholder="mm/dd/yyyy"> 
                        <span class="sign">-</span>
                        <input type="date" class="form-control" id="end-date" v-model="promotion.endDate" required placeholder="mm/dd/yyyy">
                      </span>
                    </div>
                    <div class="info-group flex-1">
                      <label for="proviso">Điều kiện đơn hàng tối thiểu (vnđ)</label>
                      <input type="number" class="form-control" id="proviso" v-model="promotion.proviso" required>
                    </div>
                  </div>
                  <div class="line">
                    <div class="info-group">
                      <label>Mô tả</label>
                      <textarea type="number" class="form-control" id="description" v-model="promotion.description" required></textarea>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="this.$route.path.includes('promotions')" type="submit" value="Thêm">
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
import PromotionCommand from '../../../command/PromotionCommand'
import TypeCommand from '../../../command/TypeCommand'
import CommonUtils from '../../../common/CommonUtils'
import PromotionEntity from '../../../entities/PromotionEntity'
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
      formData: null,
      promotion: new PromotionEntity(),
      types: [],
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
      this.promotion.state = this.$route.path.includes('promotions') ? true : this.promotion.state;
      this.promotion.image = '';
      this.formData.append('promotion', JSON.stringify(this.promotion));
      this.isSpinner = true;
      let result = await PromotionCommand.save(this.formData);
      this.isSpinner = false;
      result != null && this.$route.path.includes('promotions') ? this.clearData() : '';
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('promotions') ? 'Thêm khuyến mãi thành công' : 'Chỉnh sửa khuyến mãi thành công';
      } else {
        text = this.$route.path.includes('promotions') ? 'Thêm khuyến mãi thất bại' : 'Chỉnh sửa khuyến mãi thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$emit('handleDone');
    },

    async validate() {
       if (this.promotion.code.trim() == '' || this.promotion.name.trim() == '' || this.promotion.startDate.trim() == ''
        || this.promotion.endDate.trim() == '') {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng không để trống dữ liệu!';
        return false;
      }
      var promotion = await this.findPromotionByCode(this.promotion.code);
      if (promotion != null && promotion.id != this.promotion.id) {
        this.isAlertPopup = true;
        this.msg = 'Mã khuyến mãi đã tồn tại!';
        return false;
      }
      if (!this.regexDate(this.promotion.startDate) || !this.regexDate(this.promotion.endDate)) {
        this.isAlertPopup = true;
        this.msg = 'Thời gian không hợp lệ!';
        return false;
      } else if (this.timeStamp(this.promotion.startDate) > this.timeStamp(this.promotion.endDate) ){
        this.isAlertPopup = true;
        this.msg = 'Thời gian kết thúc phải sau thời gian bắt đầu!';
        return false;
      }
      return true;
    },

    regexDate(date) {
      var regex = /^\d{4}-\d{2}-\d{2}$/
      return regex.test(date);
    },

    timeStamp(date) {
      return new Date(date).getTime();
    },

    loadDate() {
      var now = new Date();
      var nowStr = CommonUtils.formatDateReverse(now);
      this.promotion.startDate = nowStr;
      this.promotion.endDate = nowStr;
    },

    clearData() {
      this.formData = null;
      this.promotion = new PromotionEntity();
      this.error = '';
    },

    async loadTypes() {
      this.types = await TypeCommand.findAll();
      if (this.types != null && this.types.length > 0) {
        this.$route.path.includes('promotions') ? this.promotion.object = this.types[0].code : '';
      }
    },

    async findPromotionByCode(code) {
      let result = await PromotionCommand.findOneByCode(code);
      return result;
    },

    async loadData() {
      this.isSpinner = true;
      if(this.$route.path.includes('promotion-info')) {
        this.promotion = await this.loadPromotion(this.$route.query.id);
        this.promotion.startDate = CommonUtils.formatDateReverse(new Date(this.promotion.startDate));
        this.promotion.endDate = CommonUtils.formatDateReverse(new Date(this.promotion.endDate));
      }
      this.isSpinner = false;
    },

    async loadPromotion(id) {
      let result = await PromotionCommand.findOne(id);
      return result;
    } 
  },

  created(){
    this.loadDate();
    this.loadTypes();
    this.loadData();
  }
}
</script>

<style>
.flex-2 {
  flex: 2 !important;
}

.flex-1 {
  flex: 1 !important;
}

.text-right {
  text-align: right !important;
}
</style>