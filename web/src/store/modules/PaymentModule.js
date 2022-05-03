import * as MutationsName from '../../components/common/MutationsName'

const TypeModule = {

  state() {
    return {
      payments: [],
      payment: {}
    }
  },

  getters: {

    payments(state) {
      return state.payments;
    },

    payment(state) {
      return state.payment;
    }
  },

  mutations: {

    [MutationsName.MUTATION_NAME_SET_PAYMENTS](state, payments) {
      state.payments = payments;
    },

    [MutationsName.MUTATION_NAME_SET_PAYMENT](state, payment) {
      state.payment = payment;
    }
  },

  actions: {

  }
}

export default TypeModule;