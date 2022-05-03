<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách chi tiết đơn hàng</h4> 
          <div class="flex-1"></div>
          <action-order :bill="$store.getters.bill"></action-order>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã</th>
                  <th class="text-center">Tên sản phẩm</th>
                  <th class="text-center">Kích thước</th>
                  <th class="text-center">Giá bán</th>
                  <th class="text-center">Số lượng</th>
                  <th class="text-center">Giảm giá</th>
                  <th class="text-center">Thành tiền</th>
                  <th class="text-center">Ghi chú</th>
                </tr>
                <tr v-for="(billDetail, index) in $store.getters.bill.billDetails" :key="billDetail.code">
                  <td class="text-center">{{index + 1}}</td>
                  <td class="text-center">{{billDetail.code}}</td>
                  <td class="text-center">{{billDetail.name}}</td>
                  <td class="text-center">{{billDetail.size}}</td>
                  <td class="text-center">{{formatPrice(billDetail.price)}}</td>
                  <td class="text-center">{{billDetail.quantity}}</td>
                  <td class="text-center">{{billDetail.discount}}%</td>
                  <td class="text-center">{{formatPrice(billDetail.amount)}}</td>
                  <td class="text-center">{{billDetail.description == '' ? 'Không có' : billDetail.description}}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import ActionOrder from './ActionOrder.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_ORDER_DETAILS_STAFF,

  components: {
    ActionOrder
  },

  computed: {

    
  },

  methods: {
    
    colorStatus(status) {
      return status.toLowerCase();
    },

    viStatus(status) {
      return Constants.STATUS_BILL_VI[status];
    },

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    handleOrderInfo(billCode) {

      this.$router.push({path: '/staff/order-info', query: {code: billCode}});
    }
  },

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
  color: #21a6d2;
}

.canceled {
  color: #ef065d;
}

.completed {
  color: #00ad8a;
}

.unapproved {
  color: #474747;
}

.paid {
  color: #f7810f;
}
</style>