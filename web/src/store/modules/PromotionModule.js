import * as MutationsName from "../../components/common/MutationsName";

const PromotionModule = {
  state() {
    return {
      promotions: null,
      promotion: null,
      promotionsSearch: [],
      promotionKeySearch: '',
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

    promotionsSearch(state) {
      return state.promotions
        .filter(item => item.endDate >= (new Date().getTime()))
        .filter(item => item.code.includes(state.promotionKeySearch.toUpperCase()));
    },

    promotion(state) {
      return state.promotion;
    },

    sortPromotion(state) {
      return state.sortPromotion;
    },

    promotionKeySearch(state) {
      return state.promotionKeySearch;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_PROMOTIONS](state, promotions) {
      state.promotions = promotions;
    },

    [MutationsName.MUTATION_NAME_SET_PROMOTIONS_SEARCH](state, promotionsSearch) {
      state.promotionsSearch = promotionsSearch;
    },

    [MutationsName.MUTATION_NAME_SET_PROMOTION](state, promotion) {
      state.promotion = promotion;
    },

    [MutationsName.MUTATION_NAME_SET_PROMOTION_KEY_SEARCH](state, promotionKeySearch) {
      state.promotionKeySearch = promotionKeySearch;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_PROMOTION](state, sortPromotion) {
      state.sortPromotion = sortPromotion;
    }
  },

  actions: {
  }
};

export default PromotionModule;
