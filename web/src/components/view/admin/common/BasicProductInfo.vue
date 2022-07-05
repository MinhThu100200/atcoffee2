<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="dropdown dropdown-setting">
                <i class="fas fa-cog icon-absolute" @click="handleToggleSetting"></i>
                <div class="dropdown-menu dropdown-menu-right show" v-if="isSetting" v-click-outside="handleHideSetting">
                  <router-link to="" class="dropdown-item has-icon" @click="handleEdit">
                    <i class="fas fa-edit"></i>
                    Chỉnh sửa
                  </router-link>
                  <router-link to="" class="dropdown-item has-icon" @click="handleLock(product.state)">
                    <i class="fas fa-lock"></i>
                    {{product.state ? 'Ngừng bán' : 'Mở bán'}}
                  </router-link>
                </div>
              </div>
            <div class="col-9 col">
              <div class="official-info">
                <span class="title">Thông tin sản phẩm</span> 
                <div class="line">
                  <div class="info-group">
                    <label>Mã sản phẩm</label>
                    <span>{{product.code}}</span>
                  </div>
                  <div class="info-group flex-4">
                    <label>Tên sản phẩm</label>
                    <span>{{product.name}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Size S</label>
                    <span>{{product.sizes != null ? formatPrice(product.sizes[0].price) : '0'}}</span>
                  </div>
                  <div class="info-group">
                    <label>Size M</label>
                    <span>{{product.sizes != null ? formatPrice(product.sizes[1].price) : ''}}</span>
                  </div>
                  <div class="info-group">
                    <label>Size L</label>
                    <span>{{product.sizes != null ? formatPrice(product.sizes[2].price) : ''}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Mô tả sản phẩm</label>
                    <span>{{product.description}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Giảm giá sản phẩm</label>
                    <span>{{product.discount}}%</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label for="category">Loại</label>
                    <div class="form-group-horizontal" id="category">
                      <div class="chip"
                        v-for="category in product.categories" :key="category.code"
                        :class="category.selected ? 'selected' : ''">
                        <span>{{category.name}}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="line">
                <div class="info-group">
                  <label for="store">Cửa hàng áp dụng</label>
                  <div class="form-group-horizontal" id="store">
                    <div class="chip"
                      v-for="store in product.stores" :key="store.id"
                      :class="store.selected ? 'selected' : ''">
                      <span>{{store.address}}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-3 col-custom col-center info-basic">
              <img :src="product.image" alt="Hình ảnh">
            </div>
          </div>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import Spinner from '../../common/popup/Spinner.vue'
import CommonUtils from '../../../common/CommonUtils'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_BASIC_PRODUCT_INFO,

  props: ['product', 'type'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner
  },

  data() {
    return {
      stores: [],
      categories: [],
      isSpinner: false,
      isSetting: false,
      isEdit: false,
      count: 0,
    }
  },

  methods: {

    handleToggleSetting() {
      this.isSetting = !this.isSetting;
    },

    handleHideSetting() {
      this.isSetting = false;
    },

    handleEdit() {
      this.$router.push({path: '/admin/edit-product', query: {id: this.product.id}})
    },

    formatDate(date) {
      return CommonUtils.formatDate(date);
    },  

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleLock(isLock) {
      this.isSetting = false;
      this.$emit('handleLock', isLock);
    },
  },

  created() {
  },
}
</script>

<style scoped>

.col-center {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.info-basic {
  border-left: 0.5px solid #c2c2c2;
}

.col-custom img {
  width: 18vw;
  height: 18vw;
  border-radius: 10px;
  border: 2px solid #eaeaea;
  margin-left: 8px;
}

.col-custom .name {
  font-size: 20px;
  font-weight: 600;
  color: #626262;
  margin-top: 28px;
}

.col-custom .code {
  font-size: 14px;
  font-weight: 600;
  color: #626262;
  margin-top: 12px;
}

.col-custom .createdDate {
  color: #626262;
  font-size: 14px;
  margin-top: 20px;
}

.official-info {
  position: relative;
  padding: 10px 0;
  width: 100%;
}

.official-info .dropdown-setting {
  position: relative;
  right: 0;
}

.dropdown-setting .icon-absolute {
  position: absolute;
  right: 0;
  font-size: 16px;
  cursor: pointer;
  color: #212529;
  z-index: 9;
} 

.dropdown-setting .dropdown-menu {
  position: absolute;
  right: 0;
  left: auto;
  top: 20px;
  background: white;
  border: none;
  box-shadow: 0 5px 20px 0 rgba(51, 73, 94, 0.15);
}

.dropdown-menu a {
  font-size: 13px;
  text-decoration: none;
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

.dropdown-setting .dropdown-menu .dropdown-item{
  cursor: pointer;
}

.dropdown-setting .dropdown-menu .dropdown-item:hover{
  text-decoration: none;
}


.official-info .title {
  font-size: 16px;
  font-weight: 500;
  color: #707070;
  margin-left: 40px;
  padding: 5px 0;
}

.line {
  display: flex;
  flex-direction: row;
}

.line .info-group {

  display: flex;
  flex-direction: column;
  margin-left: 40px;
  width: 400px;
  padding: 10px 0;
}

.line .info-group:nth-child(1) {
  flex: 1;
}

.line .info-group:nth-child(2) {
  flex: 1;
}

.line .info-group:nth-child(3) {
  flex: 3;
}

.line .info-group label {
  font-size: 15px;
  font-weight: bold;
  color: #626262;
}

.line .info-group span {
  font-size: 14px;
  color: #707070;
  margin: 4px 0 0 0;
}

.line .line {
  flex: 3;
  margin-left: 40px;
}

.line .line .info-group{
  flex: 1;
  width: auto;
}

.line .line .info-group:nth-child(1){
  flex: 1;
  margin-left: 0px;
  width: auto;
}

input:focus {
  box-shadow: none;
  border: 1px solid var(--primary);
}

textarea:focus {
  box-shadow: none;
  border: 1px solid var(--primary);
}

form .form-group {
  margin-top: 10px;
}

.card .card-body {
  padding: 15px 25px;
}

.row {
  display: flex;
}

.row .col-8 {
  flex: 1;
}

.row .col-4 {
  min-width: 440px;
}

.form-group-horizontal {
  display: flex;
  overflow-x: auto;
  margin-top: 4px;
}

.form-group-horizontal .chip {
  display: inline-block;
  white-space: nowrap;
  height: 32px;
  min-inline-size: auto;
  padding: 5px 20px;
  border: 1px solid var(--primary);
  border-radius: 50px;
  margin-right: 10px;
  color: #212529;
  text-align: center;
}

.form-group-horizontal .chip span {
  color: #212529 !important;
  font-weight: 500;
}

.form-group-horizontal .chip:hover {
  background: var(--primary);
  color: #fff;
  cursor: pointer;
}

.form-group.horizontal {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-top: 0px;
}

.form-group.horizontal label{
  margin-right: 8px;
}


.form-group.horizontal input {
  flex: 1;
  margin-right: 8px;
}

.form-group.horizontal input[type="number"] {
  text-align: right;
}

input[type="number"] {
  text-align: right;
}

.info-basic img{
  object-fit: cover;
}

.alert.alert-danger {
  margin: 4px !important;
  transition: all .3s;
}

form .action {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.btn.btn-success {
  width: 200px;
  margin: 20px auto;
}

.invisible {
  display: none;
}

.flex-4 {
  flex: 4 !important;
}

#triangle-left {
  position: absolute;
  top: 0px;
  left: 0px;
	width: 0;
  height: 0;
  border-top-left-radius: .25rem;
  border-top: 80px solid #ccc;
  border-right: 80px solid transparent;
}

#triangle-left i {
  position: absolute;
  font-size: 20px;
  top: -68px;
  left: 15px;
  color: #333;
}

</style>