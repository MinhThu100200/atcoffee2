<template>
  <div>
    <div class="col"  v-for="(line_products, index) in lines_products" :key="index">
      <div class="title-products">{{this.categories[index].name}}</div>
      <div class="row">
        <product-item v-for="product in line_products" :key="product.id" :product="product"/>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import ProductCommand from '../../../command/ProductCommand'
import StoreCommand from '../../../command/StoreCommand'
import CategoryCommand from '../../../command/CategoryCommand'
import ProductItem from './ProductItem.vue'

export default {
  name: Constants.COMPONENT_NAME_PRODUCTS_ITEM,

  components: {
    ProductItem
  },

  data() {
    return {
      lines_products: [],
      products: [],
      category: {},
      categories: [],
      stroe: {},
      value: {
        countProducts: 0
      }
    }
  },

  methods: {

    async init() {
      var categoryId = this.$route.query.id;
      if (typeof categoryId == 'undefined') {
        categoryId = 1;
      }
      await this.loadCategoryById(categoryId);
      await this.countProductsByCategoryCode(this.category.code);
    },

    async loadData() {
      await this.loadStore(this.$store.getters.user.storeId);
      await this.loadCategories();
      await this.loadProducts();
      this.processLinesProducts();
    },

    processLinesProducts() {
      this.lines_products = [];
      var categories = [];
      for (var index = 0; index < this.categories.length; index++) {
        var line_products = this.products.filter(item => {
          for (var j = 0; j < item.categories.length; j++) {
            if (item.categories[j].id == this.categories[index].id) {
              return true;
            }
          }
          return false;
        })
        if (line_products.length > 0) {
          this.lines_products.push(line_products);
          categories.push(this.categories[index]);
        }
      }
      this.categories = categories;
    },

    async loadCategoryById(id) {
      this.category = await CategoryCommand.findOne(id);
    },

    async countProductsByCategoryCode(categoryCode) {
      let result = await ProductCommand.countByCategoryCode(categoryCode);
      this.value.countProducts = result;
      return result;
    },

    async loadStore(id) {
      this.store = await StoreCommand.findOne(id);
    },

    async loadProducts() {
      this.products = await ProductCommand.findAllByOrder(1, 10000, this.store.code, '', '');
    },

    async loadCategories() {
      this.categories = await CategoryCommand.findAll();
    },
  },

  created() {
    // this.init();
    this.loadData();
  }
}
</script>

<style>
.title-products {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 8px;
  color: #5c5c5c;
}
</style>