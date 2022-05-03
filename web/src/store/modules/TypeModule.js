import * as MutationsName from '../../components/common/MutationsName'

const TypeModule = {

  state() {
    return {
      types: [],
      type: {}
    }
  },

  getters: {

    types(state) {
      return state.types;
    },

    type(state) {
      return state.type;
    }
  },

  mutations: {

    [MutationsName.MUTATION_NAME_SET_TYPES](state, types) {
      state.types = types;
    },

    [MutationsName.MUTATION_NAME_SET_TYPE](state, type) {
      state.type = type;
    }
  },

  actions: {

  }
}

export default TypeModule;