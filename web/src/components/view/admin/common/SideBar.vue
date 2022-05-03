<template>
  <div class="sidebar-wrapper" :class="$store.getters.miniSidebar ? 'active' : ''">
    <div class="sidebar-brand">
      <a>A&#38;T{{$store.getters.miniSidebar ? '' : ' Coffee'}}</a>
      <!-- <a href="#"><img src="../../../assets/logo.png" alt="logo"></a> -->
    </div>
    <ul class="sidebar-menu">
      <li class="menu-header">{{$store.getters.miniSidebar ? 'DB' : 'DASHBOARD'}}</li>
      <li class="nav-item dropdown" :class="menu.dashboard.value ? 'active' : ''">
        <router-link to="/admin" class="nav-link" @click="handleDropdown(menu.dashboard)">
          <i class="fas fa-fire"></i>
          <span>Dashboard</span>
        </router-link>
      </li>
      <li class="menu-header">{{$store.getters.miniSidebar ? 'QL' : 'QUẢN LÝ'}}</li>
      <li class="nav-item dropdown" :class="[menu.product.value ? 'active' : '', activeProduct ? 'option' : '']" 
      @mouseover="handleMouseOver('activeProduct')" @mouseleave="handleMouseLeave('activeProduct')">
        <router-link to="" class="nav-link has-dropdown" @click="handleDropdown(menu.product)" >
          <i class="fas fa-coffee"></i>
          <span>Sản phẩm</span>
          <i class="fas fa-chevron-right"></i>
        </router-link>
        <ul class="dropdown-menu" v-if="$store.getters.miniSidebar">
          <li class="dropdown-title pt-3">Sản phẩm</li>
          <li>
            <router-link to="/admin/products?page=1" class="nav-link" >Danh sách sản phẩm</router-link>
          </li>
          <li>
            <router-link to="/admin/add-product" class="nav-link">Thêm sản phẩm</router-link>
          </li>
        </ul>
        <ul class="dropdown-menu" :class="menu.product.value ? 'visible' : ''" v-else>
          <li :class="menu.product.submenu.products ? 'active': ''" @click="handleLink(menu.product, 'products')">
            <router-link to="/admin/products?page=1" class="nav-link" >Danh sách sản phẩm</router-link>
          </li>
          <li :class="menu.product.submenu.add_product ? 'active': ''" @click="handleLink(menu.product, 'add_product')">
            <router-link to="/admin/add-product" class="nav-link">Thêm sản phẩm</router-link>
          </li>
        </ul>
      </li>
      <li class="nav-item dropdown" :class="[menu.staff.value ? 'active' : '', activeStore ? 'option' : '']"
      @mouseover="handleMouseOver('activeStore')" @mouseleave="handleMouseLeave('activeStore')">
        <router-link to="" class="nav-link has-dropdown" @click="handleDropdown(menu.staff)" >
          <i class="fas fa-users"></i>
          <span>Nhân viên</span>
          <i class="fas fa-chevron-right"></i>
        </router-link>
         <ul class="dropdown-menu" v-if="$store.getters.miniSidebar">
          <li class="dropdown-title pt-3">Nhân viên</li>
          <li>
            <router-link to="/admin/staffs?page=1" class="nav-link" >Danh sách nhân viên</router-link>
          </li>
          <li>
            <router-link to="/admin/add-staff" class="nav-link">Thêm nhân viên</router-link>
          </li>
        </ul>
        <ul class="dropdown-menu" :class="menu.staff.value ? 'visible' : ''" v-else>
          <li :class="menu.staff.submenu.staffs ? 'active': ''" @click="handleLink(menu.staff, 'staffs')">
            <router-link to="/admin/staffs?page=1" class="nav-link" >Danh sách nhân viên</router-link>
          </li>
          <li :class="menu.staff.submenu.add_staff ? 'active': ''" @click="handleLink(menu.staff, 'add_staff')">
            <router-link to="/admin/add-staff" class="nav-link">Thêm nhân viên</router-link>
          </li>
        </ul>
      </li>
      <li class="nav-item dropdown" :class="menu.store.value ? 'active' : ''">  
        <router-link to="/admin/stores?page=1" class="nav-link" @click="handleDropdown(menu.store)">
          <i class="fas fa-store"></i>
          <span>Cửa hàng</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menu.category.value ? 'active' : ''">  
        <router-link to="/admin/categories?page=1" class="nav-link" @click="handleDropdown(menu.category)">
          <i class="fas fa-box-open"></i>
          <span>Loại sản phẩm</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menu.promotion.value ? 'active' : ''">  
        <router-link to="/admin/promotions?page=1" class="nav-link" @click="handleDropdown(menu.promotion)">
          <i class="fas fa-percent"></i>
          <span>Khuyến mãi</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menu.reward.value ? 'active' : ''">  
        <router-link to="/admin/rewards?page=1" class="nav-link" @click="handleDropdown(menu.reward)">
          <b-icon-bookmark-star-fill class="b-icon"></b-icon-bookmark-star-fill>
          <span>Phần thưởng</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menu.rate.value ? 'active' : ''">  
        <router-link to="/admin/rates?page=1" class="nav-link" @click="handleDropdown(menu.rate)">
          <i class="fas fa-star-half-alt"></i>
          <span>Đánh giá</span>
        </router-link>
      </li>
      <li class="menu-header">{{$store.getters.miniSidebar ? 'TK' : 'THỐNG KÊ'}}</li>
      <li class="nav-item dropdown" :class="menu.order_statistics.value ? 'active' : ''">  
        <router-link to="/admin/statistics/orders?page=1" class="nav-link" @click="handleDropdown(menu.order_statistics)">
          <i class="fas fa-layer-group"></i>
          <span>Đơn hàng</span>
        </router-link>
      </li>
      <li class="nav-item dropdown" :class="menu.staff_statistics.value ? 'active' : ''">  
        <router-link to="/admin/statistics/staffs?page=1" class="nav-link" @click="handleDropdown(menu.staff_statistics)">
          <i class="fas fa-users"></i>
          <span>Nhân viên</span>
        </router-link>
      </li>
      <li class="menu-header">{{$store.getters.miniSidebar ? 'HS' : 'HỒ SƠ'}}</li>
      <li class="nav-item dropdown" :class="[menu.profile.value ? 'active' : '', activeProfile ? 'option' : '']"
      @mouseover="handleMouseOver('activeProfile')" @mouseleave="handleMouseLeave('activeProfile')">
        <router-link to="" class="nav-link has-dropdown" @click="handleDropdown(menu.profile)">
          <i class="fas fa-user"></i>
          <span>Hồ sơ</span>
          <i class="fas fa-chevron-right"></i>
        </router-link>
        <ul class="dropdown-menu" v-if="$store.getters.miniSidebar">
          <li class="dropdown-title pt-3">Hồ sơ</li>
          <li>
            <router-link to="/admin/profile" class="nav-link" >Thông tin cá nhân</router-link>
          </li>
          <li>
            <router-link to="/admin/profile/change-password" class="nav-link">Đổi mật khẩu</router-link>
          </li>
        </ul>
        <ul class="dropdown-menu" :class="menu.profile.value ? 'visible' : ''" v-else>
          <li :class="menu.profile.submenu.profile ? 'active': ''" @click="handleLink(menu.profile, 'profile')">
            <router-link to="/admin/profile" class="nav-link" >Thông tin cá nhân</router-link>
          </li>
          <li :class="menu.profile.submenu.change_password ? 'active': ''" @click="handleLink(menu.profile, 'change_password')">
            <router-link to="/admin/profile/change-password" class="nav-link">Đổi mật khẩu</router-link>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
