<template>
  <div class="navbar-bg" :class="$store.getters.miniSidebar ? 'active' : ''"></div>  
  <nav class="navbar navbar-expand-lg main-navbar" :class="$store.getters.miniSidebar ? 'active' : ''">
    <form class="form-inline mr-auto">
      <ul class="navbar-nav mr-3">
        <li>
          <span to="" class="nav-link nav-link-lg" data-toggle="sidebar">
            <i class="fas fa-bars" @click="handleToggleSidebar"></i>
          </span>
        </li>
      </ul>
    </form>
    <ul class="navbar-nav navbar-right">
      <li class="dropdown dropdown-list-toggle" v-if="$store.getters.user != null && $store.getters.user.roleName == 'STAFF'">
         <router-link to="" class="nav-link notification-toggle nav-link-lg" :class="this.$store.getters.billsUnread.length > 0 ? 'beep' : ''"
          data-toggle="dropdown" aria-expanded="false">
          <i class="far fa-bell" @click="handleShowNotification(navbar)"></i>
        </router-link>
        <div class="dropdown-menu dropdown-list dropdown-menu-right transition show" v-if="navbar.notification" v-click-outside="handleHideNotification">
          <div class="dropdown-header">
            Thông báo
            <div class="float-right">
              <!-- <router-link to="">Đánh dấu đã đọc tất cả</router-link> -->
            </div>
          </div>
          <div class="dropdown-list-content dropdown-list-icons" style="outline: currentcolor none medium;" tabindex="3">
            <router-link to="" class="dropdown-item" :class="!bill.read ? 'dropdown-item-unread' : ''"
             v-for="bill in $store.getters.billsNotification" :key="bill.id" @click="handleReadBill(bill)">
              <div class="dropdown-item-icon bg-primary text-white">
                <i class="fas fa-bell"></i>
              </div>
              <div class="dropdown-item-desc" v-if="!bill.address">
                Đơn hàng với ID {{bill.code}} được yêu cầu từ khách hàng tại quầy
                <div class="time text-primary">{{fromNow(bill.createdDate)}}</div>
              </div>
              <div class="dropdown-item-desc" v-else>
                Đơn hàng với ID {{bill.code}} được yêu cầu từ khách hàng {{bill.customerName}} vị trí ở {{bill.address}}
                <div class="time text-primary">{{fromNow(bill.createdDate)}}</div>
              </div>
            </router-link>
          </div>
          <div class="dropdown-footer text-center">
            <router-link to="/staff/notifications?page=1">
              Xem tất cả
              <i class="fas fa-chevron-right"></i>
            </router-link>
          </div>
        </div>
      </li>
      <li class="dropdown transition" v-click-outside="handleHide">
        <router-link to="" class="nav-link dropdown-toggle nav-link-lg nav-link-user" data-toggle="dropdown" aria-expanded="false" @click="handleShow(navbar)">
          <img :src="$store.getters.user != null ? $store.getters.user.image : ''" alt="avatar" class="rounded-circle mr-1">
          <div class="d-sm-none d-lg-inline-block">
            {{$store.getters.user != null ? $store.getters.user.name : ''}}
          </div>
        </router-link>
        <div class="dropdown-menu dropdown-menu-right" :class="navbar.dropdown ? 'show' : ''">
          <div class="dropdown-title">Thông tin</div>
            <router-link :to="$route.path.includes('admin') ? '/admin/profile' : '/staff/profile'" class="dropdown-item has-icon">
              <i class="far fa-user"></i> Hồ sơ
            </router-link>
            <!-- <router-link to="/admin" class="dropdown-item has-icon">
              <i class="fas fa-bolt"></i> Hoạt động
            </router-link>
            <router-link to="/admin" class="dropdown-item has-icon">
              <i class="fas fa-cog"></i> Cài đặt
            </router-link>   -->
              <div class="dropdown-divider"></div>
            <router-link to="" class="dropdown-item has-icon text-danger" @click.prevent="handleLogout">
              <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </router-link>
        </div>
      </li>
    </ul>
  </nav>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import LoginCommand from '../../../command/LoginCommand'
