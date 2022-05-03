<template>
  <div class="spinner" :class="isSpinner ? 'open-popup' : ''">
    <div class="spinner-inner">
       <div class="d-flex justify-content-center">
        <img :src="src" alt="">
      </div>
      <span class="title"><slot></slot></span>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'


export default {
  name: Constants.COMPONENT_NAME_SPINNER_SUCCESS,
  
  props: ['isSpinner', 'src']
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
  width: 160px;
  height: 160px;
  border-radius: 4px;
  transform: translateY(-50%);
}

.spinner-inner img {
  width: 160px;
  height: 160px;
}

.spinner-border {
  height: 50px;
  width: 50px;
}

</style>