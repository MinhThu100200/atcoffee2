<template>
  <admin>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/admin">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Sản phẩm</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách sản phẩm
      </div>
    </section-header>
    <div class="section-body">
      <table-products></table-products>
    </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import TableProducts from '../common/TableProducts.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCTS,

  components: {
    Admin,
    SectionHeader,
    TableProducts
  },

  data() {
    return {
      title: 'Danh sách sản phẩm'
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.product.value = true;
    this.$store.getters.menu.product.submenu.products = true;
  }
}
</script>

<style>

</style>