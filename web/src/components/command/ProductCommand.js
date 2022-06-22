import ConnectServer from "../server/ConnectServer";
import * as Constants from "../common/Constants";
import * as MutationsName from "../common/MutationsName";

var ProductCommand = {
  async saveProduct(product) {
    try {
      const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/product`;
      let res = await ConnectServer.postData(url, product);
      return res != null ? res : null;
    } catch (error) {
      return null;
    }
  },

  async updateState(product) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/admin/product/state`;
    let res = await ConnectServer.postData(url, product);
    return res != null ? res : null;
  },

  async findOne(id) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/product/${id}`;
    let res = await ConnectServer.getDataInfo(url);
    return res;
  },

  async findOneByCode(code, store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/product?code=${code}`;
    let res = await ConnectServer.getDataInfo(url);
    if (res != null) {
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_PRODUCTS, res)
        : "";
      return res;
    }
    return null;
  },

  async findAllIgnore(store = null) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/product/list`;
    let res = await ConnectServer.getData(url);
    if (res != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_PRODUCTS, res): "";
      return res;
    }
    return null;
  },

  async fineAll(page, size, store = null) {
    const url = `${
      Constants.HOSTNAME_DEFAULT
    }/api/info/product?page=${page}&size=${size}&store=${""}&category=${""}&keyword=${""}`;
    let res = await ConnectServer.getData(url);
    if (res != null) {
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_PRODUCTS, res.products)
        : "";
      store != null
        ? store.commit(
            MutationsName.MUTATION_NAME_SET_TOTAL_PAGE_PRODUCT,
            res.totalPage
          )
        : "";
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_CURRENT_PAGE_PRODUCT, 1)
        : "";
      return res.products;
    }
    return null;
  },

  async findAllByOrder(
    page,
    size,
    storeCode,
    categoryCode,
    keyword,
    store = null
  ) {
    storeCode = storeCode == null ? "" : storeCode;
    categoryCode = categoryCode == null ? "" : categoryCode;
    keyword = keyword == null ? "" : keyword;
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/product?page=${page}&size=${size}&store=${storeCode}&category=${categoryCode}&keyword=${keyword}`;
    let res = await ConnectServer.getData(url);
    if (res != null) {
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_PRODUCTS, res.products)
        : "";
      store != null
        ? store.commit(
            MutationsName.MUTATION_NAME_SET_TOTAL_PAGE_PRODUCT,
            res.totalPage
          )
        : "";
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_PRODUCT, {
            page,
            store: storeCode,
            category: categoryCode,
            keyword,
            totalPage: res.totalPage,
          })
        : "";
      return res.products;
    }
    return null;
  },

  async findAllByOrderIgnore(
    page,
    size,
    storeCode,
    categoryCode,
    keyword,
    store = null
  ) {
    storeCode = storeCode == null ? "" : storeCode;
    categoryCode = categoryCode == null ? "" : categoryCode;
    keyword = keyword == null ? "" : keyword;
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/product?page=${page}&size=${size}&store=${storeCode}&category=${categoryCode}&keyword=${keyword}`;
    let res = await ConnectServer.getData(url);
    if (res != null) {
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_PRODUCTS, res.products)
        : "";
      store != null
        ? store.commit(
            MutationsName.MUTATION_NAME_SET_TOTAL_PAGE_PRODUCT,
            res.totalPage
          )
        : "";
      store != null
        ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_PRODUCT, {
            page,
            store: storeCode,
            category: categoryCode,
            keyword,
            totalPage: res.totalPage,
          })
        : "";
      return res.products;
    }
    return null;
  },

  async countByCategoryCode(categoryCode) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/info/product/count?category=${categoryCode}`;
    let res = await ConnectServer.getData(url);
    return res;
  },
};

export default ProductCommand;
