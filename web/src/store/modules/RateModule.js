import * as MutationsName from "../../components/common/MutationsName";

const RateModule = {
  state() {
    return {
      rates: null,
      rate: null,
      sortRate: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    rates(state) {
      return state.rates;
    },

    rate(state) {
      return state.rate;
    },

    sortRate(state) {
      return state.sortRate;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_RATES](state, rates) {
      state.rates = rates;
    },

    [MutationsName.MUTATION_NAME_SET_RATE](state, rate) {
      state.rate = rate;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_RATE](state, sortRate) {
      state.sortRate = sortRate;
    }
  },

  actions: {
  }
};

export default RateModule;
