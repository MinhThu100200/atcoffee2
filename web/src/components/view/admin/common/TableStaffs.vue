<template>
  <div class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Danh sách nhân viên</h4>
          <div class="card-header-form flex-row">
            <div class="form-group">
              <select v-model="storeSelected" class="form-custom" @change="handleChangeStore">
                <option value="ALL">Tất cả các cửa hàng</option>
                <option v-for="store in this.$store.getters.stores" :key="store.id"
                  :value="store.code">
                  {{store.address}}
                </option>
              </select>
            </div>
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="roleSelected" class="form-custom" @change="handleChangeRole">
                <option value="ALL">Tất cả các quyền</option>
                <option v-for="role in this.$store.getters.roles" :key="role.id"
                  :value="role.name">
                  {{role.name}}
                </option>
              </select>
            </div>
            <div class="empty-space"></div>
            <div class="form-group">
              <select v-model="stateSelected" class="form-custom" @change="handleChangeState">
                <option value="ALL">Tất cả trạng thái</option>
                <option value="active">Đang kích hoạt</option>
                <option value="lock">Đã khóa</option>
              </select>
            </div>
            <div class="empty-space"></div>
            <form @submit.prevent="handleSearch">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Tìm kiếm" v-model="keyword">
                <div class="input-group-btn">
                  <button class="btn btn-primary"><i class="fas fa-search"></i></button>
                </div>
              </div>
            </form>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-striped">
              <tbody>
                <tr>
                  <th class="text-center">SST</th>
                  <th class="text-center">Mã</th>
                  <th class="text-center">Tên</th>
                  <th class="text-center">Hình ảnh</th>
                  <th class="text-center">Email</th>
                  <th class="text-center">SDT</th>
                  <th class="text-center">CMND/CCCD</th>
                  <th class="text-center">Trạng thái</th>
                  <th class="text-center">Chi tiết</th>
                </tr>
                <tr v-for="(user, index) in users" :key="user.id">
                  <td class="text-center">{{number(index)}}</td>
                  <td class="text-center">{{user.code}}</td>
                  <td class="text-center">{{user.name}}</td>
                  <td class="text-center">
                    <img :src="user.image" alt="Ảnh" @click="handleViewImage(user.image)">
                  </td>
                  <td class="text-center">{{user.email}}</td>
                  <td class="text-center">{{user.phone}}</td>
                  <td class="text-center">{{user.identityCard}}</td>
                  <td class="text-center">
                    <i class="fas fa-circle" :class="user.state ? 'active' : 'inactive'"></i>
                  </td>
                  <td class="text-center">
                    <button class="btn btn-secondary" @click="handleInfo(user.id)">Chi tiết</button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="card-footer text-right" v-if="this.$store.getters.sortUser.totalPage > 1">
          <pagination :currentPage="currentPage" @handleChange="handleChangePage" :totalPage="this.$store.getters.sortUser.totalPage"/>
        </div>
      </div>
    </div>
    <view-image :isViewImage="isViewImage" :image="imageSelected" @handleHide="handleHideViewImage"></view-image>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import * as MutationsName from '../../../common/MutationsName'
import CommonUtils from '../../../common/CommonUtils'
import RoleCommand from '../../../command/RoleCommand'
import StoreCommand from '../../../command/StoreCommand'
import UserCommand from '../../../command/UserCommand'
import Pagination from '../../common/common/Pagination.vue'
import ViewImage from '../../common/popup/ViewImage.vue'

