<template>
  <user>
    <product-items></product-items>
  </user>
</template>

<script>
import User from '../main/User.vue'
import * as Constants from '../../../common/Constants'
import ProductCommand from '../../../command/ProductCommand'
import ProductItems from '../common/ProductItems.vue'


export default {
  name: Constants.COMPONENT_NAME_DASHBOARD_USER,

  components: {
    User,
    ProductItems
  },

  data() {
    return {
      categoryCode: '',
    }
  },

  methods: {

    async init(){
      this.categoryCode = this.$route.query.category;
      if (typeof this.categoryCode == 'undefined') {
        this.categoryCode = '';
      }

      await this.loadProducts();
    },

    async loadProducts() {
      await ProductCommand.findAllByOrder(1, Constants.PAGE_SIZE_MAX, '', this.categoryCode, '', this.$store);
    },
  },

  created() {
    this.init();
  }
}
</script>

<style>

</style>