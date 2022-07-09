<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <header class="header-meta">
          <div class="flex-left">
            <div class="item"><b-icon-download class="b-icon"/><span>Tải ứng dụng</span></div>
            <span class="v-line">|</span>
            <div class="item"><b-icon-telephone class="b-icon"/><span>Liên hệ:&nbsp;<a href="tel:0392889894"> 0392.889.894</a></span></div>
          </div>
          <div class="flex-right">
            <div class="item" v-if="$store.getters.user == null">
              <router-link to="/login" class="flex"><b-icon-box-arrow-in-right class="b-icon"/><span>Đăng nhập</span></router-link>
            </div>
            <div v-if="$store.getters.user != null" class="item">
              <li class="dropdown transition">
                <a href="#" class="nav-link dropdown-toggle nav-link-lg nav-link-user" data-toggle="dropdown" aria-expanded="false">
                  <img :src="$store.getters.user.image"/>
                  <span>{{$store.getters.user.name}}</span>
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                  <div class="dropdown-title">Thông tin</div>
                    <router-link :to="'/profile'" class="dropdown-item has-icon">
                      <i class="far fa-user"></i> Hồ sơ
                    </router-link>
                    <div class="dropdown-divider"></div>
                  <router-link to="" class="dropdown-item has-icon text-danger" @click.prevent="handleLogout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                  </router-link>
                </div>
              </li>
            </div>
          </div>
        </header>
      </div>
    </div>
  </div>
  <div class="navbar-container">
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <router-link class="navbar-brand header-logo" to="" @click="handleChangeCategory('')">
          <span>A&amp;T COFFEE</span>
        </router-link>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item" v-if="this.$store.getters.categories?.length > 0">
              <router-link class="nav-link" to="" @click="handleChangeCategory(this.$store.getters.categories[0].code)">
                {{this.$store.getters.categories[0].name}}
              </router-link>
            </li>
            <li class="nav-item" v-if="this.$store.getters.categories?.length > 1">
              <router-link class="nav-link" to="" @click="handleChangeCategory(this.$store.getters.categories[1].code)">
                {{this.$store.getters.categories[1].name}}
              </router-link>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Menu
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <router-link class="dropdown-item" to="" @click="handleChangeCategory('')">Tất cả</router-link>
                <div v-for="(category) in this.$store.getters.categories" :key="category.code">
                  <router-link class="dropdown-item" to="" @click="handleChangeCategory(category.code)">{{category.name}}</router-link>
                </div>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Cửa hàng</a>
            </li>
          </ul>
          <!-- <div class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Tên sản phẩm" aria-label="Tên sản phẩm">
            <button class="btn btn-outline-success my-2 my-sm-0">Tìm kiếm</button>
          </div> -->
          <div>
            <div class="cart">
              <b-icon-cart class="b-icon b-cart"></b-icon-cart>
              <span class="quantity">{{ $store.getters.user != null ? $store.getters.carts?.length || 0 : 0}}</span>
              <cart-popup></cart-popup>
            </div>
          </div>
        </div>
      </nav>
    </div>
  </div>

</template>

<script>
import * as Constants from '../../../common/Constants';
import CategoryCommand from '../../../command/CategoryCommand';
import CartCommand from '../../../command/CartCommand';
import LoginCommand from '../../../command/LoginCommand';
import ProductCommand from '../../../command/ProductCommand'
import CartPopup from '../popup/CartPopup.vue'
import {BIconDownload, BIconTelephone, BIconBoxArrowInRight, BIconCart} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_HEADER_COMMON_USER,

  components: {
    BIconDownload,
    BIconTelephone, 
    BIconCart,
    BIconBoxArrowInRight,
    CartPopup
  },

  methods: {
    
    async init() {
      await Promise.all([
        this.loadCategories(),
        this.loadCarts(),
      ]);
    },

    async loadCategories() {
      await CategoryCommand.findAll(this.$store);
    },

    async handleChangeCategory(categoryCode) {
      // const query = Object.assign({}, this.$route.query);
      categoryCode = categoryCode || '';

      if (categoryCode != '') {
        this.$router.push({path: '/', query: {category: categoryCode}});
      } else {
        this.$router.push({path: '/'});
      }

      this.loadProducts(categoryCode);
    },

    async loadProducts(categoryCode) {
      await ProductCommand.findAllByOrder(1, Constants.PAGE_SIZE_MAX, '', categoryCode, '', this.$store);
    },

    async loadCarts() {
      if (this.$store.getters.user != null) {
        await CartCommand.findByCustomerId(this.$store.getters.user.id, this.$store);
      }
    },

    handleLogout() {
      let isLogout = LoginCommand.logout(this.$store);      
      isLogout ? this.$router.push({path: '/login'}) : '';
    },
  },

  created() {
    this.init();
  }
}
</script>

