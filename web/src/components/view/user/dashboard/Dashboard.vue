<template>
  <user>
    <product-items></product-items>
  </user>
</template>

<script>
import User from '../main/User.vue'
import * as Constants from '../../../common/Constants'
import ProductItems from '../common/ProductItems.vue'


export default {
  name: Constants.COMPONENT_NAME_DASHBOARD_USER,

  components: {
    User,
    ProductItems
  }
}
</script>

<style>

</style>