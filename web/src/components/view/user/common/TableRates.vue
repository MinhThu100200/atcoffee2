<template>
  <div>
    <div class="card">
        <div class="card-header">
          <h4>Đánh giá sản phẩm</h4>
        </div>
        <div v-if="this.$store.getters.sortRate.totalPage != 0" class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
               
                <tr v-for="(rate) in $store.getters.rates" :key="rate.code">
                  <td class="text-center">{{rate.id}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="table-responsive text-center no-record" v-if="this.$store.getters.sortRate.totalPage == 0">
          <span>Chưa có đánh giá</span>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortRate.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortRate.totalPage"/>
        </div>
      </div>
  </div>
</template>

<script>

import * as Constants from '../../../common/Constants'
import RateCommand from '../../../command/RateCommand'
import Pagination from '../../common/common/Pagination.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_RATES_USER,

  props: ['product'],

  components: {
    Pagination
  },

  data() {
    return {
      currentPage: 1,
    }
  },

  method: {
    handleChangePage(page) {
      this.currentPage = page;
      this.loadRates(this.product.id);
    },

    async loadRates(productId) {
      RateCommand.findByProductIdByUser(1, Constants.PAGE_SIZE_RATE, productId, this.$store);
    }
  }
}
</script>

<style scoped>
.no-record {
  padding: 12px 0px;
}
</style>