<template>
  <user>
    <section-header>
      <div class="breadcrumb-item active">
        <router-link to="/">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="" @click="handleChangeCategory(category.code)">{{category.name}}</router-link>
      </div>
      <div class="breadcrumb-item">
        {{product.name}}
      </div>
    </section-header>
    <product-detail @toggleFavourite="toggleFavourite" :product="product"/>
    <div class="container">
      <hr class="col-md-12"/>
    </div>
    <rate :product="product"></rate>
  </user>
</template>

<script>
import * as Constants from '../../../common/Constants'

import User from '../main/User.vue'
import ProductCommand from '../../../command/ProductCommand'
import CategoryCommand from '../../../command/CategoryCommand'
import ProductDetail from '../common/ProductDetail.vue'
import SectionHeader from '../common/SectionHeader.vue'
import Rate from '../rate/Rate.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCT_USER,

  components: {
    User,
    ProductDetail,
    SectionHeader,
    Rate
  },

  data() {
    return {
      product: {
        id: 0,
        categories: []
      },
      category: {
        name: '',
        code: ''
      },
    }
  },

  methods: {
    async init(){
      this.product.id = this.$route.query.id;
      if (typeof this.product.id == 'undefined') {
        this.id = 0;
      }

      await this.loadProduct(this.product.id);
      await this.loadCategories();
      this.handleCategory();
    },

    async loadProduct(id) {
      this.product = await ProductCommand.findOne(id);
    },

    async loadCategories() {
      if (!this.$store.getters.categories) {
        await CategoryCommand.findAll(this.$store);
      }
    },

    handleCategory() {
      var cat = null;
      for (var category of this.product.categories) {
        cat = this.$store.getters.categories.find(c => c.id == category.id);
        if (cat) {
          this.category = cat;
          break;
        }
      }
    },

    async handleChangeCategory(categoryCode) {
      // const query = Object.assign({}, this.$route.query);
      categoryCode = categoryCode || '';
      
      if (categoryCode != '') {
        this.$router.push({path: '/', query: {category: categoryCode}});
      } else {
        this.$router.push({path: '/'});
      }

      await this.loadProducts(categoryCode);
    },

    async loadProducts(categoryCode) {
      await ProductCommand.findAllByOrder(1, Constants.PAGE_SIZE_MAX, '', categoryCode, '', this.$store);
    },

    toggleFavourite() {
      this.product.favourited = !this.product.favourited;
      if (this.product.favourited) {
        this.product.numberFavourites += 1;
      } else {
        this.product.numberFavourites -= 1;
      }
    }
  },

  created() {
    this.init();
  }
}
</script>

<style scoped>
@media (min-width: 1400px){
  .container {
  max-width: 1200px;
  }
}
</style>