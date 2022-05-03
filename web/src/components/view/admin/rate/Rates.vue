<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Đánh giá</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách đánh giá
      </div>
    </section-header>
    <div class="section-body">
      <table-rates></table-rates>
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
// import RateCommand from '../../../command/RateCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableRates from '../common/TableRates.vue'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_RATES,

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Admin,
    SectionHeader,
    TableRates,
  },

  data() {
    return {
      title: 'Danh sách đánh giá',
      isBlankPopup: false,
      flag: false
    }
  },

  methods: {

  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.rate.value = true;
  }
}
</script>

<style>

</style>