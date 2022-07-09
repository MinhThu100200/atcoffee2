import * as MutationsName from "../../components/common/MutationsName";

const NotificationModule = {
  state() {
    return {
      notifications: null,
      notification: null,
      sortNotification: {
        page: 1,
        totalPage: 0
      }
    };
  },

  getters: {
    notifications(state) {
      return state.notifications;
    },

    notification(state) {
      return state.notification;
    },

    sortNotification(state) {
      return state.sortNotification;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_SET_NOTIFICATIONS](state, notifications) {
      state.notifications = notifications;
    },

    [MutationsName.MUTATION_NAME_SET_NOTIFICATION](state, notification) {
      state.notification = notification;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION](state, sortNotification) {
      state.sortNotification = sortNotification;
    },
  },

};

export default NotificationModule;
