<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff/products">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link :to="linkBackNotifications">Danh sách thông báo</router-link>
      </div>
      <div class="breadcrumb-item">
        Thông tin thông báo
      </div>
    </section-header>
    <div class="section-body">
      <basic-notification-info v-if="!isEdit" :notification="notification" 
        @handleEdit="handleEdit" 
        @sended="handleSended"></basic-notification-info>
      <action-notification v-else ></action-notification>
    </div>  
    <div class="popup">
    </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import NotificationCommand from '../../../command/NotificationCommand'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicNotificationInfo from '../common/BasicNotificationInfo.vue'
import ActionNotification from '../common/ActionNotification.vue'

export default {
  name: Constants.COMPONENT_NAME_NOTIFICATION_INFO,

  data() {
    return {
      notification: {},
      notificationId: 0,
      isEdit: false
    }
  },

  components: {
    Staff,
    SectionHeader,
    BasicNotificationInfo,
    ActionNotification
  },

  computed: {
    linkBackNotifications() {
      var sortNotification = this.$store.getters.sortNotification;
      var urlKeyword = '', urlState = '';
      if (sortNotification.keyword != '') {
        urlKeyword += '&keyword=' + sortNotification.keyword;
      }
      if (sortNotification.state != '') {
        urlState += '&state=' + sortNotification.state;
      }
      
      return `/staff/send-notifications?page=${this.$store.getters.sortNotification.page + urlKeyword + urlState}`;
    }
  },

  methods: {
     init() {
      this.notificationId = this.$route.query.id;
      if (typeof this.notificationId == 'undefined') {
        this.notificationId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async getNotificationById(id) {
      this.notification = await NotificationCommand.findOne(id);
    },

    async handleSended() {
      await this.getNotificationById(this.notificationId);
    }
  },

  created() {
    this.init();
    this.getNotificationById(this.notificationId);
  }
}
</script>

<style>

</style>