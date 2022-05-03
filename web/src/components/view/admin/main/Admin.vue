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
import SideBar from '../common/SideBar.vue';
import Navbar from '../../common/common/Navbar.vue'

export default {
  name: Constants.COMPONENT_NAME_ADMIN,

  components: {
    SideBar,
    Navbar
  },

  methods: {

    async authenticated () {
      const isAuth = await LoginCommand.authenticated(this.$store);
      if (isAuth != null && isAuth.roleName == Constants.ROLE.ROLE_ADMIN) {
        // console.log(isAuth);
      } else {
        this.$router.push({path: '/login'})
      }
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

.main-content {
  position: relative;
  background: #f4f6f9;
}

.section {
  position: absolute;
  top: 80px;
  width: calc(100vw - 60px - 250px);
  z-index: 1;
  margin-left: calc(30px + 250px);
  margin-right: 30px;
  transition: all .5s ease;
}


.section.active {
  position: absolute;
  top: 80px;
  width: calc(100vw - 60px - 65px);
  z-index: 1;
  margin-left: calc(30px + 65px);
  margin-right: 30px;
}

a {
  color: var(--primary);
  font-weight: 500;
  text-decoration: none;
  background: transparent;
}

a:hover {
  text-decoration: underline;
  color: var(--primary);
}
</style>
