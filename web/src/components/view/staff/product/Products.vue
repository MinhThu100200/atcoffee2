<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff/products">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="">Sản phẩm</router-link>
      </div>
      <div class="breadcrumb-item">
        Danh sách sản phẩm
      </div>
    </section-header>
    <div class="section-body">
      <products-item></products-item>
    </div>
    <div class="popup">
      <cart-popup :isCartPopup="isCartPopup"></cart-popup>
    </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import ProductsItem from '../common/ProductsItem.vue'
import CartPopup from '../popup/CartPopup.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCTS_STAFF,

  components: {
    Staff,
    SectionHeader,
    ProductsItem,
    CartPopup
  },

  data() {
    return {
      title: 'Danh sách sản phẩm ',
      isCartPopup: true
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU_STAFF);
    this.$store.getters.menuStaff.product.value = true;
  }
}
</script>

<style>

</style>