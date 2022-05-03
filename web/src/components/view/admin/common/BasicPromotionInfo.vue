<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="dropdown dropdown-setting">
                <i class="fas fa-cog icon-absolute" @click="handleToggleSetting"></i>
                <div class="dropdown-menu dropdown-menu-right show" v-if="isSetting" v-click-outside="handleHideSetting">
                  <a class="dropdown-item has-icon" @click="handleEdit">
                    <i class="fas fa-edit"></i>
                    Chỉnh sửa
                  </a>
                  <router-link to="" class="dropdown-item has-icon" @click="handleLock(promotion.state)">
                    <i class="far fa-trash-alt"></i>
                    {{promotion.state ? 'Xóa mã khuyến mãi' : ''}}
                  </router-link>
                </div>
              </div>
            <div class="col-12 col">
              <div class="official-info">
                <span class="title">Thông tin khuyến mãi</span> 
                <div class="line">
                  <div class="info-group">
                    <label>Mã khuyến mãi</label>
                    <span>{{promotion.code}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Tên khuyến mãi</label>
                    <span>{{promotion.name}}</span>
                  </div>
                   <div class="info-group flex-1">
                    <label>Mức giảm giá</label>
                    <span>{{promotion.discount}}%</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Xếp hạng được sử dụng</label>
                    <span>{{type.name}}</span>
                  </div>
                   <div class="info-group flex-1">
                      <label>Thời gian hoạt động</label>
                      <span class="line">
                        <span>{{formatDate(promotion.startDate)}}</span>
                        <span class="sign-text"> đến </span>
                        <span>{{formatDate(promotion.endDate)}}</span>
                      </span>
                    </div>
                   <div class="info-group flex-1">
                    <label>Điều kiện đơn hàng tối thiểu</label>
                    <span>{{formatPrice(promotion.proviso)}}</span>
                  </div>
                </div>
                <div class="line">
                    <div class="info-group">
                      <label>Mô tả khuyến mãi</label>
                      <span>{{promotion.description}}</span>
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
import Spinner from '../../common/popup/Spinner.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_BASIC_PROMOTION_INFO,

  props: ['promotion', 'type'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner
  },

  data() {
    return {
      isSpinner: false,
      isSetting: false,
      isEdit: false,
      count: 0,
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

    formatDate(timeStamp) {
      return CommonUtils.formatDate(new Date(timeStamp));
    },  

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleLock(isLock) {
      this.isSetting = false;
      this.$emit('handleLock', isLock);
    },
  },
}
</script>

<style>
.sign-text {
  align-items: center;
  padding: 0 8px;
}
</style>