import * as Constants from "../../../common/Constants";
import {mapGetters} from 'vuex'
import {BIconBookmarkStarFill} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_SIDE_BAR,

  components: {
    BIconBookmarkStarFill
  },

  computed: {
    ...mapGetters(['menu'])
  },

  data() {
    return {
      activeProduct: false,
      activeStore: false,
      activeProfile: false
    }
  },

  methods: {

    handleDropdown(menuItem){
      if (!this.$store.getters.miniSidebar) {
        if (menuItem.value){
          this.setFalseMenuItem(menuItem);
        } else {
          for (var key in this.menu) {
            this.setFalseMenuItem(this.menu[key]);
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
  position: relative;
  width: 65px !important;
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

.sidebar-wrapper.active ul li a span:nth-child(2) {
  visibility: hidden;
  opacity: 0;
  width: 0;
}

.sidebar-wrapper.active ul li a i:nth-child(3){
  display: none;
}

.sidebar-wrapper.active ul li a i, .sidebar-wrapper.active ul li a .b-icon{
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
  opacity: 1;
  visibility: visible;
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

.sidebar-wrapper .sidebar-menu li a i, .sidebar-wrapper .sidebar-menu li a .b-icon{
  width: 28px;
  margin-right: 20px;
  text-align: center;
}

.sidebar-wrapper .sidebar-menu li a span {
  margin-top: 3px;
  width: 165px;
  transition: all .5s ease;
  opacity: 1;
  visibility: visible;
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
  transition: all .5s;
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
