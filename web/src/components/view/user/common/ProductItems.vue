<template>
  <section style="background-color: #fff;">
    <div class="container">
      <div class="row">
        <product-item v-for="(product) in this.$store.getters.products" :key="product.id" :product="product"></product-item> 
      </div>
    </div>
   
  </section>
</template>

<script>
import * as Constants from '../../../common/Constants'
import ProductCommand from '../../../command/ProductCommand'
import ProductItem from './ProductItem.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_ITEMS_USER,

  components: {
    ProductItem
  },

  methods: {

    async loadProducts() {
      await ProductCommand.fineAll(1, 100, this.$store);
    }
  },

  created() {
    this.loadProducts();
  }
}
</script>

<style scoped>
section {
  padding: 4px;
}
</style>