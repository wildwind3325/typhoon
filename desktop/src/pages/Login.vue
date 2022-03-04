<template>
  <div class="div-center login-page">
    <div class="div-center login-box">
      <div class="login-box-title">用户登录</div>
      <div class="login-box-item">
        <Input v-model="account" prefix="md-person" placeholder="请输入账号" />
      </div>
      <div class="login-box-item">
        <Input v-model="password" prefix="md-lock" type="password" placeholder="请输入密码" @on-enter="login" />
      </div>
      <div class="login-box-item">
        <Button type="primary" :loading="busy_login" @click="login" long>登录</Button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      account: '',
      password: '',
      busy_login: false
    };
  },
  methods: {
    login() {
      this.$router.push('/home');
    }
  }
}
</script>

<style>
.login-page {
  height: 100vh;
  background-color: #2d3a4b;
}
.login-box {
  width: 300px;
  flex-direction: column;
}
.login-box-title {
  font-size: 32px;
  color: #ffffff;
}
.login-box-item {
  width: 100%;
  margin-top: 20px;
}
</style>