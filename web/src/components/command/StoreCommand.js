import ConnectServer from '../server/ConnectServer'
import * as Constants from '../common//Constants'
import * as MutationsName from '../common/MutationsName'

var StoreCommand = {

  async save(store) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/store`;
    let res = await ConnectServer.postData(url, store);
    return res != null ? res : null;
  },

  async findAll(store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/store`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_STORES, result) : null;
      return result;
    }
    return null;
  },

  async findAllByPagination(page, size, keyword, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/store?keyword=${keyword}&page=${page}&size=${size}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_STORES, result.stores) : null;
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_STORE, {page, totalPage: result.totalPage, keyword}) : null;
      return result.stores;
    }
    return null;
  },

  async findAllByOrder(page, size, keyword, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/store?keyword=${keyword}&page=${page}&size=${size}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_STORES, result.stores) : null;
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_STORE, {page, totalPage: result.totalPage, keyword}) : null;
      return result.stores;
    }
    return null;
  },

  async findOne(id, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/store/${id}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_STORE, result) : null;
      return result;
    }
    return null;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/store?code=${code}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_STORE, result) : null;
      return result;
    } 
    return null;
  }
}

export default StoreCommand;