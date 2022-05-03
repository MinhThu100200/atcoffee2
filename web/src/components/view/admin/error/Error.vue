<template>
  <div class="error">
    <img src="../../../../assets/images/page_not_found.svg"/>
    <p>Không thể tìm thấy trang bạn đang tìm kiếm. </p>
    <router-link to="/login">Quay lại trang đăng nhập</router-link>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'

export default {
  name: Constants.COMPONENT_NAME_ERROR
}
</script>

<style>

.error {
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100vh;
  padding-top: 6%;
  padding-left: 6%;
  padding-right: 6%;
}

.error img {
  height: 28%;
}

.error p {
  display: flex;
  font-weight: 400;
  font-size: 18px;
  color: #34395e;
  margin-top: 40px;
  text-align: center;
}

.error a {
  text-decoration: none;
  color: var(--primary);
  font-size: 14px;
}



</style>