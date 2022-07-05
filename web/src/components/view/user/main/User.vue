<template>
  <div class="user">
    <div class="background-user"></div>
    <header-common/>
    <div class="content">
      <slot></slot>
    </div>
    <footer-common/>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants';
import HeaderCommon from '../common/HeaderCommon';
import FooterCommon from '../common/FooterCommon.vue'

export default {
  name: Constants.COMPONENT_NAME_USER,

  components: {
    HeaderCommon,
    FooterCommon
  },

  methods: {

  },

};
</script>

<style scoped>

slot {
  flex: 1;
}


.user {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.content {
  flex: 1;
}

.background {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: #ffffff;
}
</style>
