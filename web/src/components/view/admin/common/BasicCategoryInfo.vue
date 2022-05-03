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
                  <router-link to="" class="dropdown-item has-icon" @click="handleLock(category.state)">
                    <i class="far fa-trash-alt"></i>
                    {{category.state ? 'Ngừng sử dụng' : 'Mở hoạt động'}}
                  </router-link>
                </div>
              </div>
            <div class="col-9 col">
              <div class="official-info">
                <span class="title">Thông tin loại sản phẩm</span> 
                <div class="line">
                  <div class="info-group">
                    <label>Mã loại sản phẩm</label>
                    <span>{{category.code}}</span>
                  </div>
                  <div class="info-group flex-4">
                    <label>Tên loại sản phẩm</label>
                    <span>{{category.name}}</span>
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
import Spinner from '../../common/popup/Spinner.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_BASIC_STORE_INFO,

  props: ['category', 'type'],

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

    handleLock(isLock) {
      this.isSetting = false;
      this.$emit('handleLock', isLock);
    },
  },
}
</script>

<style>

</style>