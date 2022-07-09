<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách đơn hàng</h4>
          <div class="card-header-form flex-row">
            <div class="form-group flex-row width-auto">
              <div class="form-group flex-row flex-1 order-statistics">
                <input type="radio" name="time" v-model="type" value="null" @change="handleChangeType(null)">
                <label>Tất cả</label>
              </div>
              <div class="form-group flex-row flex-1 order-statistics">
                <input type="radio" name="time" v-model="type" value="month" @change="handleChangeType('month')">
                <label>Tháng</label>
              </div>
              <div class="form-group flex-row flex-1 order-statistics">
                <input type="radio" name="time" v-model="type" value="week" @change="handleChangeType('week')">
                <label>Tuần</label>
              </div>
            </div>
            <div class="empty-space"></div>
            <div class="form-group">
              <input type="date" class="form-control" v-model="selectedDate" @change="handleChangeSelectedDate"> 
            </div>
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="storeId" class="form-custom" @change="handleChangeStore">
                <option value="-1">Tất cả các cửa hàng</option>
                <option v-for="store in stores" :key="store.id"
                  :value="store.id">
                  {{store.address}}
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
            <div class="empty-space"></div>
            <export-excel
              class   = "btn btn-outline-success"
              :data   = "json_data"
              :fields = "json_fields"
              worksheet = "Thống kê đơn hàng"
              :name    = "filename">
              Export
            </export-excel>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã</th>
                  <th class="text-center">Tên khách hàng</th>
                  <th class="text-center">Tên nhân viên</th>
                  <th class="text-center">Tổng tiền</th>
                  <th class="text-center">Số tiền giảm</th>
                  <th class="text-center">Thành tiền</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Ngày hoàn thành</th>
                  <th class="text-center">Cửa hàng</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(bill, index) in $store.getters.billsLocal" :key="bill.code">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{bill.code}}</td>
                  <td class="text-center">{{processName(bill.customerId)}}</td>
                  <td class="text-center">{{processName(bill.staffId)}}</td>
                  <td class="text-center">{{formatPrice(bill.price)}}</td>
                  <td class="text-center">{{formatPrice(bill.discount)}}</td>
                  <td class="text-center">{{formatPrice(bill.amount)}}</td>
                  <td class="text-center" :class="colorStatus(bill.status)">
                    <div class="order">
                      <i class="fas fa-circle"></i> {{viStatus(bill.status)}}
                    </div>
                  </td>
                  <td class="text-center">{{formatDateTime(new Date(bill.modifiedDate))}}</td>
                  <td class="text-center">{{processAddressStore(bill.storeId)}}</td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleOrderInfo(bill.code)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortBill.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortBill.totalPage"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import BillCommand from '../../../command/BillCommand'
