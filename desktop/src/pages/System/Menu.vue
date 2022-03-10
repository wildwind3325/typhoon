<template>
  <div class="container">
    <div class="tree" style="padding: 0px 20px;">
      <vue-custom-scrollbar class="tree-area">
        <Tree :data="treeData" @on-select-change="selectNode"></Tree>
      </vue-custom-scrollbar>
    </div>
    <div class="content">
      <vue-custom-scrollbar class="content-area">
        <Form v-show="mode === 0" ref="module" :model="module" :rules="moduleRules" :label-width="80"
          @submit.native.prevent>
          <FormItem label="名称" prop="name">
            <Input v-model="module.name"></Input>
          </FormItem>
          <FormItem label="代码" prop="code">
            <Input v-model="module.code"></Input>
          </FormItem>
          <FormItem label="排序" prop="order">
            <Input v-model.number="module.order" type="number"></Input>
          </FormItem>
          <FormItem label="图标" prop="icon">
            <Input v-model="module.icon"></Input>
          </FormItem>
          <FormItem>
            <Button type="primary" @click="moduleSave">新建模块</Button>
            <Button style="margin-left: 8px;" @click="moduleReset">重置</Button>
          </FormItem>
        </Form>
        <Form v-show="mode === 1" ref="page" :model="page" :rules="pageRules" :label-width="80" @submit.native.prevent>
          <FormItem label="名称" prop="name">
            <Input v-model="page.name"></Input>
          </FormItem>
          <FormItem label="代码" prop="code">
            <Input v-model="page.code"></Input>
          </FormItem>
          <FormItem label="路径" prop="route">
            <Input v-model="page.route"></Input>
          </FormItem>
          <FormItem label="排序" prop="order">
            <Input v-model.number="page.order" type="number"></Input>
          </FormItem>
          <FormItem label="图标" prop="icon">
            <Input v-model="page.icon"></Input>
          </FormItem>
          <FormItem>
            <Button type="primary" @click="pageSave">新建页面</Button>
            <Button style="margin-left: 8px;" @click="pageReset">重置</Button>
          </FormItem>
        </Form>
        <Form v-show="mode === 2" ref="func" :model="func" :rules="funcRules" :label-width="80" @submit.native.prevent>
          <FormItem label="名称" prop="name">
            <Input v-model="func.name"></Input>
          </FormItem>
          <FormItem label="代码" prop="code">
            <Input v-model="func.code"></Input>
          </FormItem>
          <FormItem label="图标" prop="route">
            <Input v-model="func.route"></Input>
          </FormItem>
          <FormItem>
            <Button type="primary" @click="funcSave">新建权限</Button>
            <Button style="margin-left: 8px;" @click="funcReset">重置</Button>
          </FormItem>
        </Form>
      </vue-custom-scrollbar>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Menu',
  data() {
    return {
      treeData: [{
        title: '系统管理',
        type: 'module',
        children: [{
          title: '菜单管理',
          type: 'page'
        }]
      }],
      mode: 0,
      module: {
        id: 0,
        name: '',
        code: '',
        order: 1,
        icon: ''
      },
      moduleRules: {
        name: { required: true, message: '请填写模块名称', trigger: 'blur' },
        code: { required: true, message: '请填写模块代码', trigger: 'blur' },
        order: { type: 'integer', required: true, message: '请填写模块排序', trigger: 'blur' },
        icon: { required: true, message: '请填写模块图标', trigger: 'blur' }
      },
      page: {
        id: 0,
        module_id: 0,
        name: '',
        code: '',
        route: '',
        order: 1,
        icon: '',
        visible: 1
      },
      pageRules: {
        name: { required: true, message: '请填写页面名称', trigger: 'blur' },
        code: { required: true, message: '请填写页面代码', trigger: 'blur' },
        route: { required: true, message: '请填写页面模块路径', trigger: 'blur' },
        order: { type: 'integer', required: true, message: '请填写页面排序', trigger: 'blur' },
        icon: { required: true, message: '请填写页面图标', trigger: 'blur' }
      },
      func: {
        id: 0,
        name: '',
        code: '',
        route: ''
      },
      funcRules: {
        name: { required: true, message: '请填写权限名称', trigger: 'blur' },
        code: { required: true, message: '请填写权限代码', trigger: 'blur' },
        route: { required: true, message: '请填写权限路由', trigger: 'blur' }
      }
    };
  },
  methods: {
    selectNode(nodes, node) {
      console.log(node.type);
    },
    moduleSave() {
      this.$refs.module.validate(valid => {
        if (valid) {
          this.$Message.success('表单验证成功');
        } else {
          this.$Message.error('表单验证失败，请检查输入。');
        }
      });
    },
    moduleReset() {
      this.$refs.module.resetFields();
    },
    pageSave() {
      this.$refs.page.validate(valid => {
        if (valid) {
          this.$Message.success('表单验证成功');
        } else {
          this.$Message.error('表单验证失败，请检查输入。');
        }
      });
    },
    pageReset() {
      this.$refs.page.resetFields();
    },
    funcSave() {
      this.$refs.func.validate(valid => {
        if (valid) {
          this.$Message.success('表单验证成功');
        } else {
          this.$Message.error('表单验证失败，请检查输入。');
        }
      });
    },
    funcReset() {
      this.$refs.func.resetFields();
    }
  }
};
</script>

<style scoped>
.container {
  display: flex;
  justify-content: space-between;
}
.tree {
  width: 200px;
  height: calc(100vh - 122px);
  background-color: white;
}
.tree-area {
  width: 160px;
  height: calc(100vh - 122px);
}
.content {
  width: calc(100% - 210px);
  height: calc(100vh - 122px);
  background-color: white;
}
.content-area {
  width: 100%;
  height: calc(100vh - 122px);
  padding: 20px 20px 0px 20px;
}
</style>