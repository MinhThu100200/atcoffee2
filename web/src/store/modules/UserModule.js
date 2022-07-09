import * as MutationsName from "../../components/common/MutationsName";
import Jwt from "../../components/common/Jwt";

const UserModule = {
  state() {
    return {
      user: null,
      users: null,
      tokens: [],
      sortUser: {
        page: '',
        store : '',
        role: '',
        state: '',
        keyword: '',
        totalPage: 0
      }
    };
  },

  getters: {
    user(state) {
      return state.user;
    },
    users(state) {
      return state.users;
    },
    sortUser(state) {
      return state.sortUser;
    },

    tokens(state) {
      return state.tokens;
    }
  },

  mutations: {
    [MutationsName.MUTATION_LOGIN](state, { user, jwt }) {
      Jwt.setJWT(jwt);
      state.user = user;
    },

    [MutationsName.MUTATION_NAME_SET_USER](state, user) {
      state.user = user;
    },

    [MutationsName.MUTATION_NAME_SET_USERS](state, users) {
      state.users = users;
    },

    [MutationsName.AUTHENTICATED](state, user) {
      state.user = user;
    },

    [MutationsName.MUTATION_NAME_LOGOUT](state) {
      state.user = null;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_USER](state, sortUser) {
      state.sortUser = sortUser;
    },

    [MutationsName.MUTATION_NAME_SET_TOKENS](state, tokens) {
      state.tokens = tokens;
    },
  },

};

export default UserModule;
