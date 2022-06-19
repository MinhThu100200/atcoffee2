<template>
  <div class="container">
    <div class="row">
      <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <header class="header-meta">
          <div class="item"><b-icon-geo-alt class="b-icon"/><span>2 Cửa hàng tại TP.HCM</span></div>
          <div class="item"><b-icon-telephone class="b-icon"/><span>Đặt hàng:&nbsp;<a href="tel:0388.888.888"> 0388.888.888</a></span></div>
          <div class="item"><b-icon-bicycle class="b-icon"/><span>Giao hàng phạm vi 5km</span></div>
        </header>
      </div>
    </div>
  </div>
  <div class="navbar-container">
    <div class="container">
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand header-logo" href="/">
          <span>A&amp;T COFFEE</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="#">Cà phê</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Trà sữa</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Menu
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Tất cả</a>
                <div v-for="(category) in this.$store.getters.categories" :key="category.code">
                  <a class="dropdown-item" href="#">{{category.name}}</a>
                </div>
              </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Cửa hàng</a>
            </li>
          </ul>
          <div class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Tên sản phẩm" aria-label="Tên sản phẩm">
            <button class="btn btn-outline-success my-2 my-sm-0">Tìm kiếm</button>
          </div>
        </div>
      </nav>
    </div>
  </div>

</template>

<script>
import * as Constants from '../../../common/Constants';
import CategoryCommand from '../../../command/CategoryCommand';
import {BIconGeoAlt, BIconTelephone, BIconBicycle} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_HEADER_COMMON_USER,

  components: {
    BIconGeoAlt,
    BIconTelephone, 
    BIconBicycle
  },

  methods: {
    
    async loadCategories() {
      await CategoryCommand.findAll(this.$store);
    }

  },

  created() {
    this.loadCategories();
  }
}
</script>

<style scoped>

/* @import url('https://fonts.googleapis.com/css2?family=Sofia:wght@300&display=swap'); */

.dropdown-menu.show {
  background-color: rgba(255, 255, 255, 0.7);
}

.header-meta {
  display: flex;
  margin: 0;
  padding: 8px 0;
  justify-content: center;
  touch-action: manipulation;
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
}

@media (min-width: 992px){
      .header-meta > .item {
    padding: 0 4.2%;
  }
}
 
</style>