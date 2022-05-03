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
                  <router-link to="" class="dropdown-item has-icon" @click="handleLock(reward.state)">
                    <i class="far fa-trash-alt"></i>
                    {{reward.state ? 'Xóa phần thưởng' : ''}}
                  </router-link>
                </div>
              </div>
            <div class="col-12 col">
              <div class="official-info">
                <span class="title">Thông tin phần thưởng</span> 
                <div class="line">
                  <div class="info-group">
                    <label>Mã phần thưởng</label>
                    <span>{{reward.code}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Tên phần thưởng</label>
                    <span>{{reward.name}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Số điểm</label>
                    <span>{{reward.proviso}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Mức giảm</label>
                    <span>{{formatPrice(reward.redution)}}</span>
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
  name: Constants.COMPONENT_NAME_BASIC_REWARD_INFO,

  props: ['reward'],

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