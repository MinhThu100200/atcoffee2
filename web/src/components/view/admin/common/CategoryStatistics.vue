<template>
  <div class="row">
      <item-statistics :value="value.countProducts">Tổng sản phẩm</item-statistics>
      <item-statistics>Tổng sản phẩm</item-statistics>
      <item-statistics>Tổng sản phẩm</item-statistics>
      <item-statistics>Tổng sản phẩm</item-statistics>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import ProductCommand from '../../../command/ProductCommand'
import CategoryCommand from '../../../command/CategoryCommand'
import ItemStatistics from '../../common/common/ItemStatistics.vue'

export default {
  name: Constants.COMPONENT_NAME_CATEGORY_STATISTICS,

  components: {
    ItemStatistics
  },

  data() {
    return {
      category: {},
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

    async loadCategoryById(id) {
      this.category = await CategoryCommand.findOne(id);
    },

    async countProductsByCategoryCode(categoryCode) {
      let result = await ProductCommand.countByCategoryCode(categoryCode);
      this.value.countProducts = result;
      return result;
    }
  },

  created() {
    this.init();
  }
}
</script>

<style>

</style>