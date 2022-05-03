<template>
  <div class="row">
    <div class="col-12">
      <div class="card" :class="this.$route.path.includes('rewards') ? 'card-none-margin' : ''">
        <div class="alert alert-danger" role="alert" v-if="error != ''">
            {{error}}
        </div>
        <div class="card-body">
          <form @submit.prevent="handleSave">
            <div class="row">
              <div class="col-12 col">
                <div class="official-info">
                  <span class="title">Thông tin phần thưởng</span> 
                  <div class="line">
                    <div class="info-group">
                      <label for="code">Mã phần thưởng</label>
                      <input type="text" class="form-control" id="code" v-model="reward.code" required :readonly="this.$route.path.includes('reward-info')">
                    </div>
                    <div class="info-group">
                      <label for="code">Tên phần thưởng</label>
                      <input type="text" class="form-control" id="code" v-model="reward.name" required>
                    </div>
                  </div>
                  <div class="line">
                    <div class="info-group flex-1">
                      <label for="proviso">Số điểm</label>
                      <input type="text" class="form-control" id="proviso" v-model="reward.proviso" required>
                    </div>
                     <div class="info-group flex-1">
                      <label for="redution">Mức giảm (vnđ)</label>
                      <input type="number" class="form-control" id="redution" v-model="reward.redution" placeholder="vnđ" required> 
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="action">
              <input class="btn btn-success" v-if="this.$route.path.includes('rewards')" type="submit" value="Thêm">
              <div class="action-edit" v-else> 
                <input class="btn btn-info" type="submit" value="Cập nhật">
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
import RewardCommand from '../../../command/RewardCommand'
import RewardEntity from '../../../entities/RewardEntity'
import Spinner from '../../common/popup/Spinner.vue'
import AlertPopup from '../../common/popup/AlertPopup.vue'
import { createToast } from 'mosha-vue-toastify';
import 'mosha-vue-toastify/dist/style.css';

export default {
  name: Constants.COMPONENT_NAME_ACTION_REWARD,

  components: {
    Spinner,
    AlertPopup
  },

  data() {
    return {
      reward: new RewardEntity(),
      error: '',
      isSpinner: false,
      isAlertPopup: false,
      msg: ''
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

    handleHideAlert() {
      this.isAlertPopup = false;
    },

    handleCancel() {
      this.$emit('handleCancel');
    },

    async handleSave() {
      var validate = await this.validate();
      if (!validate) {
        return;
      }
      this.reward.state = this.$route.path.includes('rewards') ? true : this.reward.state;
      this.isSpinner = true;
      let result = await RewardCommand.save(this.reward);
      this.isSpinner = false;
      result != null && this.$route.path.includes('rewards') ? this.clearData() : '';
      var text = '', type = 'success';
      if (result != null) {
        text = this.$route.path.includes('rewards') ? 'Thêm phần thưởng thành công' : 'Chỉnh sửa phần thưởng thành công';
      } else {
        text = this.$route.path.includes('rewards') ? 'Thêm phần thưởng thất bại' : 'Chỉnh sửa phần thưởng thất bại';
        type = 'danger';
      }
      this.toast(text, type);
      this.$emit('handleDone');
    },

    async validate() {
       if (this.reward.code.trim() == '' || this.reward.name.trim() == '') {
        this.isAlertPopup = true;
        this.msg = 'Vui lòng không để trống dữ liệu!';
        return false;
      }
      var reward = await this.findRewardByCode(this.reward.code);
      if (reward != null && reward.id != this.reward.id) {
        this.isAlertPopup = true;
        this.msg = 'Mã phần thưởng đã tồn tại!';
        return false;
      }
      return true;
    },

    clearData() {

      this.reward = new RewardEntity();
      this.error = '';
    },

    async findRewardByCode(code) {
      let result = await RewardCommand.findOneByCode(code);
      return result;
    },

    async loadData() {
      this.isSpinner = true;
      if(this.$route.path.includes('reward-info')) {
        this.reward = await this.loadReward(this.$route.query.id);
      }
      this.isSpinner = false;
    },

    async loadReward(id) {
      let result = await RewardCommand.findOne(id);
      return result;
    } 
  },

  created(){
    this.loadData();
  }
}
</script>

<style>

</style>