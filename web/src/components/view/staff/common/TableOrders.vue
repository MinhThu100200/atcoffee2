<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách đơn hàng</h4>
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
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Hành động</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(bill, index) in billsPagination" :key="bill.code">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{bill.code}}</td>
                  <td class="text-center">{{bill.customerName}}</td>
                  <td class="text-center">{{bill.staffName}}</td>
                  <td class="text-center">{{formatPrice(bill.amount)}}</td>
                  <td class="text-center order" :class="colorStatus(bill.status)"><i class="fas fa-circle"></i> {{viStatus(bill.status)}}</td>
                  <td class="text-center">
                    <action-order :bill="bill"></action-order>
                  </td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleOrderInfo(bill.code)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="totalPage"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import Pagination from '../../common/common/Pagination.vue'
import BillDataService from '../../../services/BillDataService'
import ActionOrder from '../common/ActionOrder.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_ORDERS_STAFF,

  components: {
    Pagination,
    ActionOrder
  },

  data() {
    return {
      currentPage: 1,
      status: '',
    }
  },

  computed: {

    size() {
      return Constants.PAGE_SIZE_ORDER;
    },

    billsPagination() {
      return this.$store.getters.billsPagination;
    },

    totalPage() {
      return this.$store.getters.sortBill.totalPage;
    }
  },

  methods: {

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.status = this.$route.query.status;
      if (typeof this.status == 'undefined') {
        this.status = '';
      }
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_BILL, {...this.$store.getters.sortBill, status: this.status, page: this.currentPage});
      
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

    loadBills() {
      BillDataService.findByStoreId(this.$store);
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/staff/orders', query: {...query, page: this.currentPage}});
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_BILL, {...this.$store.getters.sortBill, page: this.currentPage});
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleOrderInfo(billCode) {
      var path = this.$store.getters.user.roleName == Constants.ROLE.ROLE_ADMIN ? '/admin/statistics/order-info' : '/staff/order-info';
      console.log("🚀 ~ file: TableOrders.vue ~ line 138 ~ handleOrderInfo ~ path", path)
      
      this.$router.push({path: path, query: {code: billCode}});
    }
  },

  created() {
    this.init();
  }

}
</script>

<style>

.order {
  display: flex;
  align-items: center;
  justify-content: center;
}

.order .fas.fa-circle {
  font-size: 10px;
  margin-right: 4px;
  line-height: 20px;
}

.requested {
  color: #21a6d2 !important;
}

.canceled {
  color: #ef065d !important;
}

.completed {
  color: #00ad8a !important;
}

.delivering {
  color: #ff8a65 !important;
}

.unapproved {
  color: #474747 !important;
}

.approved {
  color: #00e676 !important;
}

.paid {
  color: #f7810f !important;
}
</style>