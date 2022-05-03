import ConnectServer from '../server/ConnectServer'
import * as Constants from '../common/Constants'
import * as MutationsName from '../common/MutationsName'

var CategoryCommand = {

  async save(category) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/category`;
    let res = await ConnectServer.postData(url, category);
    return res != null ? res : null;
  },

  async findAll(store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/category?list`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_CATEGORIES, result) : '';
      return result;
    }
    return null;
  },

  async findAllByPagination(page, size, keyword, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/category?keyword=${keyword}&page=${page}&size=${size}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_CATEGORIES, result.categories) : '';
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_CATEGORY, {page, totalPage: result.totalPage, keyword}) : '';
      return result;
    }
    return null;
  },

  async findAllByOrder(page, size, keyword, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/category?keyword=${keyword}&page=${page}&size=${size}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_CATEGORIES, result.categories) : '';
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_CATEGORY, {page, totalPage: result.totalPage, keyword}) : '';
      return result;
    }
    return null;
  },

  async findOne(id, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/category/${id}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_CATEGORY, result) : null;
      return result;
    }
    return null;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/category?code=${code}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_CATEGORY, result) : null;
      return result;
    } 
    return null;
  }
}

export default CategoryCommand;