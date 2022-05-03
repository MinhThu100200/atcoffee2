import * as MutationsName from "../../components/common/MutationsName";

const PromotionModule = {
  state() {
    return {
      promotions: null,
      promotion: null,
      sortPromotion: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    promotions(state) {
      return state.promotions;
    },

    promotion(state) {
      return state.promotion;
    },

    sortPromotion(state) {
      return state.sortPromotion;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_PROMOTIONS](state, promotions) {
      state.promotions = promotions;
    },

    [MutationsName.MUTATION_NAME_SET_PROMOTION](state, promotion) {
      state.promotion = promotion;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_PROMOTION](state, sortPromotion) {
      state.sortPromotion = sortPromotion;
    }
  },

  actions: {
  }
};

export default PromotionModule;
