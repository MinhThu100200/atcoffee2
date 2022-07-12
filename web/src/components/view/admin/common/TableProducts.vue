<template>
  <div class="row">
    <div class="col-12" v-if="this.$store.getters.products && this.$store.getters.categories">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách sản phẩm</h4>
          <div class="card-header-form flex-row">
            <!-- <div class="form-group">
              <select v-model="storeSelected" class="form-custom" @change="handleChangeStore">
                <option value="ALL">Tất cả các cửa hàng</option>
                <option v-for="store in this.$store.getters.stores" :key="store.id"
                  :value="store.code">
                  {{store.address}}
                </option>
              </select>
            </div> -->
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="categorySelected" class="form-custom" @change="handleChangeCategory">
                <option value="ALL">Tất cả các loại</option>
                <option v-for="category in this.$store.getters.categories" :key="category.id"
                  :value="category.code">
                  {{category.name}}
                </option>
              </select>
            </div>
            <div class="empty-space"></div>
            <form @submit.prevent="handleSearch">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm" v-model="keyword">
                <div class="input-group-btn">
                  <button class="btn btn-primary"><i class="fas fa-search"></i></button>
                </div>
              </div>
            </form>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã</th>
                  <th class="text-center">Tên sản phẩm</th>
                  <th class="text-center">Hình ảnh</th>
                  <th class="text-center">Giá sản phẩm</th>
                  <th class="text-center">Lượt thích</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(product, index) in products" :key="product.id">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{product.code}}</td>
                  <td class="text-center">{{product.name}}</td>
                  <td class="text-center">
                    <img :src="product.image" alt="Ảnh" @click="handleViewImage(product.image)">
                  </td>
                  <td class="text-center">{{formatPrice(product.sizes[1].price)}}</td>
                  <td class="text-center flex-center">{{product.numberFavourites}} <b-icon-heart-fill class="b-icon b-heart-fill active"/></td>
                  <td class="text-center">
                    <i class="fas fa-circle" :class="product.state ? 'active' : 'inactive'"></i>
                  </td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleInfo(product.id)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.totalPageProduct > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortProduct.totalPage"/>
        </div>
      </div>
    </div>
    <view-image :isViewImage="isViewImage" :image="imageSelected" @handleHide="handleHideViewImage"></view-image>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import ProductCommand from '../../../command/ProductCommand'
import CategoryCommand from '../../../command/CategoryCommand'
import StoreCommand from '../../../command/StoreCommand'
import Pagination from '../../common/common/Pagination.vue'
import ViewImage from '../../common/popup/ViewImage.vue'
import {BIconHeartFill} from 'bootstrap-icons-vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_PRODUCTS,

  components: {
    Pagination,
    ViewImage,
    BIconHeartFill
  },

  data() {
    return {
      products: [],
      currentPage: 1,
      isViewImage: false,
      imageSelected: '',
      storeSelected: 'ALL',
      categorySelected: 'ALL',
      keyword: ''
    }
  },

  methods: {

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.keyword == 'undefined') {
        this.keyword = '';
      }
      this.storeSelected = this.$route.query.store;
      if (typeof this.storeSelected == 'undefined') {
        this.storeSelected = 'ALL';
      }
      this.categorySelected = this.$route.query.category;
      if (typeof this.categorySelected == 'undefined') {
        this.categorySelected = 'ALL';
      }
    },
    
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_PRODUCT + index + 1;
    },

    handleInfo(id){
      this.$router.push({path: '/admin/product-info', query: {id}});
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/products', query: {...query, page: this.currentPage}});
      this.loadProductsBySort(this.currentPage, Constants.PAGE_SIZE_PRODUCT);
    },

    handleViewImage(image) {
      this.isViewImage = true;
      this.imageSelected = image;
    },

    handleHideViewImage(){
      this.isViewImage = false;
    },

    handleSearch(){
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/products', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadProductsBySort(this.currentPage, Constants.PAGE_SIZE_PRODUCT);
    },

    handleChangeStore() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.storeSelected == 'ALL') {
        delete query.store;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/products', query: {...query, page: this.currentPage, store: this.storeSelected}});
      }
      this.currentPage = 1;
      this.loadProductsBySort(this.currentPage, Constants.PAGE_SIZE_PRODUCT);
    }, 

    handleChangeCategory() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.categorySelected == 'ALL') {
        delete query.category;
         this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/products', query: {...query, page: this.currentPage, category: this.categorySelected}});
      }
      this.currentPage = 1;
      this.loadProductsBySort(this.currentPage, Constants.PAGE_SIZE_PRODUCT);
    },  

    async loadData() {
      await this.loadCategories();
      await this.loadStores();
    },

    async loadProductsBySort(page, size) {
      var store = this.storeSelected == 'ALL' ? '' : this.storeSelected;
      var category = this.categorySelected == 'ALL' ? '' : this.categorySelected;
      var keyword = this.keyword;
      this.products = await ProductCommand.findAllByOrderIgnore(page, size, store, category, keyword, this.$store);
    },

    async loadCategories() {
      let result = await CategoryCommand.findAll(this.$store);
      this.categories = result.map(category => {
        category.selected = false;
        return category;
      });
      return this.categories;
    },
    
    async loadStores() {
      let result = await StoreCommand.findAll(this.$store);
      this.stores = result.map(store => {
        store.selected = false;
        return store;
      });
      this.stores.unshift({id: 0, address: 'Tất cả', selected: false});
      return this.stores;
    },
  },

  created(){
    this.init();
    this.loadData();
    this.loadProductsBySort(this.currentPage, Constants.PAGE_SIZE_PRODUCT);
  }
}
</script>

