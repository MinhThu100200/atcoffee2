<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="alert alert-danger" role="alert" v-if="error != ''">
            {{error}}
        </div>
        <div class="card-body">
          <form @submit.prevent="handleSave">
            <div class="row">
              <div class="col-9 col">
                <div class="official-info">
                  <span class="title">Thông tin thông báo</span> 
                  <div class="line">
                    <div class="info-group">
                      <label for="code">Tiêu đề</label>
                      <input type="text" class="form-control" id="code" v-model="notification.title" required :readonly="this.$route.path.includes('store-info')">
                    </div>
                    <div class="info-group"></div>
                  </div>
                  <div class="line">
                      <div class="info-group flex-3">
                      <label for="name">Nội dung</label>
                      <textarea class="form-control" id="name" v-model="notification.message" required></textarea>
                  </div>
                </div>
                </div>
              </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="this.$route.path.includes('stores')" type="submit" value="Thêm">
              <div class="action-edit" v-else> 
                <input class="btn btn-success" type="button" :value="this.$route.path.includes('add-notification') ? 'Lưu và gửi' : 'Cập nhật và gửi'" @click="sendNotifications">
                <input class="btn btn-info" type="submit" :value="this.$route.path.includes('add-notification') ? 'Lưu' : 'Cập nhật'">
                <input class="btn btn-danger" type="button" value="Hủy" @click="handleCancel">
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
    <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">{{msg}}</alert-popup>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants' 
import NotificationCommand from '../../../command/NotificationCommand'
import BillDataService from '../../../services/BillDataService'
import Spinner from '../../common/popup/Spinner.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_ACTION_NOTIFICATION_STAFF,

  data() {
    return {
      notification: {
        title: 'A&T Coffee',
        message: '',
        image: '',
        state: false
      },
      error: '',
      isSpinner: false,
      isAlertPopup: false,
      formData: null,
      msg: '',
    }
  },

  components: {
    Spinner,
    AlertPopup
  },

  computed: {

  },

  methods: {

    toast(description, type) {

      var color = type == 'success' ? '#40b883' : '#e76666';
      createToast( {description: description},
        {
          showIcon: 'true',
          hideProgressBar: 'true',
          position: 'top-right',
          toastBackgroundColor: color,
          timeout: 2000,
          type: type,
        })
    },

    loadTokens() {
      BillDataService.findAllTokens(this.$store);
    },

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleCancel() {
      var query = {
        page: this.$store.getters.sortNotification.page,
      };

      var sortNotification = this.$store.getters.sortNotification;
      if (sortNotification.keyword != '') {
        query = {...query, keyword: this.$store.getters.sortNotification.keyword};
      }
      if (sortNotification.state != '') {
        query = {...query, state: this.$store.getters.sortNotification.state};
      }

      this.$router.push({path: '/staff/send-notifications', query});
    },

    async sendNotifications() {
      var validate = this.validate();
      if (!validate) {
        return;
      }
      this.formData = new FormData();
      this.notification.state = true;
      this.formData.append('notification', JSON.stringify(this.notification));
      this.isSpinner = true;
      let saved = await NotificationCommand.save(this.formData);
      var result = null;
      if (saved) {
        result = await NotificationCommand.sendAllNotifications(this.notification.title, this.notification.message, this.notification.image, this.$store.getters.tokens);
      }
      this.isSpinner = false;
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('add-notification') ? 'Thêm và gửi thông báo thành công' : 'Chỉnh sửa thông báo thành công';
      } else {
        text = this.$route.path.includes('add-notification') ? 'Thêm và gửi thông báo thất bại' : 'Chỉnh sửa thông báo thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$router.push({path: '/staff/send-notifications', query: {page: 1}});
    },

    async handleSave() {
      var validate = this.validate();
      if (!validate) {
        return;
      }
      this.formData = new FormData();
      this.notification.state = false;
      this.formData.append('notification', JSON.stringify(this.notification));
      this.isSpinner = true;
      var result = await NotificationCommand.save(this.formData);
      this.isSpinner = false;
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('add-notification') ? 'Thêm thông báo thành công' : 'Chỉnh sửa thông báo thành công';
      } else {
        text = this.$route.path.includes('add-notification') ? 'Thêm thông báo thất bại' : 'Chỉnh sửa thông báo thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$router.push({path: '/staff/send-notifications', query: {page: 1}});
    },

    validate() {
      if (!this.notification.title) {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng nhập tiêu đề!';
        return false;
      }

      if (!this.notification.message) {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng nhập nội dung!';
        return false;
      }

      return true;
    },

    async loadNotificationById(id) {
      this.notification = await NotificationCommand.findOne(id);
    },

    async loadData() {
      if(this.$route.path.includes('notification-info')) {
        this.isSpinner = true;
        await this.loadNotificationById(this.$route.query.id);
        this.isSpinner = false;
      }
    },
    
  },

  created() {
    this.loadTokens();
    this.loadData();
  }
}
</script>

<style>


</style>