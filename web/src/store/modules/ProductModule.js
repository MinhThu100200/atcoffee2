import * as MutationsName from "../../components/common/MutationsName";

const ProductModule = {
  state() {
    return {
      product: null,
      products: null,
      totalPageProduct: 0,
      currentPageProduct: 1,
      sortProduct: {
        page: '',
        store : '',
        category: '',
        keyword: '',
        totalPage: ''
      }
    };
  },

  getters: {
    product(state) {
      return state.product;
    },
    products(state) {
      return state.products;
    },
    totalPageProduct(state) {
      return state.totalPageProduct;
    },
    currentPageProduct(state) {
      return state.currentPageProduct;
    },
    sortProduct(state) {
      return state.sortProduct;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_PRODUCTS](state, products) {
      state.products = products;
    },

    [MutationsName.MUTATION_NAME_SET_TOTAL_PAGE_PRODUCT](state, totalPageProduct) {
      state.totalPageProduct = totalPageProduct;
    },

    [MutationsName.MUTATION_NAME_SET_CURRENT_PAGE_PRODUCT](state, currentPageProduct) {
      state.currentPageProduct = currentPageProduct;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_PRODUCT](state, sortProduct) {
      state.sortProduct = sortProduct;
    },
  }
};

export default ProductModule;