import BillDataService from '../../../services/BillDataService'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_NAVBAR,

  data() {
    return {
      navbar: {
        dropdown: false,
        notification: false
      }
    }
  },

  directives: {
      clickOutside: vClickOutside.directive
  },

  methods: {

    init() {
      
      if(this.$store.getters.user.roleName != Constants.ROLE.ROLE_USER) {
        this.getBillsByStoreId();
      }
    },

    fromNow(timeStamp) {
      return CommonUtils.fromNow(timeStamp);
    },

    handleToggleSidebar() {
      this.$store.commit(MutationsName.MUTATION_NAME_SET_MINI_SIDEBAR, !this.$store.getters.miniSidebar);
    },

    handleShow(navbar) {
      navbar.dropdown = !navbar.dropdown;
    },

    handleShowNotification(navbar) {
      this.navbar.notification = !navbar.notification;
    },

    handleHide() {
      this.navbar.dropdown = false;
    },

    handleHideNotification() {
      this.navbar.notification = false;
    },

    handleReadBill(bill) {
      bill.read = true;
      BillDataService.update(bill, this.$store);
      if (!this.$route.path.includes('/order-info')) {
        this.$router.push({path: '/staff/order-info', query: {code: bill.code}});
      } else {
        window.location.href = '/staff/order-info?code=' + bill.code;
      }
    },

    handleLogout() {
      let isLogout = LoginCommand.logout(this.$store);      
      isLogout ? this.$router.push({path: '/login'}) : '';
    },

    getBillsByStoreId() {
      BillDataService.findByStoreId(this.$store);
    },
 },

  created(){
    this.init();
  }
}
</script>

<style scoped>

ul {
  list-style-type: none;
}

a {
  color: var(--primary);
}

.navbar-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  margin-left: 250px;
  width: calc(100vw - 250px);
  height: 115px;
  background: var(--primary);
  z-index: 0;
  transition: all .5s ease;
}

.navbar-bg.active {
  margin-left: 65px;
  width: calc(100vw - 65px);

}

.navbar.active {
  left: 65px;
  width: calc(100% - 70px);
}

.navbar {
  position: absolute;
  transition: all .5s;
  align-items: center;
  height: 70px;
  right: 5px;
  top: 5px;
  z-index: 890;
  background: transparent;
  display: flex;
  flex-direction: row;
  padding: 0.5rem 1rem;
  width: calc(100% - 255px);
  left: 250px;
}

.navbar-expand-lg {
  flex-flow: row nowrap;
  justify-content: flex-start;
}

.navbar-expand-lg .navbar-nav{
  display: flex;
  flex-direction: row;
  padding-left: 0;
  margin-bottom: 0;
  list-style: none;
}

.rounded-circle {
  height: 30px;
  width: 30px;
}

.navbar .nav-link {
  display: block;
  padding-left: 15px !important;
  padding-right: 15px !important;
  padding-top: 0px !important;
  padding-bottom: 0px !important;
  height: 100%;
}

.dropdown-toggle {
  white-space: nowrap;
}

.dropdown-toggle::after {
  display: inline-block;
  margin-left: 0.255rem;
  content: "";
  border-top: 0.3rem solid;
  border-right: 0.3rem solid transparent;
  border-bottom: 0;
  border-left: 0.3rem solid transparent;
}

.beep {
  position: relative;
}

.beep::after {
  content: '';
  position: absolute;
  top: 2px;
  right: 8px;
  width: 7px;
  height: 7px;
  background-color: #ffa426;
  border-radius: 50%;
  animation: pulsate 1s ease-out;
  animation-iteration-count: infinite;
  opacity: 1;
}

@keyframes pulsate {
  0% {
    --webkit-transform: scale(0.1, 0.1);
    opacity: 0.0;
  }
  50% {
    opacity: 1.0;
  }
  100% {
    --webkit-transfrom: scale(1.2, 1.2);
    opacity: 0.0;
  }
}

.navbar .nav-link.nav-link-user {
  color: #fff;
  font-weight: 600;
}

.navbar .nav-link.nav-link-user img {
  width: 30px;
}

.navbar .nav-link.nav-link-lg i {
  margin-left: 0 !important;
  font-size: 18px;
  line-height: 32px;
  color: #fff;
}

.mr-1 {
  margin-right: 0.25rem !important;
}

.navbar .navbar-link.nav-link-lg {
  margin-top: 3px;
}

.d-lg-inline-block {
  display: inline-block !important;
}

