import * as MutationsName from "../../components/common/MutationsName";

const CategoryModule = {
  state() {
    return {
      categories: null,
      category: null,
      sortCategory: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    categories(state) {
      return state.categories;
    },
    category(state) {
      return state.category;
    },
    sortCategory(state) {
      return state.sortCategory;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_CATEGORIES](state, categories) {
      state.categories = categories;
    },

    [MutationsName.MUTATION_NAME_SET_CATEGORY](state, category) {
      state.category = category;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_CATEGORY](state, sortCategory) {
      state.sortCategory = sortCategory;
    },
  },

  actions: {
  }
};

export default CategoryModule;
