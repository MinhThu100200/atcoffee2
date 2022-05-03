import ConnectServer from "../server/ConnectServer";
import * as Constants from '../common/Constants'
import * as MutationsName from '../common/MutationsName'

const PaymentCommand = {

  async findAll(store = null) {

    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/payment`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PAYMENTS, result) : '';
    return result;
  },

  async findOne(id, store = null) {

    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/payment/${id}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PAYMENT, result) : '';
    return result;
  }
}

export default PaymentCommand;