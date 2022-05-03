import * as Constants from '../common/Constants'
import * as MutationsName from '../common/MutationsName'
import ConnectServer from '../server/ConnectServer'

const RewardCommand = {

  async findByOrder(page, size, keyword, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/reward?keyword=${keyword}&page=${page}&size=${size}&state=true`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_REWARDS, result.rewards) : null;
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_REWARD, {page, totalPage: result.totalPage, keyword}) : null;
      return result.rewards;
    }
    return null;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/reward?code=${code}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_REWARD, result) : null;
      return result;
    }
    return null;
  },

  async findOne(id, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/reward/${id}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_REWARD, result) : null;
      return result;
    }
    return null;
  },

  async save(reward, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/reward`;
    let result = await ConnectServer.postData(url, reward);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_REWARD, result) : null;
      return result;
    }
    return null;
  },

  async update(reward, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/reward`;
    let result = await ConnectServer.putData(url, reward);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_REWARD, result) : null;
      return result;
    }
    return null;
  }
}

export default RewardCommand;