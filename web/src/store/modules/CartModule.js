import * as MutationsName from "../../components/common/MutationsName";

const CartModule = {
  state() {
    return {
      carts: [],
      cart: {}
    };
  },

  getters: {
    carts(state) {
      return state.carts;
    },

    cart(state) {
      return state.cart;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_CARTS](state, carts) {
      state.carts = carts;
    },

    [MutationsName.MUTATION_NAME_SET_CART](state, cart) {
      state.cart = cart;
    },

    [MutationsName.MUTATION_NAME_ADD_CART](state, cart) {
      let cartFind = state.carts.find(item => item.productId == cart.productId && item.size == cart.size);
      if (cartFind == null) {
        state.carts.push(cart);
      } else {
        state.carts = state.carts.map(item => {
          if (item.productId == cart.productId && item.size == cart.size) {
            item.quantity += cart.quantity;
            item.amount = item.price * item.quantity * (1 - item.discount / 100);
          }
          return item;
        });
      }
    },

    [MutationsName.MUTATION_NAME_UPDATE_CART](state, {preCart, nextCart}) {
      if (preCart.size == nextCart.size) {
        nextCart.amount = nextCart.price * nextCart.quantity * (1 - nextCart.discount / 100);
        state.carts = state.carts.map(item => {
          if (item.productId == nextCart.productId && item.size == nextCart.size) {
            item = nextCart;
          }
          return item;
        })
      } else {
        var index = state.carts.findIndex(item => item.productId == preCart.productId && item.size == preCart.size);
        var indexExist = state.carts.findIndex(item => item.productId == nextCart.productId && item.size == nextCart.size);
        if (indexExist >= 0) {
          state.carts[indexExist].quantity += nextCart.quantity;
          state.carts[indexExist].amount = state.carts[indexExist].price * state.carts[indexExist].quantity * (1 - state.carts[indexExist].discount / 100);
          state.carts.splice(index, 1);
        } else {
          state.carts[index] = nextCart;
        }
      }

    },

    [MutationsName.MUTATION_NAME_REMOVE_CART](state, cart) {
      state.carts = state.carts.filter(item => item.productId != cart.productId || item.size != cart.size);
    }
  },
};

export default CartModule;
