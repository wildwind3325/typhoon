<template>
  <Layout style="height: 100vh;">
    <Sider :width="240">
      <div style="height: 64px;"></div>
      <vue-custom-scrollbar class="menu-content">
        <Menu ref="menus" :active-name="menu" theme="dark" width="240px" @on-select="selectMenu">
          <Submenu name="1">
            <template slot="title">
              <Icon type="ios-navigate"></Icon>
              功能
            </template>
            <MenuItem name="c1">C1</MenuItem>
            <MenuItem name="c2">C2</MenuItem>
          </Submenu>
        </Menu>
      </vue-custom-scrollbar>
    </Sider>
    <Content>
      <div class="header">
        <Breadcrumb>
          <BreadcrumbItem>
            <Icon type="ios-home"></Icon> 首页
          </BreadcrumbItem>
        </Breadcrumb>
        <Dropdown style="margin-left: 20px" placement="bottom-end" @on-click="myAction">
          <a>
            管理员
            <Icon type="ios-arrow-down"></Icon>
          </a>
          <DropdownMenu slot="list">
            <DropdownItem name="profile">个人信息</DropdownItem>
            <DropdownItem name="logout">注销</DropdownItem>
          </DropdownMenu>
        </Dropdown>
      </div>
      <div class="body-content">
        <Tabs v-model="activeTab" type="card" :animated="false" :before-remove="closeTab" @on-click="changeTab">
          <TabPane v-for="(item, index) in tabs" :key="index" :label="item.lable" :icon="item.icon"
            :closable="index > 0">
            <vue-custom-scrollbar class="tab-content">
              <component :is="comps[item.code]" :actived="index ===  activeTab">
              </component>
            </vue-custom-scrollbar>
          </TabPane>
        </Tabs>
      </div>
      <div class="footer">
        Copyright © 2022
      </div>
    </Content>
  </Layout>
</template>

<script>
import cookie from '../api/cookie';
import comps from './comps';
export default {
  name: 'Master',
  data() {
    return {
      menu: '',
      activeTab: 0,
      tabs: [{
        lable: '首页',
        icon: 'ios-home',
        code: 'home',
        options: {}
      }],
      comps: comps
    };
  },
  async mounted() {
    await this.$http.post('/api/user/list');
  },
  methods: {
    selectMenu(name) {
      for (let i = 0; i < this.tabs.length; i++) {
        if (this.tabs[i].code === name) {
          this.activeTab = i;
          return;
        }
      }
      this.tabs.push({
        lable: name,
        icon: 'logo-android',
        code: name,
        options: {}
      });
      this.activeTab = this.tabs.length - 1;
    },
    updateMenu() {
      let code = this.activeTab === 0 ? '' : this.tabs[this.activeTab].code;
      if (this.menu !== code) {
        this.menu = code;
        this.$nextTick(() => {
          this.$refs.menus.updateActiveName();
        });
      }
    },
    myAction(name) {
      if (name === 'logout') {
        cookie.set('token', '', -1);
        this.$router.replace('/');
      }
    },
    closeTab(index) {
      if (this.activeTab === index) {
        this.activeTab = index - 1;
      } else if (this.activeTab > index) {
        this.activeTab--;
      }
      this.tabs.splice(index, 1);
      this.updateMenu();
      return Promise.reject();
    },
    changeTab(index) {
      this.updateMenu();
    }
  }
};
</script>

<style scoped>
.menu-content {
  width: 100%;
  height: calc(100vh - 64px);
}
.header {
  display: flex;
  justify-content: space-between;
  height: 64px;
  line-height: 64px;
  padding: 0px 10px;
}
.body-content {
  width: 100%;
  height: calc(100vh - 96px);
}
.tab-content {
  width: 100%;
  height: calc(100vh - 144px);
  padding: 0px 10px 10px 10px;
}
.footer {
  width: 100%;
  height: 32px;
  line-height: 32px;
  padding-right: 10px;
  text-align: right;
}
</style>