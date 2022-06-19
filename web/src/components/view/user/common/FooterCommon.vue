<template>
  <footer>
    <div class="container">
      <div class="row">
        <div class="col-lg-4 col-md-6 col-6">
          <span class="title">Giới thiệu</span>
          <ul>
            <li><a href="#">Về Chúng Tôi</a></li>
            <li><a href="#">Sản phẩm</a></li>
            <li><a href="#">Cửa Hàng</a></li>
          </ul>
        </div>
        <div class="col-3">
          <span class="title"><b-icon-telephone class="b-icon"/>Đặt hàng: 1811 0200</span>
          <span class="title"><b-icon-geo-alt class="b-icon"/>Liên hệ</span>
          <span class="location">
            01 Đ. Võ Văn Ngân, 
            <br/>
            Linh Chiểu, Thành Phố Thủ Đức,
            <br/>
            Thành phố Hồ Chí Minh
          </span>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
import * as Constants from '../../../common/Constants'
import {BIconGeoAlt, BIconTelephone} from 'bootstrap-icons-vue'


export default {
  name: Constants.COMPONENT_NAME_FOOTER_COMMON_USER,

  components: {
    BIconTelephone,
    BIconGeoAlt
  }
}
</script>

<style scoped>
footer {
  background: #050505;
  padding: 40px 0px 10px 0px;
  color: #fff;
}

span.title {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
}

.b-icon {
  margin-right: 8px;
}

ul {
  text-decoration: none;
  list-style: none;
  padding-left: 0px;
}

ul li {
  font-size: 12px;
}

ul li a {
  color: #fff;
  text-decoration: none;
}

.location {
  font-size: 12px;
}
</style>