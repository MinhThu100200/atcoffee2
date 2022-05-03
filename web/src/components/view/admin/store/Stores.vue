<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Cửa hàng</router-link>
        </div>
        <div class="breadcrumb-item">
          Danh sách cửa hàng
        </div>
      </section-header>
      <div class="section-body">
        <table-stores @handleAdd="handleAdd"></table-stores>
      </div>
      <blank-popup :isBlankPopup="isBlankPopup">
        <action-store v-click-outside="handleHideBlank" @handleDone="handleDone"/>
      </blank-popup>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import StoreCommand from '../../../command/StoreCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableStores from '../common/TableStores.vue'
import ActionStore from '../common/ActionStore.vue'
import BlankPopup from '../../common/popup/BlankPopup.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_STORES,

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Admin,
    SectionHeader,
    TableStores,
    ActionStore,
    BlankPopup
  },

  data() {
    return {
      title: 'Danh sách cửa hàng',
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
      await this.loadStores(currentPage, Constants.PAGE_SIZE_STORE);
      this.isBlankPopup = false;
    },

    async loadStores(page, size) {
      await StoreCommand.findAllByOrder(page, size, this.keyword, this.$store);
    },
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.store.value = true;
  }
}
</script>

<style>

</style>