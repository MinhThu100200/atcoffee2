<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách đơn hàng</h4>
          <div class="card-header-form flex-row">
            <div class="form-group">
              <select v-model="state" class="form-custom" @change="handleChangeState">
                <option value="">Tất cả các trạng thái</option>
                <option value="true">Đã gửi</option>
                <option value="false">Chưa gửi</option>
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
            <button class="btn btn-success btn-medium" @click="handleAdd" style="width: 160px;">Tạo thông báo</button>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Tiêu đề</th>
                  <th class="text-center">Nội dung</th>
                  <th class="text-center">Người tạo</th>
                  <th class="text-center">Ngày tạo</th>
                  <th class="text-center">Người gửi</th>
                  <th class="text-center">Ngày gửi</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(notification, index) in this.$store.getters.notifications" :key="notification.code">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{notification.title}}</td>
                  <td class="text-center" v-html="notification.message.replace(/\n/g, '</p>\n<p>')"></td>
                  <td class="text-center">{{notification.creator}}</td>
                  <td class="text-center">{{formatDate(notification.createdDate)}}</td>
                  <td class="text-center">{{notification.sender}}</td>
                  <td class="text-center">{{notification.sendedDate ? formatDate(notification.sendedDate) : ''}}</td>
                  <td class="text-center">
                    <span v-if="notification.state" class="notification-state active">Đã gửi</span>
                    <span v-else class="notification-state" title="Gửi" @click="sendNotifications(notification)"><i class="fas fa-paper-plane" style="cursor: pointer;"></i></span>
                  </td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleInfo(notification.id)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortNotification.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortNotification.totalPage"/>
        </div>
      </div>
    </div>
    <spinner :isSpinner="isSpinner">Đang xử lý...</spinner>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import Pagination from '../../common/common/Pagination.vue'
import Spinner from '../../common/popup/Spinner.vue'
import NotificationCommand from '../../../command/NotificationCommand'
import UserCommand from '../../../command/UserCommand'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_TABLE_SEND_NOTIFICATION_STAFF,

  components: {
    Pagination,
    Spinner
  },

  data() {
    return {
      currentPage: 1,
      keyword: '',
      state: '',
      isSpinner: false,
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

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.keyword == 'undefined') {
        this.keyword = '';
      }
      this.state = this.$route.query.state;
      if (typeof this.state == 'undefined') {
        this.state = '';
      }
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION, {...this.$store.getters.sortNotification, keyword: this.keyword, state: this.state, page: this.currentPage});
      
    },

    async loadTokens() {
      await UserCommand.findAllTokens(this.$store);
    },

    handleAdd() {
      this.$router.push({path: '/staff/add-notification'});
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_NOTIFICATION + index + 1;
    },

    formatDate(timeStamp) {
      return CommonUtils.formatDateTime(new Date(timeStamp));
    },

    handleSearch() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/staff/send-notifications', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadNotification();
    },

    handleChangeState() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.state == '') {
        delete query.state;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/staff/send-notifications', query: {...query, page: this.currentPage, state: this.state}});
      }
      this.loadNotification();
    }, 
    
    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/staff/send-notifications', query: {...query, page: this.currentPage}});
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION, {...this.$store.getters.sortNotification, page: this.currentPage});
      this.loadNotification();
    },

    async loadNotification() {
      await NotificationCommand.findAllByOrder(this.currentPage, Constants.PAGE_SIZE_NOTIFICATION, this.keyword, this.state, this.$store);
    },

    async loadData() {
      await this.loadNotification();
    },

    async sendNotifications(notification) {
      var formData = new FormData();
      notification.state = true;
      formData.append('notification', JSON.stringify(notification));
      this.isSpinner = true;
      let saved = await NotificationCommand.save(formData);
      var result = null;
      if (saved) {
        await this.loadTokens();
        result = await NotificationCommand.sendAllNotifications(notification.title, notification.message, notification.image, this.$store.getters.tokens);
      }
      this.isSpinner = false;
      var text = '', type = 'success';
      if (result != null) {

        await this.loadNotification();
        text = 'Gửi thông báo thành công';
      } else {
        text = 'Gửi thông báo thất bại';
        type = 'danger';
      }
      this.toast(text, type);
    },

    handleInfo(id){
      this.$router.push({path: '/staff/notification-info', query: {id}});
    },

  },

  created() {
    this.init();
    this.loadData();
    // this.loadTokens();
  }

}
</script>

<style>

.notification-state {
  font-weight: 600;
}

.notification-state.active {
  color: var(--primary);
}

</style>