export default {
  name: Constants.COMPONENT_NAME_TABLE_STAFFS,

  components: {
    Pagination,
    ViewImage
  },

  data() {
    return {
      users: [],
      currentPage: 1,
      isViewImage: false,
      imageSelected: '',
      storeSelected: 'ALL',
      roleSelected: 'ALL',
      stateSelected: 'ALL',
      keyword: '',
    }
  },

  methods: {

    init(){
      this.currentPage = this.$route.query.page;
      if (typeof this.currentPage == 'undefined') {
        this.currentPage = 1;
      }
      this.keyword = this.$route.query.keyword;
      if (typeof this.keyword == 'undefined') {
        this.keyword = '';
      }
      this.storeSelected = this.$route.query.store;
      if (typeof this.storeSelected == 'undefined') {
        this.storeSelected = 'ALL';
      }
      this.roleSelected = this.$route.query.role;
      if (typeof this.roleSelected == 'undefined') {
        this.roleSelected = 'ALL';
      }
      this.stateSelected = this.$route.query.state;
      if (typeof this.stateSelected == 'undefined') {
        this.stateSelected = 'ALL';
      }
    },
    
    formatPrice(price) {
      return CommonUtils.formatPrice(price);
    },

    number(index){
      return (this.currentPage - 1) * Constants.PAGE_SIZE_STAFF + index + 1;
    },

    handleInfo(id){
      this.$router.push({path: '/admin/staff-info', query: {id}});
    },

    handleChangePage(page) {
      this.currentPage = page;
      const query = Object.assign({}, this.$route.query);
      this.$router.push({path: '/admin/staffs', query: {...query, page: this.currentPage}});
      this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    },

    handleViewImage(image) {
      this.isViewImage = true;
      this.imageSelected = image;
    },

    handleHideViewImage(){
      this.isViewImage = false;
    },

    handleSearch(){
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.keyword.trim() == '') {
        delete query.keyword;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/staffs', query: {...query, page: this.currentPage, keyword: this.keyword}});
      }
      this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    },

    handleChangeStore() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.storeSelected == 'ALL') {
        delete query.store;
        this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/staffs', query: {...query, page: this.currentPage, store: this.storeSelected}});
      }
      this.currentPage = 1;
      this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    }, 

    handleChangeRole() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.roleSelected == 'ALL') {
        delete query.role;
         this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/staffs', query: {...query, page: this.currentPage, role: this.roleSelected}});
      }
      this.currentPage = 1;
      this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    },  

    handleChangeState() {
      const query = Object.assign({}, this.$route.query);
      this.currentPage = 1;
      if (this.stateSelected == 'ALL') {
        delete query.state;
         this.$router.replace({ query });
      } else {
        this.$router.push({path: '/admin/staffs', query: {...query, page: this.currentPage, state: this.stateSelected}});
      }
      this.currentPage = 1;
      this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
    },

    async loadData() {
      await this.loadRoles();
      await this.loadStores();
    },

    async loadStaffsBySort(page, size) {
      var store = this.storeSelected == 'ALL' ? '' : this.storeSelected;
      var role = this.roleSelected == 'ALL' ? '' : this.roleSelected;
      var state = this.stateSelected == 'ALL' ? '' : this.stateSelected == 'active';
      var keyword = this.keyword;
      this.users = await UserCommand.findAllByOrder(page, size, store, role, state, keyword, this.$store);
    },

    async loadRoles() {
      let result = await RoleCommand.findAll(this.$store);
      var roles = result.map(role => {
        role.selected = false;
        return role;
      });
      this.$store.commit(MutationsName.MUTATION_NAME_REMOVE_ROLE_BY_NAME, Constants.ROLE.ROLE_USER);
      roles = roles.filter(role => role.name != Constants.ROLE.ROLE_USER);
      return roles;
    },
    
    async loadStores() {
      let result = await StoreCommand.findAll(this.$store);
      var stores = result.map(store => {
        store.selected = false;
        return store;
      });
      return stores;
    },
  },

  created(){
    this.init();
    this.loadData();
    this.loadStaffsBySort(this.currentPage, Constants.PAGE_SIZE_STAFF);
  }
}
</script>

<style>

.row {
  display: flex;
  flex-wrap: wrap;
  margin-right: -15px;
  margin-left: -15px;
}

