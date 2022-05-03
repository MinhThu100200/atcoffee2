<template>
  <div class="login container-fluid center index-1">
    <section class="section-custom">
      <div class="container">
        <div class="row">
          <div
            class="col-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4 login-form"
          >
            <div class="text-center">
              <img
                src="../../../../assets/logo.png"
                alt="logo"
                width="200"
                class="shadow-light rounded-circle circle"
              />
            </div>
            <div
              :class="['alert', 'alert-danger', incorrect ? 'flex' : '']"
              role="alert"
            >
              Địa chỉ email chưa được đăng kí!
            </div>
            <div class="card card-primary">
              <div class="card-header"><h4>Quên mật khẩu</h4></div>

              <div class="card-body">
                <form
                  class="needs-validation"
                  @submit.prevent="sendEmail(email)"
                >
                  <div class="form-group">
                    <label for="email">Email</label>
                    <input
                      id="email"
                      type="email"
                      class="form-control"
                      tabindex="1"
                      required
                      v-model="email"
                    />
                    <div class="invalid-feedback">
                      Vui lòng điền email
                    </div>
                    <div class="float-right">
                        <router-link to="/login" class="text-small">
                          Đăng nhập
                        </router-link>
                      </div>
                  </div>
                  <div class="form-group">
                    <button
                      type="submit"
                      class="btn btn-primary btn-lg btn-block"
                      tabindex="3"
                    >
                      Gửi mã
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <div class="popup">
      <alert-popup :isAlertPopup="isAlertPopup" @handleHideAlert="handleHideAlert">Mật khẩu đã được gửi tới địa chỉ email của bạn!</alert-popup>
    </div>
  </div>
</template>

<script>
import * as Constants from "../../../common/Constants";
import UserCommand from '../../../command/UserCommand'
import AlertPopup from '../../common/popup/AlertPopup.vue'

export default {
  name: Constants.COMPONENT_NAME_FORGOT_PASSWORD,

  components: {
    AlertPopup
  },

  data() {
    return {
      email: '',
      incorrect: false,
      isAlertPopup: false,

    };
  },

  methods: {

    handleHideAlert() {

      this.isAlertPopup = false;
      this.$router.push({path: '/login'});
    },

    async sendEmail(email) {
      let result = await UserCommand.resetPassword(email);
      if (result == null) {
        this.incorrect = true;
      } else {
        this.isAlertPopup = true;
      }
    }
  },

  created() {
  },
};
</script>

<style scoped>
.login {
  min-height: 100vh;
  background: #f4f6f9;
  padding-top: 4%;
}

.login-form {
  min-width: 360px;
}

.login .alert {
  display: none;
  transition: 0.5s ease-in-out;
}

.login .flex {
  display: flex;
}

.login .card-header {
  background: #fff;
  height: auto !important;
  padding-bottom: 0px !important;
  padding-top: 0px !important;
}

.login .card-header h4 {
  font-size: 16px;
  font-weight: 600;
  line-height: 28px;
  color: #37a372;
  padding: 0px;
  margin: 12px 0px 0px 10px;
}

.login .card.card-primary {
  border: none;
  border-top: 2px solid #37a372;
  border-radius: 4px;
}

.login .card-body {
  padding: 0px 16px 12px 16px;
}

.login .card-body form {
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.5;
}

.login .card-body form .form-group {
  padding: 12px 0px 12px 10px;
}

.login .card-body form .form-group label {
  padding: 4px 0px;
  letter-spacing: 0.5px;
}

.login .card-body form .form-group input {
  font-size: 14px;
  height: 42px;
}

.login .card-body form .form-group a {
  color: #37a372;
  text-decoration: none;
  font-weight: 500;
}

.login .card-body form .form-group a:hover {
  text-decoration: underline;
}

.login .btn-lg {
  width: 100%;
  background: #37a372;
  border: none;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.5px;
  padding: 12px 12px;
  margin-bottom: 20px;
}

.index-1 {
  z-index: 1 !important;
}
</style>
