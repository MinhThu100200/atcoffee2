<template>
  <div class="admin">
    <div class="background"></div>
    <side-bar />
    <navbar />
    <div class="section" :class="$store.getters.miniSidebar ? 'active' : ''">
      <slot></slot>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants';
import LoginCommand from '../../../command/LoginCommand'
import StoreCommand from '../../../command/StoreCommand'
import SideBar from '../common/SideBar';
import Navbar from '../../common/common/Navbar.vue'

export default {
  name: Constants.COMPONENT_NAME_STAFF,

  components: {
    SideBar,
    Navbar
  },

  methods: {

    async authenticated () {
      const isAuth = await LoginCommand.authenticated(this.$store);
      if (isAuth != null && isAuth.roleName == Constants.ROLE.ROLE_STAFF) {
        const store = await StoreCommand.findOne(isAuth.storeId);
        if (!store.state) {
          this.$router.push({path: '/login'});
        }
      } else {
        this.$router.push({path: '/login'});
      }
    },

    async getStoreById() {

    }
  },

  created(){
    this.authenticated();
  }
};
</script>

<style>
.background {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: #f4f6f9;
}
</style>
