<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách phần thưởng</h4>
          <div class="card-header-form flex-row">
            <form @submit.prevent="handleSearch">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm" v-model="keyword">
                <div class="input-group-btn">
                  <button class="btn btn-primary"><i class="fas fa-search"></i></button>
                </div>
              </div>
            </form>
            <div class="empty-space"></div>
            <button class="btn btn-success btn-medium" @click.capture="handleAdd">Thêm</button>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã phần thưởng</th>
                  <th class="text-center">Tên phần thưởng</th>
                  <th class="text-center">Số điểm</th>
                  <th class="text-center">Mức giảm</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(reward, index) in this.$store.getters.rewards" :key="reward.id">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{reward.code}}</td>
                  <td class="text-center">{{reward.name}}</td>
                  <td class="text-center">{{reward.proviso}}</td>
                  <td class="text-center">{{formatPrice(reward.redution)}}</td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleInfo(reward.id)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortReward.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortReward.totalPage"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import RewardCommand from '../../../command/RewardCommand'
import Pagination from '../../common/common/Pagination.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_REWARDS,

  components: {
    Pagination
  },

  data() {
    return {
      rewards: [],
      currentPage: 1,
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
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_REWARD + index + 1;
    },

    handleInfo(id){
      this.$router.push({path: '/admin/reward-info', query: {id}});
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/rewards', query: {...query, page: this.currentPage}});
      this.loadRewardsBySort(this.currentPage, Constants.PAGE_SIZE_REWARD);
    },

    handleSearch(){
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/rewards', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadRewardsBySort(this.currentPage, Constants.PAGE_SIZE_REWARD);
    },

    handleAdd() {
      this.$emit('handleAdd');
    },

    async loadData() {
      await this.loadRewardsBySort(this.currentPage, Constants.PAGE_SIZE_REWARD);
    },

    async loadRewardsBySort(page, size) {
      var keyword = this.keyword;
      await RewardCommand.findByOrder(page, size, keyword, this.$store);
    },
    
  },

  created(){
    this.init();
    this.loadData();
  }
}
</script>

<style>

</style>