<template>
  <div>
    <side-bar />
    <navbar />
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import SideBar from '../common/SideBar.vue'
import Navbar from '../../common/common/Navbar.vue'

export default {
  name: Constants.COMPONENT_NAME_STATISTICS,

  components: {
    SideBar,
    Navbar
  }
}
</script>

<style>

</style>