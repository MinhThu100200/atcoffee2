<template>
  <div class="spinner" :class="isAlertPopup ? 'open-popup' : ''">
    <div class="spinner-inner">
      <div class="title"><b>A&amp;T Coffee</b><i class="fas fa-times" @click="handleHideAlert"></i></div>
      <hr>
      <span class="msg"><slot></slot></span>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'

export default {
  name: Constants.COMPONENT_NAME_SPINNER,

  props: ['isAlertPopup'],

  methods: {
    handleHideAlert() {
      this.$emit('handleHideAlert');
    }
  }
}
</script>

<style scoped>
.spinner {
  position: fixed;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.2);
  transition: all .3s;
  visibility: hidden;
  opacity: 0;
  transform: scale(1.2);
  z-index: 1000;
}

.open-popup {
  visibility: visible;
  opacity: 1;
  transform: scale(1);
}

.spinner-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #fff;
  border-radius: 4px;
  transform: translateY(-50%);
  padding: 10px 10px;
  width: 400px;
}

.spinner-inner .title {
  display: flex;
  text-align: left;
  width: 100%;
  font-size: 20px;
}

.spinner-inner .title b {
  flex: 1;
}

.spinner-inner .title i:hover {
  color: red;
  cursor: pointer;
}

hr {
  width: 100%;
  border: 0.5px solid #ccc;
  margin-top: 0px;
  margin-bottom: 0;
}

.msg {
  width: 100%;
  text-align: left;
  margin: 10px 0px;
  font-size: 16px;
}
</style>