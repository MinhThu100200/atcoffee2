import * as MutationsName from "../../components/common/MutationsName";

const RoleModule = {
  state() {
    return {
      roles: null,
      role: null
    };
  },

  getters: {
    roles(state) {
      return state.roles;
    },
    role(state) {
      return state.role;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_ROLES](state, roles) {
      state.roles = roles;
    },
    [MutationsName.MUTATION_NAME_SET_ROLE](state, role) {
      state.role = role;
    },
    [MutationsName.MUTATION_NAME_REMOVE_ROLE_BY_NAME](state, roleName) {
      state.roles = state.roles.filter(item => item.name != roleName);
    },
  },

  actions: {
  }
};

export default RoleModule;