<style scoped>

li {
  list-style:none ;
}

.flex {
  display: flex;
}

.dropdown-menu.show {
  background-color: rgba(255, 255, 255, 1);
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

.header-meta {
  display: flex;
  margin: 0;
  padding: 8px 0;
  justify-content: space-between;
  touch-action: manipulation;
}

.header-meta .flex-left {
  display: flex;
  align-items: center;
}

.header-meta .flex-left .v-line{
  margin: 0px 4px;
}

.header-meta .item {
  display: flex;
  align-items: center;
  /* padding: 0 4.2%; */
}

.header-meta .item .b-icon {
  height: 100%;
  font-size: 17px;
  color: var(--primary);
  margin: 0px 4px;
}

.header-meta .item img {
  height: 20px;
  width: 20px;
  border-radius: 50%;
}

.header-meta .item span {
  /* height: 100%; */
  font-size: 13.5px;
  color: #555;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  margin: 0px 4px;
  letter-spacing: 0.3px;
  transition: all 0.3s ease-in-out;
}

.header-meta .item a {

  display: flex;
  align-items: center;
}


a {
  color: #555 ;
  transition: all 0.2s ease-in-out;
}


.header-meta .item span:hover{
  cursor: pointer;
  color: var(--primary);
}

a:hover{
  cursor: pointer;
  color: var(--primary);
}

.navbar-container {
  position: sticky;
  top: 0;
  left: 0;
  padding: 0px 0;
  width: 100%;
  background-color: rgba(255, 255, 255, 0.7);
  z-index: 999;
  border-bottom: 1px solid #00000026;
}

.navbar-container nav {
  background-color: rgba(255, 255, 255, 0.0) !important;
}

.navbar-container nav li.nav-item{
  padding: 0px 12px;
}

.navbar-container nav li.nav-item a{
  font-weight: bold;
  letter-spacing: .3px;
  color: #000;
  font-size: 14px;
}

.navbar-container nav li.nav-item a:hover{
  color: var(--primary);
}

.navbar-container nav li.nav-item a.dropdown-item{
  font-weight: 500;
  letter-spacing: .3px;
}

navbar {
  display: flex;
}

navbar nav.item {
  display: flex;
  align-items: center;
  font-weight: 600;
  padding: 0px 20px;
}

navbar nav.item a {
  font-weight: 600;
}

.header-logo {
  display: flex;
  height: 40px;
  padding-right: 40px;
}

.header-logo span {
  display: flex;
  color: #000;
  justify-content: center;
  align-items: center;
  font-family: "Sofia", sans-serif;
  font-weight: 600;
  font-size: 20px;
  letter-spacing: .3px;
}

input.form-control {
  padding: 4px 8px !important;
}

.btn-outline-success {
  padding: 4px 8px;
  white-space: nowrap;
  margin-left: 8px;
}
.mr-auto {
  margin-right: auto;
}
.form-inline {
  width: auto;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
  flex-wrap: wrap;
  /* -ms-flex-flow: row wrap;
  flex-flow: row wrap; */
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
}

.form-inline .form-control {
  width: auto;
}

.cart {
  position: relative;
}

.cart .b-cart{
  font-size: 30px;
  cursor: pointer;
}

.cart span.quantity {
  position: absolute;
  top: -4px;
  right: -10px;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: var(--primary);
  color: #fff;
  z-index: 2;
  border-radius: 10px;
  font-size: 13px;
  width: 26px;
  height: 18px;
  font-weight: 600;
}

@media (min-width: 992px){
      .header-meta > .item {
    padding: 0 4.2%;
  }
}

@media (min-width: 1400px){
  .container {
  max-width: 1200px;
  }
}
</style>