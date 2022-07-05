<template>
  <div class="container">
    <rates :product="product"></rates>
  </div>
</template>

<script>

import * as Constants from '../../../common/Constants'
import RateCommand from '../../../command/RateCommand'

import Rates from '../common/TableRates.vue'

export default {
  name: Constants.COMPONENT_NAME_RATE_USER,

  props: ['product'],

  components: {
    Rates
  },

  methods: {

    async loadRates(productId) {
      RateCommand.findByProductIdByUser(1, Constants.PAGE_SIZE_RATE, productId, this.$store);
    }
  },

  created() {
    this.loadRates(this.product.id);
  }
}
</script>

<style scoped>
@media (min-width: 1400px){
  .container {
  max-width: 1200px;
  }
}
</style>