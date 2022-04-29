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
        <Button type="primary" @click="login" long>登录</Button>
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
      password: ''
    };
  },
  async mounted() {
    try {
      let res = await this.$http.post('/api/common/status');
      if (res.data.success) this.$router.replace('/home');
    } catch (err) { }
  },
  methods: {
    async login() {
      if (!this.account || !this.password) {
        this.$Message.error('请先输入账号和密码信息');
        return;
      }
      try {
        let res = await this.$http.post('/api/common/login', {
          account: this.account,
          password: this.password
        });
        if (!res.data.success) {
          this.$Message.error('登录失败：' + res.data.message);
          return;
        }
        this.$router.replace('/home');
      } catch (err) {
        this.$Message.error('登录失败：' + err.message);
      }
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