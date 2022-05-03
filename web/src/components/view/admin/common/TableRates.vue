<template>
  <div class="row" v-if="$route.path.includes('/admin/rates') || (!$route.path.includes('/admin/rates') && $store.getters.rates?.length > 0)">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách đánh giá</h4>
          <div class="card-header-form flex-row">
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã đánh giá</th>
                  <th class="text-center" v-if="$route.path.includes('/admin/rates')">Tên sản phẩm</th>
                  <th class="text-center" v-if="$route.path.includes('/admin/rates')">Ảnh sản phẩm</th>
                  <th class="text-center">Khách hàng</th>
                  <th class="text-center">Số sao</th>
                  <th class="text-center">Nội dung</th>
                  <th class="text-center">Thời gian</th>
                </tr>
                <tr v-for="(rate, index) in $store.getters.rates" :key="rate.id">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{rate.code}}</td>
                  <td class="text-center" v-if="$route.path.includes('/admin/rates')">
                    {{products?.find(item => item.id == rate.productId)?.name }}
                  </td>
                  <td class="text-center" v-if="$route.path.includes('/admin/rates')">
                    <img :src="products?.find(item => item.id == rate.productId)?.image"/>
                  </td>
                  <td class="text-center">{{customers?.find(item => item.id == rate.userId).name}}</td>
                  <td class="text-center">{{rate.star}}</td>
                  <td class="text-center">{{rate.comment}}</td>
                  <td class="text-center">{{formatDateTime(new Date(rate.modifiedDate))}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortRate.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortRate.totalPage"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import RateCommand from '../../../command/RateCommand'
import ProductCommand from '../../../command/ProductCommand'
import UserCommand from '../../../command/UserCommand'
import Pagination from '../../common/common/Pagination.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_RATES,

  components: {
    Pagination
  },

  data() {
    return {
      rates: [],
      products: [],
      customers: [],
      currentPage: 1
    }
  },

  methods: {

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_RATE + index + 1;
    },

    formatDateTime(date) {
      return CommonUtils.formatDateTime(date);
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/rates', query: {...query, page: this.currentPage}});
      this.loadRateBySort(this.currentPage, Constants.PAGE_SIZE_RATE);
    },

    async loadData() {
      await this.loadProducts();
      await this.loadCustomers();
      await this.loadRateBySort(this.currentPage, Constants.PAGE_SIZE_RATE);
    },

    async loadRateBySort(page, size) {
      if (this.$route.path.includes('/admin/rates')) {
        await RateCommand.findAll(page, size, this.$store);
      } else {
        var productId = this.$route.query.id;
        await RateCommand.findByProductId(page, size, productId, this.$store);
      }
    },

    async loadProducts() {
      this.products = await ProductCommand.findAllIgnore();
    },

    async loadCustomers() {
      this.customers = await UserCommand.findAll();
    }
    
  },

  created(){
    this.init();
    this.loadData();
    this.$store.commit(MutationsName.MUTATION_NAME_SET_RATES, []);
  }
}
</script>

<style>

</style>