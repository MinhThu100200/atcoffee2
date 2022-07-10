<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="dropdown dropdown-setting" v-if="!notification.state">
                <i class="fas fa-cog icon-absolute" @click="handleToggleSetting"></i>
                <div class="dropdown-menu dropdown-menu-right show" v-if="isSetting" v-click-outside="handleHideSetting">
                  <a class="dropdown-item has-icon" @click="handleEdit">
                    <i class="fas fa-edit"></i>
                    Chỉnh sửa
                  </a>
                  <router-link to="" class="dropdown-item has-icon" @click="sendNotifications(notification)">
                   <i class="far fa-paper-plane"></i>
                    Gửi 
                  </router-link>
                </div>
              </div>
            <div class="col-9 col">
              <div class="official-info">
                <span class="title">Thông tin thông báo</span> 
                <div class="line">
                  <div class="info-group">
                    <label>Người tạo</label>
                    <span>{{notification.creator}}</span>
                  </div>
                  <div class="info-group">
                    <label>Ngày tạo</label>
                    <span>{{formatDate(new Date(notification.createdDate))}}</span>
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Người gửi</label>
                    <span>{{notification.sender ? notification.sender : '--------------'}}</span>
                  </div>
                  <div class="info-group">
                    <label>Ngày gửi</label>
                    <span>{{notification.sendedDate ? formatDate(new Date(notification.sendedDate)) : '--------------'}}</span>
                  </div>
                </div>
                 <div class="line">
                  <div class="info-group">
                    <label>Trạng thái</label>
                    <span v-if="notification.state" class="notification-state active">Đã gửi</span>
                    <span v-else class="notification-state" title="Gửi" @click="sendNotifications(notification)">Chưa gửi <i class="fas fa-paper-plane" style="cursor: pointer;"></i></span>
                  </div>
                  <div class="info-group">
                   
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Tiêu đề</label>
                    <span>{{notification.title}}</span>
                  </div>
                  <div class="info-group flex-1">
                   
                  </div>
                </div>
                <div class="line">
                  <div class="info-group">
                    <label>Nội dung</label>
                    <span v-html="notification.message"></span>
                  </div>
                  <div class="info-group flex-1">
                  </div>
                </div>
              </div>
            </div>
            <!-- <div class="col-3 col-custom custom-logo col-center info-basic-left">
              
            </div> -->
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
import NotificationCommand from '../../../command/NotificationCommand'
import Spinner from '../../common/popup/Spinner.vue'
import vClickOutside from 'click-outside-vue3'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_BASIC_NOTIFICATION_INFO,

  props: ['notification'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  components: {
    Spinner
  },

  data() {
    return {
      url: 'https://res.cloudinary.com/tranan2509/image/upload/v1633099012/logo_transparent_rerp84.png',
      isSpinner: false,
      isSetting: false,
      isEdit: false,
      count: 0,
    }
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

    handleToggleSetting() {
      this.isSetting = !this.isSetting;
    },

    handleHideSetting() {
      this.isSetting = false;
    },

    handleEdit() {
      this.$emit('handleEdit');
    },

    formatDate(date) {
      return CommonUtils.formatDateTime(date);
    },  

    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    async sendNotifications(notification) {
      var formData = new FormData();
      notification.state = true;
      formData.append('notification', JSON.stringify(notification));
      this.isSpinner = true;
      let saved = await NotificationCommand.save(formData);
      var result = null;
      if (saved) {
        result = await NotificationCommand.sendAllNotifications(notification.title, notification.message, notification.image, this.$store.getters.tokens);
      }
      this.isSpinner = false;
      var text = '', type = 'success';
      if (result != null) {

        text = 'Gửi thông báo thành công';
        this.$emit('sended');
      } else {
        text = 'Gửi thông báo thất bại';
        type = 'danger';
      }
      this.toast(text, type);
    },
    
  },

  created() {
  },
}
</script>

<style scoped>
.notification-state {
  font-weight: 600;
  color: #f55951 !important;
}

.notification-state.active {
  color: var(--primary) !important;
}

</style>