.card {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
  background-color: #fff;
  border-radius: 3px;
  border: none !important;
  position: relative;
  margin-bottom: 30px;
}

.card .card-header {
  border-bottom-color: #f9f9f9;
  line-height: 30px;
  align-self: center;
  width: 100%;
  min-height: 70px;
  padding: 15px 25px;
  display: flex;
  align-items: center;
  background: transparent;
}

.card .card-header h4 {
  font-size: 16px;
  line-height: 28px;
  color: var(--primary);
  padding-right: 10px;
  margin-bottom: 0;
  font-weight: 700;
  margin-top: 0;
  border-radius: 30px 0 0 30px !important;
}

.card .card-header .card-header-form {
  margin-left: auto;
}

.input-group {
  position: relative;
  display: flex;
  flex-wrap: wrap;
  align-items: stretch;
  width: 100%;
}

.card .card-header .card-header-form .input-group .form-control {
  border-radius: 30px 0 0 30px !important;
}

.card .card-header .form-control {
  height: 31px;
  font-size: 13px;
}

.form-control:not(.form-control-sm):not(.form-control-lg) {
  padding: 10px 15px;
}

.input-group .form-control {
  position: relative;
  flex: 1 1 auto;
  width: 1%;
  margin-bottom: 0;
}

.input-group .form-control:focus {
  border-radius: 1px;
  box-shadow: none;
  border-color: var(--primary);
}

.form-control { 
  background: #fdfdfd;
  border-color: #e4e6fc;
  display: block;
  font-weight: 400;
  line-height: 1.5;
  color: #495057;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

input {
  overflow: visible;
}

.input-group .btn {
  border-radius: 0 30px 30px 0 !important;
  font-weight: 600;
  line-height: 25px;
  letter-spacing: .5px;
  margin-top: -1px;
  padding: 2px 15px;
}

.card-header-form .btn {
  padding-left: 13px !important;
  padding-right: 13px !important;
}

.btn-primary {
  background: #7EBDA2 !important;
  box-shadow: 0 2px 6px var(--lightGreen2) !important;
  border-color: #7EBDA2 !important;
  color: #fff;
}


.btn-primary:hover{
  background-color: var(--primary) !important;
  box-shadow: 0 2px 6px var(--lightGreen2) !important;
  border-color: var(--primary) !important;
}

.card .card-body {
  background: transparent;
}

.table-reponsive {
  display: block;
  width: 100%;
}

.table {
  width: 100%;
  color: inherit;
  margin-bottom: 1rem;
}

.table tr td img {
  height: 44px;
  width: 44px;
  border-radius: 3px;
  cursor: pointer;
}

table {
  border-collapse:collapse;
}

.table-striped tbody tr:nth-of-type(2n+1) {
  --bs-table-accent-bg: rgba(0, 0, 0, 0.03);
}

.table td, .table:not(.table-bordered) th {
  border-top: none;
}

.table:not(.table-sm):not(.table-md):not(.dataTable) td, .table:not(.table-sm):not(.table-md):not(.dataTable) th {
  padding: 0 25px;
  height: 60px;
  vertical-align: middle;
}

th {
  text-align: center;
}

th, tr, td {
  border: 1px solid #f6f6f6;
}

.card .card-footer {
  background: transparent;
  border: none;
  padding: 20px 25px;
  width: 100%;
  text-align: right;
}

ul {
  margin-top: 0;
}

ul:not(.list-unstyled) {
  line-height: 28px;
}

.flex-row {
  display: flex;
  flex-direction: row !important;
  flex-wrap: wrap;
}

select.form-custom {
  height: 32px;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 2px 15px;
  font-size: 13px;
}

select.form-custom option {
  height: 32px;
  padding: 4px 15px;
}

.empty-space {
  width: 20px;
}

.fas.fa-circle {
  font-size: 16px;
}

.fa-circle.active {
  color: #5ad539;
}

.fa-circle.inactive {
  color: #ccc;
}
</style>