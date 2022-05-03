import * as Constants from "../common/Constants";
import * as MutationsName from "../common/MutationsName";
import ConnectServer from "../server/ConnectServer";

const RateCommand = {
  async findAll(page, size, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/rate?page=${page}&size=${size}&state=true`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null
        ? store.commit(
            MutationsName.MUTATION_NAME_SET_RATES,
            result.rates.reverse()
          )
        : null;
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_RATE, {
            page,
            totalPage: result.totalPage,
          })
        : null;
      return result.rates;
    }
    return null;
  },

  async findByProductId(page, size, productId, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/rate?page=${page}&size=${size}&productId=${productId}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null
        ? store.commit(
            MutationsName.MUTATION_NAME_SET_RATES,
            result.rates.reverse()
          )
        : null;
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_RATE, {
            page,
            totalPage: result.totalPage,
          })
        : null;
      return result.rates;
    }
    return null;
  },
};

export default RateCommand;
