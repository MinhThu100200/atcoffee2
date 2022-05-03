<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Cửa hàng</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link :to="linkBackStores">Danh sách cửa hàng</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin cửa hàng
        </div>
      </section-header>
      <div class="section-body">
        <basic-store-info :store="store" @handleEdit="handleEdit" @handleLock="handleLock" v-if="!isEdit"></basic-store-info>
        <action-store v-if="isEdit" @handleCancel="handleCancel" @handleDone="handleDone"></action-store>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import StoreCommand from '../../../command/StoreCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicStoreInfo from '../common/BasicStoreInfo.vue'
import ActionStore from '../common/ActionStore.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_STAFF_INFO,

  components: {
    Admin,
    SectionHeader,
    BasicStoreInfo,
    ActionStore
  },

  data() {
    return {
      title: 'Thông tin cửa hàng',
      store: {},
      storeId: 0,
      isEdit: false
    }
  },

  computed: {
    linkBackStores() {
      var sortStore = this.$store.getters.sortStore;
      var urlKeyword = '';
      if (sortStore.keyword != '') {
        urlKeyword += '&keyword=' + sortStore.keyword;
      }
      return `/admin/stores?page=${this.$store.getters.sortStore.page + urlKeyword}`;
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

    init() {
      this.storeId = this.$route.query.id;
      if (typeof this.storeId == 'undefined') {
        this.storeId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async handleLock(isLock) {
      let action = isLock ? 'Ngừng hoạt động' : 'Mở hoạt động';
      let result = await StoreCommand.findOne(this.storeId);
      result['state'] = !isLock;
      this.formData = new FormData();
      this.formData.append('store', JSON.stringify(result));
      let res = await StoreCommand.save(this.formData);
      var text = '', type = 'success';
      if (res != null) {
        let query = {};
        query.page = this.$store.getters.sortStore.page;
        text = action + ' cửa hàng thành công';
        this.$router.push({path: '/admin/stores', query: query});
      } else {
        text = action + ' cửa hàng thất bại';
        type = 'danger';
      }
      this.toast(text, type);
    },

    async handleDone() {
      this.isEdit = false;
      await this.getStoreById(this.storeId);
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getStoreById(this.storeId);
    },

    async getStoreById(id) {
      this.store = await StoreCommand.findOne(id);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.store.value = true;
    this.init();
    this.getStoreById(this.storeId);
  }
}
</script>

<style>


.fas.fa-info-circle {
  cursor: pointer;
}
</style>