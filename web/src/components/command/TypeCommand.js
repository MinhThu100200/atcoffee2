import ConnectServer from "../server/ConnectServer";
import * as Constants from '../common/Constants'
import * as MutationsName from '../common/MutationsName'

const TypeCommand = {

  async findAll(store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/type`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_TYPES, result) : '';
    return result;
  },

  async findOne(id, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/type/${id}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_TYPE, result) : '';
    return result;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/type?code=${code}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_TYPE, result) : '';
    return result;
  }
}

export default TypeCommand;