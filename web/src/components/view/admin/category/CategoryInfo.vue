<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Loại sản phẩm</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link :to="linkBackCategories">Danh sách loại sản phẩm</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin loại sản phẩm
        </div>
      </section-header>
      <div class="section-body">
        <basic-category-info :category="category" @handleEdit="handleEdit" @handleLock="handleLock" v-if="!isEdit"></basic-category-info>
        <action-category v-if="isEdit" @handleCancel="handleCancel" @handleDone="handleDone"></action-category>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CategoryCommand from '../../../command/CategoryCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicCategoryInfo from '../common/BasicCategoryInfo.vue'
import ActionCategory from '../common/ActionCategory.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_STAFF_INFO,

  components: {
    Admin,
    SectionHeader,
    BasicCategoryInfo,
    ActionCategory,
  },

  data() {
    return {
      title: 'Thông tin loại sản phẩm',
      category: {},
      categoryId: 0,
      isEdit: false
    }
  },

  computed: {
    linkBackCategories() {
      var sortCategory = this.$store.getters.sortCategory;
      var urlKeyword = '';
      if (sortCategory.keyword != '') {
        urlKeyword += '&keyword=' + sortCategory.keyword;
      }
      return `/admin/categories?page=${this.$store.getters.sortCategory.page + urlKeyword}`;
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
      this.categoryId = this.$route.query.id;
      if (typeof this.categoryId == 'undefined') {
        this.categoryId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async handleLock(isLock) {
      let action = isLock ? 'Ngừng sử dụng' : 'Mở hoạt động';
      let result = await CategoryCommand.findOne(this.categoryId);
      result['state'] = !isLock;
      this.formData = new FormData();
      this.formData.append('category', JSON.stringify(result));
      let res = await CategoryCommand.save(this.formData);
      var text = '', type = 'success';
      if (res != null) {
        let query = {};
        query.page = this.$store.getters.sortCategory.page;
        text = action + ' loại sản phẩm thành công';
        this.$router.push({path: '/admin/categories', query: query});
      } else {
        text = action + ' loại sản phẩm thất bại';
        type = 'danger';
      }
      this.toast(text, type);
    },

    async handleDone() {
      this.isEdit = false;
      await this.getCategoryById(this.categoryId);
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getCategoryById(this.categoryId);
    },

    async getCategoryById(id) {
      this.category = await CategoryCommand.findOne(id);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.category.value = true;
    this.init();
    this.getCategoryById(this.categoryId);
  }
}
</script>

<style>

</style>