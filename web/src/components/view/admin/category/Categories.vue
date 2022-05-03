<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Loại sản phẩm</router-link>
        </div>
        <div class="breadcrumb-item">
          Danh sách loại sản phẩm
        </div>
      </section-header>
      <div class="section-body">
        <table-categories @handleAdd="handleAdd"></table-categories>
      </div>
      <blank-popup :isBlankPopup="isBlankPopup">
        <action-category v-click-outside="handleHideBlank" @handleDone="handleDone"/>
      </blank-popup>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CategoryCommand from '../../../command/CategoryCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableCategories from '../common/TableCategories.vue'
import ActionCategory from '../common/ActionCategory.vue'
import BlankPopup from '../../common/popup/BlankPopup.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_CATEGORIES,

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Admin,
    SectionHeader,
    TableCategories,
    ActionCategory,
    BlankPopup
  },

  data() {
    return {
      title: 'Danh sách loại sản phẩm',
      isBlankPopup: false,
      flag: false,
      keyword: ''
    }
  },

  methods: {
    
    handleHideBlank() {
      if (!this.flag) {
        this.isBlankPopup = false;
        this.flag = false;
      } else {
        if (this.isBlankPopup) {
          this.flag = false;
        }
      }
    },

    handleAdd() {
      this.flag = true;
      this.isBlankPopup = true;
    },

    async handleDone() {
      var currentPage = this.$route.query.page;
      if (typeof currentPage == 'undefined') {
        currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.keyword == 'undefined') {
        this.keyword = '';
      }
      await this.loadCategories(currentPage, Constants.PAGE_SIZE_CATEGORY);
      this.isBlankPopup = false;
    },

    async loadCategories(page, size) {
      await CategoryCommand.findAllByOrder(page, size, this.keyword, this.$store);
    },
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.category.value = true;
  }
}
</script>

<style>

</style>