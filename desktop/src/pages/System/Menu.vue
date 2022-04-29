<template>
  <div class="container">
    <div class="tree">
      <vue-custom-scrollbar class="tree">
        <Tree :data="items" style="padding: 0px 20px;" @on-select-change="selectNode"></Tree>
      </vue-custom-scrollbar>
    </div>
    <div class="content">
      <div style="padding: 10px 20px;">
        <Button type="primary" icon="ios-add-circle-outline" @click="create(0)">新建模块</Button>
        <Button type="primary" icon="ios-add-circle-outline" style="margin-left: 8px;" @click="create(1)">新建菜单</Button>
        <Button type="primary" icon="ios-add-circle-outline" style="margin-left: 8px;" @click="create(2)">新建功能</Button>
        <Button type="error" icon="ios-remove" style="margin-left: 8px;" @click="remove">删除</Button>
      </div>
      <vue-custom-scrollbar style="height: calc(100vh - 174px);">
        <Form ref="form" :model="item" :rules="rules" :label-width="80" style="padding: 20px 20px 0px 20px;"
          @submit.native.prevent>
          <FormItem label="名称" prop="name">
            <Input v-model="item.name"></Input>
          </FormItem>
          <FormItem label="代码" prop="code">
            <Input v-model="item.code"></Input>
          </FormItem>
          <FormItem label="排序" prop="order">
            <Input v-model.number="item.order" type="number"></Input>
          </FormItem>
          <FormItem label="图标" prop="icon">
            <Input v-model="item.icon"></Input>
          </FormItem>
          <FormItem v-show="item.type === 1" label="前台路由">
            <Input v-model="item.route_fe"></Input>
          </FormItem>
          <FormItem v-show="item.type === 2" label="后台路由">
            <Input v-model="item.route_be"></Input>
          </FormItem>
          <FormItem label="是否可见">
            <i-switch v-model="item.visible" :true-value="1" :false-value="0" />
          </FormItem>
          <FormItem>
            <Button type="primary" @click="save">保存</Button>
            <Button style="margin-left: 8px;" @click="cancel">取消</Button>
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
      items: [],
      currentItem: undefined,
      item: {
        id: 0,
        parent_id: 0,
        name: '',
        code: '',
        type: 0,
        order: 1,
        icon: '',
        route_fe: '',
        route_be: '',
        visible: 1
      },
      rules: {
        name: { required: true, message: '请填写模块名称', trigger: 'blur' },
        code: { required: true, message: '请填写模块代码', trigger: 'blur' },
        order: { type: 'integer', required: true, message: '请填写模块排序', trigger: 'blur' }
      }
    };
  },
  async mounted() {
    this.search();
  },
  methods: {
    selectNode(nodes, node) {
      if (nodes.length > 0) {
        this.currentItem = nodes[0];
        this.item = {
          id: node.id,
          parent_id: node.parent_id,
          name: node.name,
          code: node.code,
          type: node.type,
          order: node.order,
          icon: node.icon,
          route_fe: node.route_fe,
          route_be: node.route_be,
          visible: node.visible
        };
      } else {
        this.currentItem = undefined;
        this.clear();
      }
    },
    async search() {
      try {
        let res = await this.$http.post('/api/system/menu/list');
        if (res.data.success) {
          this.items = res.data.data;
          this.clear();
        } else {
          this.$Message.error('加载失败：' + res.data.message);
        }
      } catch (err) {
        this.$Message.error('加载失败：' + err.message);
      }
    },
    create(type) {
      let parent_id = 0;
      if (type === 1 && (!this.currentItem || this.currentItem.type !== 0)) {
        this.$Message.error('请在模块下建立菜单，先选中该模块。');
        return;
      }
      if (type === 2 && (!this.currentItem || this.currentItem.type !== 1)) {
        this.$Message.error('请在菜单下建立功能，先选中该菜单。');
        return;
      }
      if (type !== 0) {
        parent_id = this.currentItem.id;
      }
      this.item = {
        id: 0,
        parent_id: parent_id,
        name: '',
        code: '',
        type: type,
        order: 1,
        icon: '',
        route_fe: '',
        route_be: '',
        visible: 1
      };
    },
    remove() {
      if (!this.currentItem) return;
      if (this.currentItem.children && this.currentItem.children.length > 0) {
        this.$Message.error('该项目存在子集，不能删除。');
        return;
      }
      this.$Modal.confirm({
        title: '提示',
        content: '确定要删除该项目吗？',
        onOk: async () => {
          try {
            let res = await this.$http.post('/api/system/menu/delete', { id: this.currentItem.id });
            if (res.data.success) {
              this.search();
              this.$Message.success('删除成功');
            } else {
              this.$Message.error('删除失败：' + res.data.message);
            }
          } catch (err) {
            this.$Message.error('删除失败：' + err.message);
          }
        }
      });
    },
    save() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          if (this.item.type === 2 && !this.item.route_be) {
            this.$Message.error('请填写后端路由');
            return;
          }
          try {
            let action = 'create';
            if (this.item.id !== 0) action = 'edit';
            let res = await this.$http.post('/api/system/menu/' + action, this.item);
            if (res.data.success) {
              await this.search();
              // if (action === 'create') {
              //   this.clear();
              //   let ni = res.data.data;
              //   ni.title = ni.name;
              //   if (ni.parent_id === 0) {
              //     this.items.push(ni);
              //   } else {
              //     this.currentItem.children.push(ni);
              //   }
              // } else {
              //   this.currentItem.name = this.item.name;
              //   this.currentItem.code = this.item.code;
              //   this.currentItem.order = this.item.order;
              //   this.currentItem.icon = this.item.icon;
              //   this.currentItem.route_fe = this.item.route_fe;
              //   this.currentItem.route_be = this.item.route_be;
              //   this.currentItem.visible = this.item.visible;
              // }
              this.$Message.success('提交成功');
            } else {
              this.$Message.error('提交失败：' + res.data.message);
            }
          } catch (err) {
            this.$Message.error('提交失败：' + err.message);
          }
        } else {
          this.$Message.error('表单验证失败，请检查输入。');
        }
      });
    },
    cancel() {
      this.clear();
    },
    clear() {
      this.item = {
        id: 0,
        parent_id: 0,
        name: '',
        code: '',
        type: 0,
        order: 1,
        icon: '',
        route_fe: '',
        route_be: '',
        visible: 1
      };
      this.$refs.form.resetFields();
    }
  }
};
</script>

<style scoped>
.container {
  display: flex;
}
.tree {
  width: 200px;
  height: calc(100vh - 122px);
  background-color: white;
}
.content {
  margin-left: 10px;
  width: calc(100% - 210px);
  height: calc(100vh - 122px);
  background-color: white;
}
</style>