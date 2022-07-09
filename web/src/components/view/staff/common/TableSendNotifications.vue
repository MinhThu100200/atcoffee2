<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách đơn hàng</h4>
          <div class="card-header-form flex-row">
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
                  <td class="text-center">{{notification.message}}</td>
                  <td class="text-center">{{notification.creator}}</td>
                  <td class="text-center">{{formatDate(notification.createdDate)}}</td>
                  <td class="text-center">{{notification.sender}}</td>
                  <td class="text-center">{{formatDate(notification.sendedDate)}}</td>
                  <td class="text-center">{{notification.state}}</td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleNotificationInfo(notification.id)">Chi tiết</button>
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
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import Pagination from '../../common/common/Pagination.vue'
import NotificationCommand from '../../../command/NotificationCommand'

export default {
  name: Constants.COMPONENT_NAME_TABLE_SEND_NOTIFICATION_STAFF,

  components: {
    Pagination,
  },

  data() {
    return {
      currentPage: 1,
      keyword: '',
      state: null,
    }
  },

  methods: {

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.status == 'undefined') {
        this.keyword = '';
      }
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION, {...this.$store.getters.sortNotification, keyword: this.keyword, page: this.currentPage});
      
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
    
    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/staff/send-notifications', query: {...query, page: this.currentPage}});
      this.$store.commit(MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION, {...this.$store.getters.sortNotification, page: this.currentPage});
    },

    async loadNotification() {
      await NotificationCommand.findAllByOrder(this.currentPage, Constants.PAGE_SIZE_NOTIFICATION, this.keyword, this.state, this.$store);
    },

    async loadData() {
      await this.loadNotification();
    },

    handleInfo(id){
      this.$router.push({path: '/admin/notification-info', query: {id}});
    },

  },

  created() {
    this.init();
    this.loadData();
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