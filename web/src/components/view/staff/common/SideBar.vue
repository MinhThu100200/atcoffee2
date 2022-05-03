<template>
  <div class="sidebar-wrapper" :class="$store.getters.miniSidebar ? 'active' : ''">
    <div class="sidebar-brand">
      <a>A&#38;T {{$store.getters.miniSidebar ? '' : 'Coffee'}}</a>
      <!-- <a href="#"><img src="../../../assets/logo.png" alt="logo"></a> -->
    </div>
    <ul class="sidebar-menu">
      <li class="menu-header">{{$store.getters.miniSidebar ? 'QL' : 'QUẢN LÝ'}}</li>
      <li class="nav-item dropdown" :class="menuStaff.product.value ? 'active' : ''">  
        <router-link to="/staff/products" class="nav-link" @click="handleDropdown(menuStaff.product)">
          <i class="fas fa-store"></i>
          <span>Sản phẩm</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menuStaff.payment.value ? 'active' : ''">  
        <router-link to="/staff/payment" class="nav-link" @click="handleDropdown(menuStaff.payment)">
          <i class="fas fa-money-check-alt"></i>
          <span>Thanh toán</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menuStaff.order.value ? 'active' : ''">  
        <router-link to="/staff/orders?page=1" class="nav-link" @click="handleDropdown(menuStaff.order)">
          <i class="fas fa-layer-group"></i>
          <span>Đơn hàng</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menuStaff.notification.value ? 'active' : ''">  
        <router-link to="/staff/notifications?page=1" class="nav-link" @click="handleDropdown(menuStaff.notification)">
          <i class="fas fa-bell"></i>
          <span>Thông báo</span>
        </router-link>
      </li>
      <li class="menu-header">{{$store.getters.miniSidebar ? 'HS' : 'HỒ SƠ'}}</li>
      <li class="nav-item dropdown" :class="[menuStaff.profile.value ? 'active' : '', activeProfile ? 'option' : '']"
      @mouseover="handleMouseOver('activeProfile')" @mouseleave="handleMouseLeave('activeProfile')">
        <router-link to="" class="nav-link has-dropdown" @click="handleDropdown(menuStaff.profile)">
          <i class="fas fa-user"></i>
          <span>Hồ sơ</span>  
          <i class="fas fa-chevron-right"></i>
        </router-link>
        <ul class="dropdown-menu" v-if="$store.getters.miniSidebar">
          <li class="dropdown-title pt-3">Hồ sơ</li>
          <li>
            <router-link to="/staff/profile" class="nav-link" >Thông tin cá nhân</router-link>
          </li>
          <li>
            <router-link to="/staff/profile/change-password" class="nav-link">Đổi mật khẩu</router-link>
          </li>
        </ul>
        <ul class="dropdown-menu" :class="menuStaff.profile.value ? 'visible' : ''" v-else>
          <li :class="menuStaff.profile.submenu.profile ? 'active': ''" @click="handleLink(menuStaff.profile, 'profile')">
            <router-link to="/staff/profile" class="nav-link" >Thông tin cá nhân</router-link>
          </li>
          <li :class="menuStaff.profile.submenu.change_password ? 'active': ''" @click="handleLink(menuStaff.profile, 'change_password')">
            <router-link to="/staff/profile/change-password" class="nav-link">Đổi mật khẩu</router-link>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
import * as Constants from "../../../common/Constants";
import {mapGetters} from 'vuex'

export default {
  name: Constants.COMPONENT_NAME_SIDE_BAR_STAFF,

  computed: {
    ...mapGetters(['menuStaff'])
  },

  data() {
    return {
      activeProfile: false
    }
  },

  methods: {

    handleDropdown(menuItem){
      if (!this.$store.getters.miniSidebar) {
        if (menuItem.value){
          this.setFalseMenuItem(menuItem);
        } else {
          for (var key in this.menuStaff) {
            this.setFalseMenuItem(this.menuStaff[key]);
          }
          menuItem.value = true;
        }
      }
    },

    handleMouseOver(activeName) {
      this.$data[activeName] = true;
    },

    handleMouseLeave(activeName) {
      this.$data[activeName] = false;
    },

    handleLink(menuItem, keySubmenu) {
      this.setFalseSubmenu(menuItem.submenu);
      menuItem.submenu[keySubmenu] = true;
    },

    setFalseMenuItem(menuItem) {
      menuItem.value = false;
      this.setFalseSubmenu(menuItem.submenu);
    },

    setFalseSubmenu(submenu) {
      for (var key in submenu){
        submenu[key] = false;
      }
    }
  },

};
</script>

<style scoped>
.sidebar-wrapper {
  position: fixed;
  display: block;
  font-weight: 400;
  color: #6c757d;
  text-align: left;
  line-height: 21px;
  width: 250px;
  height: 100vh;
  background: #fff;
  scrollbar-width: thin;
  transition: all .5s ease;
}

.sidebar-wrapper.active {
  position: relative !important;
  width: 65px;
}

.sidebar-wrapper.active .sidebar-brand{
  font-size: 14px;
  width: 65px;
}

.sidebar-wrapper.active .sidebar-menu .menu-header{
  text-align: center;
}

.sidebar-wrapper.active ul li{
  transition: all .5s ease-in;
}

