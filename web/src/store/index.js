import { createStore } from "vuex";
import createPersistedState from "vuex-persistedstate";

//Import modules
import UserModule from './modules/UserModule';
import SystemModule from './modules/SystemModule'
import CategoryModule from './modules/CategoryModule'
import StoreModule from "./modules/StoreModule";
import PromotionModule from "./modules/PromotionModule";
import RewardModule from "./modules/RewardModule";
import RateModule from "./modules/RateModule";
import RoleModule from "./modules/RoleModule";
import ProductModule from './modules/ProductModule'
import BillModule from "./modules/BillModule";
import CartModule from "./modules/CartModule";
import TypeModule from "./modules/TypeModule";
import PaymentModule from "./modules/PaymentModule"
import NotificationModule from "./modules/NotificationModule";

const store = createStore({
  plugins: [createPersistedState()],
  modules: {
    UserModule,
    SystemModule,
    CategoryModule,
    StoreModule,
    PromotionModule,
    RewardModule,
    RateModule,
    RoleModule,
    ProductModule,
    BillModule,
    CartModule,
    TypeModule,
    PaymentModule,
    NotificationModule
  },
});

export default store;
