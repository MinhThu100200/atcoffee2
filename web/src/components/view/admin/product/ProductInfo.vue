<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Sản phẩm</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link :to="linkBackProducts">Danh sách sản phẩm</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin sản phẩm
        </div>
      </section-header>
      <div class="section-body">
        <basic-product-info :product="product" :type="type" @handleEdit="handleEdit" v-if="!isEdit" @handleLock="handleLock"></basic-product-info>
        <table-rates></table-rates>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import ProductCommand from '../../../command/ProductCommand'
import TableRates from '../common/TableRates.vue'
import BasicProductInfo from '../common/BasicProductInfo.vue'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_INFO,

  components: {
    Admin,
    SectionHeader,
    BasicProductInfo,
    TableRates
  },

  data() {
    return {
      title: 'Thông tin sản phẩm',
      product: {},
      type: 'info',
      productId: 0,
      isEdit: false
    }
  },

  computed: {
    linkBackProducts() {
      var sortProduct = this.$store.getters.sortProduct;
      var urlStore = '', urlCategory = '', urlKeyword = '';
      if (sortProduct.store != '') {
        urlStore += '&store=' + sortProduct.store;
      }
      if (sortProduct.category != '') {
        urlCategory += '&category=' + sortProduct.category;
      }
      if (sortProduct.keyword != '') {
        urlKeyword += '&keyword=' + sortProduct.keyword;
      }
      return `/admin/products?page=${this.$store.getters.sortProduct.page + urlStore + urlCategory + urlKeyword}`;
    }
  },

  methods: {

    toast(description, type) {

      var color = type == 'success' ? '#40b883' : '#e76666';
      createToast( {description: description},
        {
          showIcon: 'true',
          hideProgressBar: 'true',
          position: 'top-right',
          toastBackgroundColor: color,
          timeout: 2000,
          type: type,
        })
    },

    init() {
      this.productId = this.$route.query.id;
      if (typeof this.productId == 'undefined') {
        this.productId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async handleDone() {
      this.isEdit = false;
      await this.getProductById(this.productId);
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getProductById(this.productId);
    },

    async getProductById(id) {
      this.product = await ProductCommand.findOne(id);
      this.product.categories = this.product.categories.filter(item => item.state);
      this.product.stores = this.product.stores.filter(item => item.state);
    },

    async handleLock(isLock) {
      let action = isLock ? 'Ngừng bán' : 'Mở bán';
      let result = await ProductCommand.findOne(this.productId);
      result['state'] = !isLock;
      let res = await ProductCommand.updateState(result);
      var text = '', type = 'success';
      if (res != null) {
        let query = {};
        query.page = this.$store.getters.sortProduct.page;
        if (this.$store.getters.sortProduct.store != '') {
          query.store = this.$store.getters.sortProduct.store;
        }
        if (this.$store.getters.sortProduct.category != '') {
          query.category = this.$store.getters.sortProduct.category;
        }
        if (this.$store.getters.sortProduct.keyword != '') {
          query.keyword = this.$store.getters.sortProduct.keyword;
        }
        text = action + ' sản phẩm thành công';
        this.$router.push({path: '/admin/products', query: query});
      } else {
        text = action + ' sản phẩm Loại bỏ sản phẩm thành công';
        type = 'danger';
      }
      this.toast(text, type);
    },

  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.product.value = true;
    this.$store.getters.menu.product.submenu.products = true;
    this.init();
    this.getProductById(this.productId);
  }
}
</script>

<style>

</style>