.sidebar-wrapper.active ul li a{
  border-radius: 3px;
  height: 45px;
  padding: 0;
  justify-content: center;
  width: 45px;
  margin: 10px;
  transition: all .5s ease;
}


.sidebar-wrapper.active ul li.active a{
  text-align: center;
  background: var(--primary);
  box-shadow: 0 4px 8px #acb5f6;
}

.sidebar-wrapper.active ul li.active a:hover{
  background: var(--primary);
}

.sidebar-wrapper.active ul li.active a i, .sidebar-wrapper.active ul li.active a .b-icon{
  color: #fff;
}

.sidebar-wrapper.active ul li a span {
  display: none;
}

.sidebar-wrapper.active ul li a i:nth-child(3){
  display: none;
}

.sidebar-wrapper.active ul li a i{
  font-size: 18px;
  transition: all .5s ease-in-out;
  margin: 0;
  text-align: center;
}

.sidebar-wrapper.active ul li a .b-icon{
  font-size: 18px;
  transition: all .5s ease-in-out;
  margin: 0;
  text-align: center;
}


.sidebar-wrapper.active .sidebar-menu li ul.dropdown-menu {
  display: none;
}

.sidebar-wrapper.active .sidebar-menu li.option ul.dropdown-menu {
  display: block;
  position: absolute;
  background: #fff;
  left: 65px;
  top: 0px;
  width: 200px;
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
  z-index: 100;
}

.dropdown-menu .dropdown-title {
  text-transform: uppercase;
  font-size: 12px;
  letter-spacing: 1.5px;
  font-weight: 700;
  color: #191d21 !important;
  padding: 10px 20px;
  line-height: 20px;
}

.sidebar-wrapper.active .sidebar-menu > li.option ul.dropdown-menu li a {
  display: block;
  height: 40px;
  padding: 0 20px;
  background: #fff;
  box-shadow: 0 0 0 0;
  width: 180px;
  font-size: 14px;
  text-align: left;
}

.pt-3 {
  padding-top: 1rem !important;
}

.sidebar-wrapper .sidebar-brand {
  display: inline-block;
  height: 60px;
  line-height: 60px;
  text-align: center;
  width: 250px;
  transition: all .5s ease;
}

.sidebar-wrapper .sidebar-brand a {
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  font-weight: 700;
  color: #000;
}

.sidebar-wrapper ul {
  list-style-type: none;
}

.sidebar-wrapper .sidebar-menu {
  line-height: 28px;
  padding: 0;
  margin: 0;
}

.sidebar-wrapper .sidebar-menu .menu-header {
  font-size: 10px;
  color: #a1a8ae;
  text-transform: uppercase;
  letter-spacing: 1.3px;
  font-weight: 600;
  padding: 3px 15px;
}

.sidebar-wrapper .sidebar-menu li.active a {
  color: var(--primary);
  background-color: #f8fafb;
  font-weight: 600;
}

.sidebar-wrapper .sidebar-menu li a {
  position: relative;
  display: flex;
  align-items: center;
  height: 50px;
  padding: 0 20px;
  width: 100%;
  color: #78828a;
  letter-spacing: 0.3px;
  text-decoration: none;
}

.sidebar-wrapper .sidebar-menu .nav-link:hover {
  background: #f8fafb;
  cursor: pointer;
}

.sidebar-wrapper .sidebar-menu li.active a.has-dropdown .fa-chevron-right {
  transform: translate(0, -50%) rotate(90deg);
}

.sidebar-wrapper .sidebar-menu li a.has-dropdown .fa-chevron-right {
  position: absolute;
  top: 50%;
  right: 20px;
  transform: translate(0, -50%);
  font-size: 14px;
  transition: all 0.5s;
  margin: 0;
}

.sidebar-wrapper .sidebar-menu li a i {
  width: 28px;
  margin-right: 20px;
  text-align: center;
}

.sidebar-wrapper .sidebar-menu li a span {
  margin-top: 3px;
  width: 100%;
}

.sidebar-wrapper .sidebar-menu li.active ul.dropdown-menu {
  background-color: #f8fafb;
}

.sidebar-wrapper .sidebar-menu li ul.dropdown-menu {
  display: none;
  position: static;
  float: none;
  width: 100%;
  margin: 0;
  padding: 0;
  box-shadow: none;
  min-width: 10rem;
  transition: all .3s;
}

.sidebar-wrapper .sidebar-menu li ul.dropdown-menu.visible {
  display: block;
}

.sidebar-wrapper .sidebar-menu li ul.dropdown-menu.invisible {
  display: none;
}

.sidebar-wrapper .sidebar-menu li.active ul.dropdown-menu li.active > a {
  color: var(--primary);
  font-weight: 600;
}

.sidebar-wrapper .sidebar-menu li ul.dropdown-menu li a {
  color: #868e96;
  height: 35px;
  padding-left: 65px;
  font-weight: 400;
}

.sidebar-wrapper .sidebar-menu li ul.dropdown-menu li a:hover {
  color: var(--primary);
}

ul:not(.list-unstyled) {
  line-height: 28px;
}

.dropdown-menu {
  border: none;
}

.dropdown-menu a {
  font-size: 13px;
}

.fas {
  display: inline-block;
  font-size: 13px;
  font-weight: 900;
  margin-left: 4px;
}

/* a {
  -webkit-transition: all 0.5s ease;
} */

.fa-fire::before {
  content: "\f06d";
}
</style>