<style>

.flex-center {
  display: flex;
  justify-content: center;
  align-items: center;
}

.b-icon.b-heart-fill {
  font-size: 16px;
  margin: 0 4px;
}

.b-icon.b-heart-fill.active {
	color: #f55951;
}

.row {
  display: flex;
  flex-wrap: wrap;
  margin-right: -15px;
  margin-left: -15px;
}

.card {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
  background-color: #fff;
  border-radius: 3px;
  border: none;
  position: relative;
  margin-bottom: 30px;
}

.card .card-header {
  border-bottom-color: #f9f9f9;
  line-height: 30px;
  align-self: center;
  width: 100%;
  min-height: 70px;
  padding: 15px 25px;
  display: flex;
  align-items: center;
  background: transparent;
}

.card .card-header h4 {
  font-size: 16px;
  line-height: 28px;
  color: var(--primary);
  padding-right: 10px;
  margin-bottom: 0;
  font-weight: 700;
  margin-top: 0;
  border-radius: 30px 0 0 30px !important;
}

.card .card-header .card-header-form {
  margin-left: auto;
}

.input-group {
  position: relative;
  display: flex;
  flex-wrap: wrap;
  align-items: stretch;
  width: 100%;
}

.card .card-header .card-header-form .input-group .form-control {
  border-radius: 30px 0 0 30px !important;
}

.card .card-header .form-control {
  height: 31px;
  font-size: 13px;
}

.form-control:not(.form-control-sm):not(.form-control-lg) {
  padding: 10px 15px;
}

.input-group .form-control {
  position: relative;
  flex: 1 1 auto;
  width: 1%;
  margin-bottom: 0;
}

.input-group .form-control:focus {
  border-radius: 1px;
  box-shadow: none;
  border-color: var(--primary);
}

.form-control { 
  background: #fdfdfd;
  border-color: #e4e6fc;
  display: block;
  font-weight: 400;
  line-height: 1.5;
  color: #495057;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

input {
  overflow: visible;
}

.input-group .btn {
  border-radius: 0 30px 30px 0 !important;
  font-weight: 600;
  line-height: 25px;
  letter-spacing: .5px;
  margin-top: -1px;
  padding: 2px 15px;
}

.card-header-form .btn {
  padding-left: 13px !important;
  padding-right: 13px !important;
}

.btn-primary {
  background: #7EBDA2 !important;
  box-shadow: 0 2px 6px var(--lightGreen2) !important;
  border-color: #7EBDA2 !important;
  color: #fff;
}


.btn-primary:hover{
  background-color: var(--primary) !important;
  box-shadow: 0 2px 6px var(--lightGreen2) !important;
  border-color: var(--primary) !important;
}

.card .card-body {
  background: transparent;
}

.table-reponsive {
  display: block;
  width: 100%;
}

.table {
  width: 100%;
  color: inherit;
  margin-bottom: 1rem;
}

.table tr td img {
  height: 44px;
  width: 44px;
  border-radius: 3px;
  cursor: pointer;
}

table {
  border-collapse:collapse;
}

.table-striped tbody tr:nth-of-type(2n+1) {
  --bs-table-accent-bg: rgba(0, 0, 0, 0.03) !important;
}

.table td, .table:not(.table-bordered) th {
  border-top: none;
}

.table:not(.table-sm):not(.table-md):not(.dataTable) td, .table:not(.table-sm):not(.table-md):not(.dataTable) th {
  padding: 0 25px;
  height: 60px;
  vertical-align: middle;
}

th {
  text-align: center;
}

th, tr, td {
  border: 1px solid #f6f6f6;
}

.card .card-footer {
  background: transparent;
  border: none;
  padding: 20px 25px;
  width: 100%;
  text-align: right;
}

ul {
  margin-top: 0;
}

ul:not(.list-unstyled) {
  line-height: 28px;
}

.flex-row {
  display: flex;
  flex-direction: row !important;
  flex-wrap: wrap;
}

select.form-custom {
  height: 32px;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 2px 15px;
  font-size: 13px;
}

select.form-custom option {
  height: 32px;
  padding: 4px 15px;
}

.empty-space {
  width: 20px;
}

.btn.btn-secondary {
  box-shadow: 0 2px 6px #e1e5e8;
  background-color: #cdd3d8;
  border-color: #cdd3d8;
  color: #fff;
}
</style>