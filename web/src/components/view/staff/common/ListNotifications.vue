<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách thông báo</h4> 
        </div>
        <div class="card-body p-0">
          <router-link to="" class="dropdown-item" :class="!bill.read ? 'dropdown-item-unread' : ''"
              v-for="bill in this.$store.getters.bills" :key="bill.id" @click="handleReadBill(bill)">
              <div class="dropdown-item-icon bg-primary text-white">
                <i class="fas fa-bell"></i>
              </div>
              <div class="dropdown-item-desc" v-if="!bill.address">
                Đơn hàng với ID {{bill.code}} được yêu cầu từ khách hàng tại quầy
                <div class="time text-primary">{{fromNow(bill.createdDate)}}</div>
              </div>
              <div class="dropdown-item-desc" v-else>
                Đơn hàng với ID {{bill.code}} được yêu cầu từ khách hàng {{bill.customerName}} vị trí ở {{bill.address}}
                <div class="time text-primary">{{fromNow(bill.createdDate)}}</div>
              </div>
            </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import CommonUtils from '../../../common/CommonUtils'
import BillDataService from '../../../services/BillDataService'

export default {
  name: Constants.COMPONENT_NAME_LIST_NOTIFICATION_STAFF,

  components: {

  },

  computed: {

    
  },

  methods: {
    fromNow(timeStamp) {
      return CommonUtils.fromNow(timeStamp);
    },

    handleReadBill(bill) {
      bill.read = true;
      BillDataService.update(bill, this.$store);
      this.$router.push({path: '/staff/order-info', query: {code: bill.code}});
    },
  },

}
</script>

<style scoped>
ul {
  list-style-type: none;
}

a {
  color: #535776;
}

a:hover {
  text-decoration: none;
}

.dropdown-item {
  display: flex;
  padding-top: 15px;
  padding-bottom: 15px;
}

.dropdown-item.dropdown-item-unread {
  background: #f8f8f8;
}

.dropdown-item-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  flex-shrink: 0;
  line-height: 42px;
  text-align: center;
}

.dropdown-item-icon i {
  margin: 0;
}

.dropdown-item-desc {
  margin-left: 15px;
  line-height: 20px;
}

.time {
  margin-top: 5px;
}

.dropdown-item .time {
  font-weight: 600;
  text-transform: uppercase;
  font-size: 10px;
  letter-spacing: .5px;
}

.dropdown-menu.transition {
  transition: all .3s;
}

.text-center {
  text-align: center !important;
}

.text-width {
  color: #fff !important;
}

.bg-primary {
  background: var(--primary);
}
</style>