<template>
  <admin>
    <section-header :title="title">
        <div class="breadcrumb-item active">
          <router-link to="/admin">Trang chủ</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link to="">Khuyến mãi</router-link>
        </div>
        <div class="breadcrumb-item active">
          <router-link :to="linkBackPromotions">Danh sách khuyến mãi</router-link>
        </div>
        <div class="breadcrumb-item">
          Thông tin khuyến mãi
        </div>
      </section-header>
      <div class="section-body">
        <basic-promotion-info :promotion="promotion" :type="type" @handleEdit="handleEdit" @handleLock="handleLock" v-if="!isEdit"></basic-promotion-info>
        <action-promotion v-if="isEdit" @handleCancel="handleCancel" @handleDone="handleDone"></action-promotion>
      </div>
  </admin>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import TypeCommand from '../../../command/TypeCommand'
import PromotionCommand from '../../../command/PromotionCommand'
import Admin from '../main/Admin.vue'
import SectionHeader from '../../common/common/SectionHeader.vue'
import BasicPromotionInfo from '../common/BasicPromotionInfo.vue'
import ActionPromotion from '../common/ActionPromotion.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_STAFF_INFO,

  components: {
    Admin,
    SectionHeader,
    BasicPromotionInfo,
    ActionPromotion
  },

  data() {
    return {
      title: 'Thông tin khuyến mãi',
      promotion: {},
      type: {},
      promotionId: 0,
      isEdit: false
    }
  },

  computed: {
    linkBackPromotions() {
      var sortPromotion = this.$store.getters.sortPromotion;
      var urlState = '', urlObject = '', urlKeyword = '';
      if (sortPromotion.state != '') {
        urlState += '&state=' + sortPromotion.state;
      }
      if (sortPromotion.object != '') {
        urlObject += '&object=' + sortPromotion.object;
      }
      if (sortPromotion.keyword != '') {
        urlKeyword += '&keyword=' + sortPromotion.keyword;
      }
      return `/admin/promotions?page=${this.$store.getters.sortPromotion.page + urlState + urlObject + urlKeyword}`;
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

    init() {
      this.promotionId = this.$route.query.id;
      if (typeof this.promotionId == 'undefined') {
        this.promotionId = -1;
      }
    },

    handleEdit() {
      this.isEdit = true;
    },

    async handleLock(isLock) {
      let result = await PromotionCommand.findOne(this.promotionId);
      result['state'] = !isLock;
      this.formData = new FormData();
      this.formData.append('promotion', JSON.stringify(result));
      let res = await PromotionCommand.save(this.formData);
      var text = '', type = 'success';
      if (res != null) {
        let query = {};
        query.page = this.$store.getters.sortPromotion.page;
        if (this.$store.getters.sortPromotion.state != '') {
          query.state = this.$store.getters.sortPromotion.state;
        }
        if (this.$store.getters.sortPromotion.object != '') {
          query.object = this.$store.getters.sortPromotion.object;
        }
        if (this.$store.getters.sortPromotion.keyword != '') {
          query.keyword = this.$store.getters.sortPromotion.keyword;
        }
        text = 'Loại bỏ khuyến mãi thành công';
        this.$router.push({path: '/admin/promotions', query: query});
      } else {
        text = 'Loại bỏ khuyến mãi Loại bỏ khuyến mãi thành công';
        type = 'danger';
      }
      this.toast(text, type);
    },

    async handleDone() {
      this.isEdit = false;
      await this.getPromotionById(this.promotionId);
    },

    async handleCancel() {
      this.isEdit = false;
      await this.getPromotionById(this.promotionId);
    },

    async getPromotionById(id) {
      this.promotion = await PromotionCommand.findOne(id);
      await this.loadType(this.promotion.object);
    },

    async loadType(code) {
      this.type = await TypeCommand.findOneByCode(code);
    }
  },

  created() {
    this.$store.commit(MutationsName.MUTATION_NAME_RESET_MENU);
    this.$store.getters.menu.promotion.value = true;
    this.init();
    this.getPromotionById(this.promotionId);
  }
}
</script>

<style>

</style>