.navbar-expand-lg .navbar-nav .dropdown-menu {
  position: absolute;
  float:none;
  box-shadow: 0 10px 40px 0 rgba(51, 73, 94, 0.15);
  border: none;
  width: 200px;
  top: 100%;
  z-index: 1000;
  min-width: 10rem;
  padding: 0.5rem 0;
  margin: 0.125rem 0 0;
  font-size: 1rem;
  color: #212529;
  text-align: left;
  background: #fff;
  background-clip: padding-box;
  border-radius: 0.25rem;
  transition: all 0.3s;
}

.dropdown-menu.show {
  display: block !important;
}

.dropdown-menu-right {
  right: 0;
  left: auto;
}

.dropdown-menu .dropdown-title{
  text-transform: uppercase;
  font-size: 10px;
  letter-spacing: 1.5px;
  font-weight: 700;
  color: #191d21 !important;
  padding: 10px 20px;
  line-height: 20px;
}

.dropdown-menu a {
  font-size: 13px;
  text-decoration: none;
}

.dropdown-item {
  display: block;
  width: 100%;
  clear: both;
  color: #212529;
  text-align: inherit;
  white-space: nowrap;
  background: transparent;
  border: 0;
}

a.dropdown-item {
  padding: 10px 20px;
  font-weight: 500;
  line-height: 1.2;
}

.dropdown-item.has-icon i {
  margin-top: -1px;
  font-size: 13px;
  text-align: center;
  width: 15px;
  float: left;
  margin-right: 10px;
}

.dropdown-list {
  width: 350px !important;
  padding: 0;
}

.dropdown-list .dropdown-header {
  letter-spacing: .5px;
  font-weight: 600;
  padding: 15px;
}

.dropdown-header {
  display: block;
  margin-bottom: 0;
  font-size: .875rem;
  color: #6c757d;
  white-space: nowrap;
}

.float-right {
  float: right !important;
}

.dropdown-list .dropdown-header a {
  font-weight: 600;
  font-size: 13px;
  color: var(--primary);
}

.dropdown-list .dropdown-header a:hover {
  text-decoration: underline;
}


.dropdown-list .dropdown-list-content {
  height: 350px;
  width: 100%;
  overflow-y: auto;
  scrollbar-width: thin;
}

.dropdown-list .dropdown-list-icons .dropdown-item {
  display: flex;
}

.dropdown-list .dropdown-list-icons .dropdown-item:active {
  background: var(--lightGreen);
}

.dropdown-list .dropdown-item.dropdown-item-unread {
  background: #f8f8f8;
  border-bottom-color: #f2f2f2;
}

.dropdown-list .dropdown-item.dropdown-item-unread:hover {
  background: #f2f2f2;
  border-bottom-color: #f2f2f2;
}

.dropdown-list .dropdown-item {
  width: 100%;
  padding-top: 15px;
  padding-bottom: 15px;
  font-size: 13px;
  border-bottom: 1px solid #f9f9f9;
}

.dropdown-list .dropdown-list-icons .dropdown-item .dropdown-item-icon {
  flex-shrink: 0;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  line-height: 42px;
  text-align: center;
}

.dropdown-list .dropdown-list-icons .dropdown-item .dropdown-item-icon i {
  margin: 0;
}

.dropdown-list .dropdown-list-icons .dropdown-item .dropdown-item-desc {
  margin-left: 15px;
  line-height: 20px;
}

.dropdown-list .dropdown-item .dropdown-item-desc {
  white-space: normal;
  color: #34395e;
}

.dropdown-list .dropdown-list-icons .dropdown-item .dropdown-item-desc .time {
  margin-top: 5px;
}

.dropdown-list .dropdown-item .time {
  font-weight: 600;
  text-transform: uppercase;
  font-size: 10px;
  letter-spacing: .5px;
}

.dropdown-list .dropdown-footer {
  letter-spacing: 0.5px;
  font-weight: 600;
  padding: 15px;
}

.dropdown-list .dropdown-footer a{
  font-weight: 600;
  font-size: 13;
}

.dropdown-list .dropdown-footer a:hover{
  color: var(--primary);
  text-decoration: underline;
}

.dropdown-list .dropdown-footer i{
  color: var(--primary);
}

.dropdown-menu.transition {
  transition: all .3s;
}

.text-center {
  text-align: center !important;
}

.text-width {
  color: #fff !important;
}

.bg-primary {
  background: var(--primary);
}

.form-inline {
  display: flex;
  flex-flow: row wrap;
  align-items: center;
}

.form-inline .navbar-nav li span{
  cursor: pointer;
}

.mr-auto {
  margin-right: auto !important;
}
</style>