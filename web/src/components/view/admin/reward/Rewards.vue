<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Phần thưởng</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách phần thưởng
      </div>
    </section-header>
    <div class="section-body">
      <table-rewards @handleAdd="handleAdd"></table-rewards>
    </div>
     <blank-popup :isBlankPopup="isBlankPopup">
        <action-reward v-click-outside="handleHideBlank" @handleDone="handleDone"/>
      </blank-popup>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import RewardCommand from '../../../command/RewardCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableRewards from '../common/TableRewards.vue'
import BlankPopup from '../../common/popup/BlankPopup.vue'
import ActionReward from '../common/ActionReward.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_REWARDS,

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Admin,
    SectionHeader,
    TableRewards,
    ActionReward,
    BlankPopup
  },

  data() {
    return {
      title: 'Danh sách phần thưởng',
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
      await this.loadRewards();
      this.isBlankPopup = false;
    },

    async loadRewards() {
      var page = this.$route.query.page;
      if (typeof page == 'undefined') {
        page = 1;
      }
      var size = Constants.PAGE_SIZE_REWARD;
      var keyword = this.$store.getters.sortReward.keyword;
      await RewardCommand.findByOrder(page, size, keyword, this.$store);
    },

    
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.reward.value = true;
  }
}
</script>

<style>

</style>