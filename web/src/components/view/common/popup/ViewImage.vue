<template>
  <div class="view-image" :class="isViewImage ? 'open-popup' : ''">
    <div class="view-image-inner" v-click-outside="handleHide">
      <span class="img">
        <img :src="image" alt="img">
      </span>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_VIEW_IMAGE,

  props: ['isViewImage', 'image'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  data() {
    return {
      count: 0
    }
  },

  methods: {
    handleHide(){
      this.count += this.isViewImage ? 1 : 0;
      this.count % 2 == 0 ? this.$emit('handleHide') : null;
    }
  }
}
</script>

<style scoped>
.view-image {
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
  z-index: 9999;
}

.open-popup {
  visibility: visible;
  opacity: 1;
  transform: scale(1);
}

.view-image-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #fff;
  width: 604px;
  height: 604px;
  border-radius: 4px;
  transform: translateY(-5%);
}

.view-image-inner .img img{
  border-radius: 4px;
  object-fit: cover;
  width: 600px;
  height: 600px;
}
</style>