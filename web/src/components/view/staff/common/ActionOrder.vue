<template>
  <div class="btn-action">
    <button class="btn btn-approve" v-if="buttonsAction.includes('approve')" @click="handleChangeStatus('APPROVED')">Chấp nhận</button>
    <button class="btn btn-cancel" v-if="buttonsAction.includes('cancel')" @click="handleChangeStatus('CANCELED')">Hủy</button>
    <button class="btn btn-delivery" v-if="buttonsAction.includes('delivery')" @click="handleChangeStatus('DELIVERING')">Giao hàng</button>
    <button class="btn btn-complete" v-if="buttonsAction.includes('complete')" @click="handleChangeStatus('COMPLETED')">Hoàn thành</button>
  </div>
  <div class="popup">
    <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants' 
import BillCommand from '../../../command/BillCommand';
import BillDataService from '../../../services/BillDataService'
import NotificationService from '../../../services/NotificationService'
import AlertPopup from '../../common/popup/AlertPopup.vue';
import NotificationCommand from '../../../command/NotificationCommand';

export default {
  components: { AlertPopup },
  name: Constants.COMPONENT_NAME_ACTION_ORDER_STAFF,

  props: ['bill', 'status'],


  data() {
    return {
      isAlertPopup: false,
      msg: ''
    }
  },

  computed: {

    buttonsAction() {
      switch(this.bill.status) {
        case Constants.STATUS_BILL.REQUESTED: 
          return ['approve', 'cancel'];
        case Constants.STATUS_BILL.PAID: case Constants.STATUS_BILL.APPROVED: 
          return ['delivery'];
        case Constants.STATUS_BILL.DELIVERING:
          return ['complete'];
      }
      return [];
    }
  },

  methods: {

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    getMessage(code, status) {

      var message = 'Đơn hàng ' + code + ' ';

      switch(status) {
        case Constants.STATUS_BILL.REQUESTED: 
          message += 'đang chờ xác nhận';
          break;
        case Constants.STATUS_BILL.APPROVED: 
          message += 'đang chuẩn bị';
          break;
        case Constants.STATUS_BILL.UNAPPROVED: 
          message += 'không được chấp nhận';
          break;
        case Constants.STATUS_BILL.PAID: 
          message += 'thanh toán thành công';
          break;
        case Constants.STATUS_BILL.UNPAID: 
          message += 'chưa được thanh toán';
          break;
        case Constants.STATUS_BILL.CANCELED: 
          message += 'đã hủy';
          break;
        case Constants.STATUS_BILL.DELIVERING: 
          message += 'đang được giao';
          break;
        case Constants.STATUS_BILL.COMPLETED: 
          message += 'đã giao thành công';
          break;
      }

      return message;
    },

    async handleChangeStatus(status) {
      let bill = {...this.bill, status};

      var isSave = false;
      if (this.bill.staffName == '') {
        bill.staffName = this.$store.getters.user.name;
        bill.staffId = this.$store.getters.user.id;
        isSave = true;
      }
      let result = await BillCommand.updateStatus(bill);
      if (result != null) {
        if (isSave) {
          bill.id = result.id;
        }
        BillDataService.update(bill);

        var message = this.getMessage(bill.code, bill.status);

        var notification = {
          id: bill.customerId,
          code: bill.code + '_' + bill.status,
          codeOrder: bill.code,
          isSeen: false,
          title: 'Thông báo',
          body: message,
          time: (new Date()).getTime()
        }

        NotificationCommand.sendNotification(notification.title, notification.body, bill.token);

        NotificationService.save(notification);
      } else {
        this.isAlertPopup = true;
        this.msg = 'Cập nhật đơn hàng không thành công!';
      }
    },

  }
}
</script>

<style>

.btn-action .btn {
  margin: 0 2px;
}

.btn.btn-approve {
  border: 1px solid #00c853;
  color: #00c853;
}

.btn.btn-approve:hover {
  background: #00c853;
  color: #fff;
}

.btn.btn-cancel {
  border: 1px solid #ef065d;
  color: #ef065d;
}

.btn.btn-cancel:hover {
  background: #ef065d;
  color: #fff;
}

.btn.btn-delivery {
  border: 1px solid #ff8a65;
  color: #ff8a65;
}

.btn.btn-delivery:hover {
  background: #ff8a65;
  color: #fff;
}

.btn.btn-complete {
  border: 1px solid #00ad8a;
  color: #00ad8a;
}

.btn.btn-complete:hover {
  background: #00ad8a;
  color: #fff;
}

</style>