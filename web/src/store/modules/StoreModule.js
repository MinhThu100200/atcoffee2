import * as MutationsName from "../../components/common/MutationsName";

const StoreModule = {
  state() {
    return {
      stores: null,
      store: null,
      sortStore: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    stores(state) {
      return state.stores;
    },

    store(state) {
      return state.store;
    },

    sortStore(state) {
      return state.sortStore;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_STORES](state, stores) {
      state.stores = stores;
    },

    [MutationsName.MUTATION_NAME_SET_STORE](state, store) {
      state.store = store;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_STORE](state, sortStore) {
      state.sortStore = sortStore;
    },
  },

  actions: {
  }
};

export default StoreModule;
