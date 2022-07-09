<template>
  <staff>
    <section-header :title="title">
      <div class="breadcrumb-item active">
        <router-link to="/staff/products">Trang chủ</router-link>
      </div>
      <div class="breadcrumb-item active">
        <router-link to="/staff/send-notifications?page=1">Danh sách thông báo</router-link>
      </div>
      <div class="breadcrumb-item">
        Tạo thông báo
      </div>
    </section-header>
    <div class="section-body">
      <action-notification></action-notification>
    </div>
    <div class="popup">
    </div>
  </staff>
</template>

<script>
import * as Constants from '../../../common/Constants'
import Staff from '../main/Staff.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import ActionNotification from '../common/ActionNotification.vue'

export default {  
  name: Constants.COMPONENT_NAME_ADD_NOTIFICATION_STAFF,

  data() {
    return {
      title: 'Tạo thông báo'
    }
  },

  components: {
    Staff,
    SectionHeader,
    ActionNotification
  }
}
</script>

<style scoped>

</style>