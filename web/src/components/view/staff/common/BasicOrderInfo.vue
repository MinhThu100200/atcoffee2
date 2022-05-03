<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-12 col">
              <div class="official-info">
                <span class="title">Thông tin chi tiết</span> 
                <div class="line">
                  <div class="info-group flex-1">
                    <label>Mã hóa đơn</label>
                    <span>{{$store.getters.bill.code}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Tên khách hàng</label>
                    <span>{{$store.getters.bill.customerName != '' ? $store.getters.bill.customerName : 'Không có'}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Tên nhân viên</label>
                    <span>{{$store.getters.bill.staffName != '' ? $store.getters.bill.staffName : 'Không có'}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Trạng thái</label>
                    <span :class="$store.getters.bill.status.toLowerCase()" class="bold">{{viStatus($store.getters.bill.status)}}</span>
                  </div>
                </div>
                 <div class="line">
                  <div class="info-group flex-1">
                    <label>Tổng tiền</label>
                    <span>{{formatPrice($store.getters.bill.price)}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Giảm giá</label>
                    <span>{{formatPrice($store.getters.bill.discount)}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Điểm nhận được</label>
                    <span>{{$store.getters.bill.point}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Thành tiền</label>
                    <span>{{formatPrice($store.getters.bill.amount)}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group flex-1">
                    <label>Địa chỉ</label>
                    <span>{{$store.getters.bill.address}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Mã giảm giá</label>
                    <span>{{$store.getters.bill.promotionCode == '' ? 'Không có' : $store.getters.bill.promotionCode}}</span>
                  </div>
                  <div class="info-group flex-1">
                    <label>Thời gian tạo</label>
                    <span>{{formatDate($store.getters.bill.createdDate)}}</span>
                  </div> 
                  <div class="info-group flex-1">
                    <label>Phương thức thanh toán</label>
                    <span>{{$store.getters.bill.paymentName}}</span>
                  </div>
                </div> 
              </div>
            </div>
            <table-order-details></table-order-details>
          </div>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import Spinner from '../../common/popup/Spinner.vue'
import TableOrderDetails from '../common/TableOderDetails.vue'

export default {
  name: Constants.COMPONENT_NAME_BASIC_ORDER_INFO_STAFF,

  components: {
    Spinner,
    TableOrderDetails,
  },

  data() {
    return {
      isSpinner: false,
    }
  },

  methods: {

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    formatDate(timeStamp) {
      return CommonUtils.formatDateTime(new Date(timeStamp));
    },

    viStatus(status) {
      return Constants.STATUS_BILL_VI[status];
    },
  },

  created() {
  }
}
</script>

<style>

.bold {
  font-weight: bold;
}
</style>