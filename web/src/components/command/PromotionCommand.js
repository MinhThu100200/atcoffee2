import ConnectServer from '../server/ConnectServer'
import * as Constants from '../common/Constants'
import * as MutationsName from '../common/MutationsName'

const PromotionCommand = {

  async save(promotion, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/promotion`;
    let result = await ConnectServer.postData(url, promotion);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION, result) : '';
    return result;
  },

  async findAll(store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/promotion?list=true`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PROMOTIONS, result) : '';
    return result;
  },

  async findOne(id, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/promotion/${id}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION, result) : '';
    return result;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/promotion?code=${code}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PROMOTION, result) : '';
    return result;
  },

  async findAllByOrder(page, size, state, object, keyword, store) {
    const url =  `${Constants.HOSTNAME_DEFAULT}/api/info/promotion?page=${page}&size=${size}&state=${state}&object=${object}&keyword=${keyword}`;
    let res = await ConnectServer.getData(url);
    if (res != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PROMOTIONS, res.promotions) : '';
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_PROMOTION, {page, state, object, keyword, totalPage: res.totalPage}) : '';
      return res.products;
    }
    return null;
  }
}

export default PromotionCommand;