import StoreCommand from '../../../command/StoreCommand'
import UserCommand from '../../../command/UserCommand'
import Pagination from '../../common/common/Pagination.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_ORDER_STATISTICS,

  components: {
    Pagination,
  },

  data() {
    return {
      currentPage: 1,
      status: Constants.STATUS_BILL.COMPLETED,
      storeId: -1,
      keyword: '',
      stores: [],
      users: [],
      type: 'all',
      selectedDate: '',
      json_fields: {
        'SST': 'index', 
        'Mã': 'code',
        'Tên khách hàng': 'customerName',
        'Tên nhân viên': 'staffName',
        'Tổng tiền': 'price',
        'Số tiền giảm': 'discount',
        'Thành tiền': 'amount',
        'Trạng thái': 'status',
        'Ngày hoàn thành': 'modifiedDate',
        'Cửa hàng': 'store'
      },
      json_data: [],
      filename: 'filename.xlsx'
    }
  },

  computed: {

    size() {
      return Constants.PAGE_SIZE_ORDER;
    },

    
  },

  methods: {

    async init(){
      await this.loadUsers();
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.keyword == 'undefined') {
        this.keyword = '';
      }
      this.storeId = this.$route.query.storeId;
      if (typeof this.storeId == 'undefined') {
        this.storeId = -1;
      }
      this.type = this.$route.query.t;
      if (typeof this.type == 'undefined') {
        this.type = null;
      }
      this.selectedDate = this.$route.query.d;
      if (typeof this.selectedDate == 'undefined') {
        this.loadDate();
      }
      await this.loadStores();
      await this.loadBills();
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_ORDER + index + 1;
    },
    
    colorStatus(status) {
      return status.toLowerCase();
    },

    viStatus(status) {
      return Constants.STATUS_BILL_VI[status];
    },

    processAddressStore(storeId) {
      var store = this.stores.find(item => item.id == storeId);
      return store != null ? store.address : '';
    },

    processName(userId) {
      var user = this.users.find(item => item.id == userId);
      if (user == null || user.id == 1) {
        return 'Không có';
      }
      return user.name;
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/statistics/orders', query: {...query, page: this.currentPage}});
      this.loadBills();
    },

    formatDateTime(date) {
      return CommonUtils.formatDateTime(date);
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleOrderInfo(billCode) {
      this.$router.push({path: '/admin/statistics/order-info', query: {code: billCode}});
    },

    handleSearch() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/statistics/orders', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadBills();
    },

    handleChangeType(type) {
      this.type = type;
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.type == null) {
        delete query.t;
        delete query.d;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/statistics/orders', query: {...query, page: this.currentPage, t: this.type, d: this.selectedDate}});
      }
      let sortBill = this.$store.getters.sortBill;
      sortBill.type = this.type;
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_BILL, sortBill);
      this.loadBills();
      this.$emit('handleChangeType', this.type);
    },

    handleChangeSelectedDate() {

      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.type == null) {
        delete query.d;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/statistics/orders', query: {...query, page: this.currentPage, d: this.selectedDate}});
      }
      let sortBill = this.$store.getters.sortBill;
      sortBill.selectedDate = this.selectedDate;
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_BILL, sortBill);
      this.loadBills();
      this.$emit('handleChangeSelectedDate', this.selectedDate);
    },

    handleChangeStore() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.storeId == -1) {
        delete query.storeId;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/statistics/orders', query: {...query, page: this.currentPage, storeId: this.storeId}});
      }
      this.loadBills();
      this.$emit('handleChangeStore', this.storeId);
    },

    loadDate() {
      this.selectedDate = CommonUtils.formatDateReverse(new Date());
      let sortBill = this.$store.getters.sortBill;
      sortBill.selectedDate = this.selectedDate;
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_BILL, sortBill);
    },

    async loadBills() {
      let storeId = this.storeId > 0 ? this.storeId : null;
      let start = null, end = null;
      if (this.type == 'week') {
        var items = this.selectedDate.split('-');
        let selectedDate = new Date(parseInt(items[0]), parseInt(items[1]) - 1, parseInt(items[2]));
        let dateOfWeek = selectedDate.getDay();
        let startDate = selectedDate.setDate(selectedDate.getDate() - dateOfWeek);
        let endDate = selectedDate.setDate(selectedDate.getDate() + 6);
        start = CommonUtils.formatDateReverse(new Date(startDate));
        end = CommonUtils.formatDateReverse(new Date(endDate));
      } else if (this.type == 'month') {
        let month = new Date(this.selectedDate).getMonth() + 1;
        let year = new Date(this.selectedDate).getFullYear();
        start = `${year}-${('0' + month).slice(-2)}-01`;
        let endDate = new Date(year, month, 0);
        end = CommonUtils.formatDateReverse(endDate);
      }
      await BillCommand.findByOrder(start, end, storeId, this.keyword, Constants.STATUS_BILL.COMPLETED, this.currentPage, Constants.PAGE_SIZE_ORDER_STATISTICS, this.$store);
      let bills = await BillCommand.findByOrder(start, end, storeId, this.keyword, Constants.STATUS_BILL.COMPLETED, 1, Constants.PAGE_SIZE_MAX);
      this.processExport(bills);
    },

    processExport(bills) {
      var self = this;
      var billsFormat = bills.map((bill, index) => {

        bill.index = index + 1;
        bill.customerName = self.processName(bill.customerId);
        bill.staffName = self.processName(bill.staffId);
        bill.status = self.viStatus(bill.status);
        bill.modifiedDate = self.formatDateTime(new Date(bill.modifiedDate));
        bill.store = self.processAddressStore(bill.storeId);
        return bill;
      });
      this.json_data = billsFormat;
      this.filename = 'Thống kê đơn hàng ' + new Date().getTime() + '.xls';  
    },

    async loadStores() {
      this.stores = await StoreCommand.findAll();
    }, 

    async loadUsers() {
      this.users = await UserCommand.findAll();
    }
  },

  created() {
    this.init();
  }

}
</script>

<style>
.flex-row.width-auto {
  flex: 1 !important;
}

.order-statistics.flex-row {
  display: flex;
  flex-direction: row;
  align-items: center;
  flex-wrap: nowrap;
  width: 100%;
}

.order-statistics.flex-row label {
  display: inline-block;
  width: 50px;
  margin-left: 8px;
}

input[type="date"].form-control {
  padding: 8px 12px !important;
  font-size: 13px;
}
</style>