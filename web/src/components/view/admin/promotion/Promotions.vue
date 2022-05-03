<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Khuyến mãi</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách khuyến mãi
      </div>
    </section-header>
    <div class="section-body">
      <table-promotions @handleAdd="handleAdd"></table-promotions>
    </div>
     <blank-popup :isBlankPopup="isBlankPopup">
        <action-promotion v-click-outside="handleHideBlank" @handleDone="handleDone"/>
      </blank-popup>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import PromotionCommand from '../../../command/PromotionCommand'
import TypeCommand from '../../../command/TypeCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TablePromotions from '../common/TablePromotions.vue'
import BlankPopup from '../../common/popup/BlankPopup.vue'
import ActionPromotion from '../common/ActionPromotion.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_PROMOTIONS,

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Admin,
    SectionHeader,
    TablePromotions,
    ActionPromotion,
    BlankPopup
  },

  data() {
    return {
      title: 'Danh sách khuyến mãi',
      isBlankPopup: false,
      flag: false
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
      await this.loadPromotions();
      this.isBlankPopup = false;
    },
    
    async loadTypes() {
      await TypeCommand.findAll(this.$store);
    },

    async loadPromotions() {
      var page = this.$route.query.page;
      if (typeof page == 'undefined') {
        page = 1;
      }
      var size = Constants.PAGE_SIZE_PROMOTION;
      var state = this.$store.getters.sortPromotion.state;
      var object = this.$store.getters.sortPromotion.object;
      var keyword = this.$store.getters.sortPromotion.keyword;
      await PromotionCommand.findAllByOrder(page, size, state, object, keyword, this.$store);
    },

    
  },

  created() {
    this.loadTypes();
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.promotion.value = true;
  }
}
</script>

<style>

</style>