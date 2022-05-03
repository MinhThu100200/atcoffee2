<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách khuyến mãi</h4>
          <div class="card-header-form flex-row">
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="stateSelected" class="form-custom" @change="handleChangeState">
                <option value="ALL">Tất cả các trạng thái</option>
                <option value="active">Đang hoạt động</option>
                <option value="expired">Đã hết hạn</option>
                <option value="upcoming">Sắp tới</option>
              </select>
            </div>
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="objectSelected" class="form-custom" @change="handleChangeObject">
                <option value="ALL">Tất cả các đối tượng</option>
                <option v-for="type in $store.getters.types" :key="type.code" :value="type.code">{{type.name}}</option>
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
                  <th class="text-center">Mã</th>
                  <th class="text-center">Tên</th>
                  <th class="text-center">Đối tượng từ</th>
                  <th class="text-center">Mức giảm giá</th>
                  <th class="text-center">Ngày bắt đầu</th>
                  <th class="text-center">Ngày kết thúc</th>
                  <th class="text-center">Điều kiện</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(promotion, index) in this.$store.getters.promotions" :key="promotion.id">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{promotion.code}}</td>
                  <td class="text-center">{{promotion.name}}</td>
                  <td class="text-center">{{processObject(promotion.object)}}</td>
                  <td class="text-center">{{promotion.discount}}%</td>
                  <td class="text-center">{{formatDate(promotion.startDate)}}</td>
                  <td class="text-center">{{formatDate(promotion.endDate)}}</td>
                  <td class="text-center">{{formatPrice(promotion.proviso)}}</td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleInfo(promotion.id)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortPromotion.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortPromotion.totalPage"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import PromotionCommand from '../../../command/PromotionCommand'
import Pagination from '../../common/common/Pagination.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_PROMOTIONS,

  components: {
    Pagination
  },

  data() {
    return {
      promotions: [],
      currentPage: 1,
      stateSelected: 'ALL',
      objectSelected: '',
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
      this.stateSelected = this.$route.query.state;
      if (typeof this.stateSelected == 'undefined') {
        this.stateSelected = 'ALL';
      }
      this.objectSelected = this.$route.query.object;
      if (typeof this.objectSelected == 'undefined') {
        this.objectSelected = 'ALL';
      }
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_PROMOTION + index + 1;
    },

    formatDate(timeStamp) {
      return CommonUtils.formatDate(new Date(timeStamp));
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleInfo(id){
      this.$router.push({path: '/admin/promotion-info', query: {id}});
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/promotions', query: {...query, page: this.currentPage}});
      this.loadPromotionsBySort(this.currentPage, Constants.PAGE_SIZE_PROMOTION);
    },

     handleSearch(){
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/promotions', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadPromotionsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    },

    handleChangeState() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.stateSelected == 'ALL') {
        delete query.state;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/promotions', query: {...query, page: this.currentPage, state: this.stateSelected}});
      }
      this.currentPage = 1;
      this.loadPromotionsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    }, 

    handleChangeObject() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.objectSelected == 'ALL') {
        delete query.object;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/promotions', query: {...query, page: this.currentPage, object: this.stateSelected}});
      }
      this.currentPage = 1;
      this.loadPromotionsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    }, 

    handleAdd() {
      this.$emit('handleAdd');
    },

    processObject(object) {
      var type = this.$store.getters.types.find(item => item.code == object);
      return type.name;
    },

    async loadData() {
      await this.loadPromotionsBySort(this.currentPage, Constants.PAGE_SIZE_PROMOTION);
    },

    async loadPromotionsBySort(page, size) {
      var state = this.stateSelected == 'ALL' ? '' : this.stateSelected;
      var object = this.objectSelected == 'ALL' ? '' : this.objectSelected;
      var keyword = this.keyword;
      this.users = await PromotionCommand.findAllByOrder(page, size, state, object, keyword, this.$store);
    },
  
  },

  created(){
    this.init();
    this.loadData();
  }
}
</script>

<style>

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
  border: none !important;
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
  --bs-table-accent-bg: rgba(0, 0, 0, 0.03);
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

.fas.fa-circle {
  font-size: 16px;
}

.fa-circle.active {
  color: #5ad539;
}

.fa-circle.inactive {
  color: #ccc;
}

.btn.btn-success.btn-medium {
  width: 100px;
}

</style>