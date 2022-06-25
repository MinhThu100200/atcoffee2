<template>
  <section >
    <div class="container">
      <div v-if="this.$store.getters.products == null || this.$store.getters.products?.length == 0" class="row">
        <span class="no-result">Không có sản phẩm phù hợp</span>
      </div>
      <div class="row">
        <product-item v-for="(product) in this.$store.getters.products" :key="product.id" :product="product"></product-item> 
      </div>
    </div>
  </section>
</template>

<script>
import * as Constants from '../../../common/Constants'
import ProductItem from './ProductItem.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_ITEMS_USER,

  components: {
    ProductItem
  },

}
</script>

<style scoped>
section {
  padding: 4px;
}

.no-result {
  padding-top: 20px;
  font-size: 16px;
  display: flex;
  justify-content: center;
}

@media (min-width: 1400px){
  .container {
  max-width: 1200px;
  }
}
</style>