<template>
  <div>
    <nav class="d-inline-block">
      <ul class="pagination mb-0">
         <li class="page-item" :class="currentPage == 1 ? 'disable' : ''">
          <router-link to="" @click.prevent="handleChangePage('DOUBLE_LEFT')" class="page-link"><i class="fas fa-angle-double-left"></i></router-link>
        </li>
        <li class="page-item" :class="currentPage == 1 ? 'disable' : ''">
          <router-link to="" @click.prevent="handleChangePage('LEFT')"
          class="page-link"><i class="fas fa-angle-left"></i></router-link>
        </li>
        <li class="page-item" v-for="pagination in itemsPagination" :key="pagination"
          :class="pagination == currentPage ? 'active' : ''">
          <router-link to="" @click.prevent="handleChangePage(pagination)"
          class="page-link">{{pagination}}</router-link>
        </li>
        <li class="page-item" :class="currentPage == totalPage ? 'disable' : ''">
          <router-link to="" @click.prevent="handleChangePage('RIGHT')"
          class="page-link"><i class="fas fa-angle-right"></i></router-link>
        </li>
        <li class="page-item" :class="currentPage == totalPage ? 'disable' : ''">
          <router-link to="" @click.prevent="handleChangePage('DOUBLE_RIGHT')"
          class="page-link"><i class="fas fa-angle-double-right"></i></router-link>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'

export default {
  name: Constants.COMPONENT_NAME_PAGINATION,

  props: ['currentPage', 'totalPage'],

  computed: {
    itemsPagination() {
      var result = [];
      var len = this.totalPage < Constants.ITEM_NUMBER_PAGINATION ? this.totalPage : Constants.ITEM_NUMBER_PAGINATION;
      if (this.currentPage <= Math.ceil(Constants.ITEM_NUMBER_PAGINATION / 2)) {
        for (let i = 0; i < len; i++) {
          result.push(i + 1);
        }
      } else if (this.currentPage > this.totalPage - Math.ceil(Constants.ITEM_NUMBER_PAGINATION / 2)){
        for (let i = this.totalPage; i > this.totalPage - len; i--) {
          result.unshift(i);
        }
      } else {
        var start = this.currentPage - Math.floor(Constants.ITEM_NUMBER_PAGINATION / 2);
        var end = this.currentPage + Math.floor(Constants.ITEM_NUMBER_PAGINATION / 2);
        for (let i = start; i <= end; i++) {
          result.push(i);
        }
      }
      return result;
    },
  },
  methods: {
    handleChangePage(type) {
      var page = this.currentPage;
      switch(type) {
        case 'DOUBLE_LEFT':
          page = 1;
          break;
        case 'LEFT':
          page -= page > 1 ? 1 : 0;
          break;
        case 'RIGHT':
          page += page < this.totalPage ? 1 : 0;
          break;
        case 'DOUBLE_RIGHT': 
          page = this.totalPage;
          break;
        default: 
          page = type;
      }
      this.$emit('handleChange', page);
    }
  }
}
</script>

<style>
.pagination {
  display: flex;
  padding-left: 0;
  list-style: none;
  border-radius: .25rem;
}

.page-item .page-link {
  border-color: transparent;
  background: #f9fafe;
  color: var(--primary);
  opacity: 0.9;
  border-radius: 3px;
  margin: 0 3px;
}

.page-link {
  font-weight: 600;
  position: relative;
  display: block;
  padding: .5rem .75rem;
  line-height: 1.25;
  border: 1px solid #dee2e6;
}

.page-item a {
  text-decoration: none !important;
}

.page-item.disable .page-link:hover {
  border-color: transparent !important;
  background: #f9fafe !important;
  color: var(--primary) !important;
  cursor:default;
}

.page-item.active .page-link {
  background: var(--primary) !important;
  border-color: var(--primary) !important;
  z-index: 1;
  color: #fff;
}

.page-item .page-link:hover {
  background: var(--primary) !important;
  border-color: var(--primary) !important;
  z-index: 1;
  color: #fff;
}
</style>