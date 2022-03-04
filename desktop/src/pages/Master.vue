<template>
  <Layout style="height: 100vh;">
    <Sider :width="240">
      <div style="height: 64px;"></div>
      <vue-custom-scrollbar class="menu-content">
        <Menu active-name="1-2" theme="dark" width="240px">
          <Submenu name="1">
            <template slot="title">
              <Icon type="ios-navigate"></Icon>
              Item 1
            </template>
            <MenuItem name="1-1">
            <Icon type="md-document" />
            Option 1
            </MenuItem>
            <MenuItem name="1-2">Option 2</MenuItem>
            <MenuItem name="1-3">Option 3</MenuItem>
          </Submenu>
          <Submenu name="2">
            <template slot="title">
              <Icon type="ios-keypad"></Icon>
              Item 2
            </template>
            <MenuItem name="2-1">Option 1</MenuItem>
            <MenuItem name="2-2">Option 2</MenuItem>
          </Submenu>
          <Submenu name="3">
            <template slot="title">
              <Icon type="ios-analytics"></Icon>
              Item 3
            </template>
            <MenuItem name="3-1">Option 1</MenuItem>
            <MenuItem name="3-2">Option 2</MenuItem>
          </Submenu>
          <Submenu name="4">
            <template slot="title">
              <Icon type="ios-navigate"></Icon>
              Item 4
            </template>
            <MenuItem name="4-1">Option 1</MenuItem>
            <MenuItem name="4-2">Option 2</MenuItem>
            <MenuItem name="4-3">Option 3</MenuItem>
          </Submenu>
        </Menu>
      </vue-custom-scrollbar>
    </Sider>
    <Content>
      <div class="header">
        <Breadcrumb>
          <BreadcrumbItem to="/">
            <Icon type="ios-home"></Icon> Home
          </BreadcrumbItem>
          <BreadcrumbItem to="/components/breadcrumb">
            <Icon type="logo-buffer"></Icon> Components
          </BreadcrumbItem>
          <BreadcrumbItem>
            <Icon type="ios-cafe"></Icon> Breadcrumb
          </BreadcrumbItem>
        </Breadcrumb>
        <Dropdown style="margin-left: 20px" placement="bottom-end">
          <a>
            管理员
            <Icon type="ios-arrow-down"></Icon>
          </a>
          <DropdownMenu slot="list">
            <DropdownItem>个人信息</DropdownItem>
            <DropdownItem>注销</DropdownItem>
          </DropdownMenu>
        </Dropdown>
      </div>
      <div class="body-content">
        <Tabs type="card" closable :animated="false">
          <TabPane icon="ios-home" label="首页" :closable="false">
            <vue-custom-scrollbar class="tab-content">
              <div>首页</div>
            </vue-custom-scrollbar>
          </TabPane>
          <TabPane label="标签二">
            <vue-custom-scrollbar class="tab-content">
              <div>标签二的内容</div>
            </vue-custom-scrollbar>
          </TabPane>
          <TabPane label="标签三">
            <vue-custom-scrollbar class="tab-content">
              <div>标签三的内容</div>
            </vue-custom-scrollbar>
          </TabPane>
        </Tabs>
      </div>
      <div class="footer">
        Copyright © 2022 Hesai
      </div>
    </Content>
  </Layout>
</template>

<script>
export default {
  name: 'Master',
  data() {
    return {
      tabIndex: 0
    };
  },
  methods: {
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