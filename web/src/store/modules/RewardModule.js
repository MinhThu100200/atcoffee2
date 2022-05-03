import * as MutationsName from "../../components/common/MutationsName";

const RewardModule = {
  state() {
    return {
      rewards: null,
      reward: null,
      sortReward: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    rewards(state) {
      return state.rewards;
    },

    reward(state) {
      return state.reward;
    },

    sortReward(state) {
      return state.sortReward;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_REWARDS](state, rewards) {
      state.rewards = rewards;
    },

    [MutationsName.MUTATION_NAME_SET_REWARD](state, reward) {
      state.reward = reward;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_REWARD](state, sortReward) {
      state.sortReward = sortReward;
    }
  },

  actions: {
  }
};

export default RewardModule;
