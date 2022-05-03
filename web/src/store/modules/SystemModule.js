// import UserEntity from "../../components/entities/userEntity";
import * as MutationsName from "../../components/common/MutationsName";
// import Jwt from "../../components/common/Jwt";
// import Login from "../../components/command/Login";

const SystemModule = {
  state() {
    return {
      miniSidebar: false,
      menu: {
        dashboard: {
          value: false
        },
        product: {
          value: false,
          submenu: {
            products: false,
            add_product: false,
          }
        },
        staff: {
          value: false,
          submenu: {
            staffs: false,
            add_staff: false
          }
        },
        store: {
          value: false
        },
        category: {
          value: false
        },
        promotion: {
          value: false
        },
        reward: {
          value: false
        },
        rate: {
          value: false
        },
        order_statistics: {
          value: false
        }, 
        staff_statistics: {
          value: false
        },
        profile: {
          value: false,
          submenu: {
            profile: false,
            change_password: false
          }
        }
      },
      menuStaff: {
        dashboard: {
          value: false,
          submenu: {
            general: false,
            ecommerce: false
          }
        },
        product: {
          value: false
        },
        payment: {
          value: false
        },
        order: {
          value: false,
        },
        notification: {
          value: false,
        },
        profile: {
          value: false,
          submenu: {
            profile: false,
            change_password: false
          }
        }
      }
    };
  },

  getters: {
    menu(state) {
      return state.menu;
    },
    menuStaff(state) {
      return state.menuStaff;
    },
    miniSidebar(state) {
      return state.miniSidebar;
    }
  },

  mutations: {
    [MutationsName.MUTATION_NAME_RESET_MENU] (state) {
      Object.keys(state.menu).forEach(key => {
        state.menu[key].value = false;
        if (state.menu[key].submenu != null) {
          Object.keys(state.menu[key].submenu).forEach(subkey => {
            state.menu[key].submenu[subkey] = false;
          })
        } 
      })
    },

    [MutationsName.MUTATION_NAME_RESET_MENU_STAFF] (state) {
      Object.keys(state.menuStaff).forEach(key => {
        state.menuStaff[key].value = false;
        if (state.menuStaff[key].submenu != null) {
          Object.keys(state.menuStaff[key].submenu).forEach(subkey => {
            state.menuStaff[key].submenu[subkey] = false;
          })
        } 
      })
    },

    [MutationsName.MUTATION_NAME_SET_MINI_SIDEBAR] (state, miniSidebar) {
      state.miniSidebar = miniSidebar;
    }
  },

  actions: {

  }
};

export default SystemModule;
