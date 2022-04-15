<template>
  <div class="container">
    <div style="padding: 10px 20px;">
      <Button type="primary" icon="ios-add-circle-outline" @click="create(0)">新建模块</Button>
      <Button type="primary" icon="ios-add-circle-outline" style="margin-left: 8px;" @click="create(1)">新建菜单</Button>
      <Button type="primary" icon="ios-add-circle-outline" style="margin-left: 8px;" @click="create(2)">新建功能</Button>
    </div>
    <Table border highlight-row size="small" :height="height" row-key="id" :columns="columns" :data="items"
      @on-current-change="setCurrent">
      <template slot-scope="{ row, index }" slot="icon">
        <Icon :type="row.icon" />
      </template>
      <template slot-scope="{ row, index }" slot="updated_at">
        {{ new Date(row.updated_at).format('yyyy-MM-dd HH:mm:ss') }}
      </template>
      <template slot-scope="{ row, index }" slot="action">
        <Button type="success" @click="edit(row)">编辑</Button>
        <Button type="error" style="margin-left: 8px;" @click="remove(row, index)">删除</Button>
      </template>
    </Table>
    <Modal v-model="showDialog" :mask-closable="false" :title="getTitle()">
      <Form ref="form" :model="item" :rules="rules" :label-width="80" @submit.native.prevent>
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
      </Form>
      <div slot="footer">
        <Button type="primary" @click="save">保存</Button>
        <Button style="margin-left: 8px;" @click="cancel">取消</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
export default {
  name: 'Menu',
  data() {
    return {
      height: 200,
      columns: [{
        title: '名称',
        key: 'name',
        tree: true,
        width: 180,
      }, {
        title: '代码',
        key: 'code'
      }, {
        title: '排序',
        key: 'order',
        width: '80',
        align: 'center'
      }, {
        title: '图标',
        slot: 'icon',
        width: '80',
        align: 'center'
      }, {
        title: '更新时间',
        slot: 'updated_at',
        width: '152',
        align: 'center'
      }, {
        title: '更新人',
        key: 'updated_by',
        width: '120',
        align: 'center'
      }, {
        title: '操作',
        slot: 'action',
        width: '180',
        align: 'center'
      }],
      items: [],
      currentItem: undefined,
      showDialog: false,
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
    window.onresize = () => {
      this.fixSize();
    };
    this.fixSize();
    this.search();
  },
  methods: {
    fixSize() {
      this.height = Math.floor(document.body.getBoundingClientRect().height) - 174;
    },
    async search() {
      try {
        let res = await this.$http.post('/api/system/menu/list');
        if (res.data.success) {
          this.items = res.data.data;
        } else {
          this.$Message.error('加载失败：' + res.data.message);
        }
      } catch (err) {
        this.$Message.error('加载失败：' + err.message);
      }
    },
    setCurrent(currentRow, oldCurrentRow) {
      this.currentItem = currentRow;
    },
    getTitle() {
      let title = this.item.id > 0 ? '编辑' : '新建';
      if (this.item.type === 0) {
        title += '模块';
      } else if (this.item.type === 1) {
        title += '菜单';
      } else {
        title += '功能';
      }
      return title;
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
      this.showDialog = true;
    },
    edit(row) {
      this.item = {
        id: row.id,
        parent_id: row.parent_id,
        name: row.name,
        code: row.code,
        type: row.type,
        order: row.order,
        icon: row.icon,
        route_fe: row.route_fe,
        route_be: row.route_be,
        visible: row.visible
      };
      this.showDialog = true;
    },
    remove(row, index) {
      if (row.children.length > 0) {
        this.$Message.error('该项目存在子集，不能删除。');
        return;
      }
      this.$Modal.confirm({
        title: '提示',
        content: '确定要删除该项目吗？',
        onOk: async () => {
          try {
            let res = await this.$http.post('/api/system/delete', { id: row.id });
            if (res.data.success) {
              this.items.splice(index, 1);
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
              this.showDialog = false;
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
      this.$refs.form.resetFields();
      this.showDialog = false;
    }
  }
};
</script>

<style scoped>
.container {
  height: calc(100vh - 122px);
  background-color: white;
}
</style>