<template>
  <user>
    <product-detail/>
  </user>
</template>

<script>
import * as Constants from '../../../common/Constants'

import User from '../main/User.vue'
import ProductDetail from '../common/ProductDetail.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_USER,

  components: {
    User,
    ProductDetail
  }
}
</script>

<style scoped>

</style>