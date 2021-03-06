import { createRouter, createWebHistory } from "vue-router";

import Login from '../components/view/common/login/Login.vue'
import ForgotPassword from '../components/view/common/login/ForgotPassword.vue'
/**Admin Components */
import DashBoard from '../components/view/admin/dashboard/Dashboard.vue'
import Statistics from '../components/view/admin/statistics/Statistics'
import Products from '../components/view/admin/product/Products.vue'
import AddProduct from '../components/view/admin/product/AddProduct.vue'
import ProductInfo from '../components/view/admin/product/ProductInfo.vue'
import Staffs from '../components/view/admin/staff/Staffs.vue'
import AddStaff from '../components/view/admin/staff/AddStaff.vue'
import StaffInfo from '../components/view/admin/staff/StaffInfo.vue'
import Stores from '../components/view/admin/store/Stores.vue'
import StoreInfo from '../components/view/admin/store/StoreInfo'
import Categories from '../components/view/admin/category/Categories.vue'
import CategoryInfo from '../components/view/admin/category/CategoryInfo.vue'
import Promotions from '../components/view/admin/promotion/Promotions.vue'
import PromotionInfo from '../components/view/admin/promotion/PromotionInfo.vue'
import Rewards from '../components/view/admin/reward/Rewards.vue'
import RewardInfo from '../components/view/admin/reward/RewardInfo.vue'
import Rates from '../components/view/admin/rate/Rates.vue'
/**Statistics */
import OrderStatistics from '../components/view/admin/statistics/OrderStatistics.vue'
import OrderInfoStatistics from '../components/view/admin/statistics/OrderInfoStatistics.vue'
import StaffStatistics from '../components/view/admin/statistics/StaffStatistics.vue'

import Profile from '../components/view/admin/profile/Profile.vue'
import ChangePassword from '../components/view/admin/profile/ChangePassword.vue'
import Error from '../components/view/admin/error/Error.vue'
/**Staff Components */
import DashBoardStaff from '../components/view/staff/dashboard/Dashboard.vue'
import ProductsStaff from '../components/view/staff/product/Products.vue'
import PaymentStaff from '../components/view/staff/payment/Payment.vue'
import OrdersStaff from '../components/view/staff/order/Orders.vue'
import OrderInfoStaff from '../components/view/staff/order/OrderInfo.vue'
import NotificationsStaff from '../components/view/staff/notification/Notifications.vue'
import SendNotificationStaff from '../components/view/staff/notification/SendNotification.vue'
import AddNotificationStaff from '../components/view/staff/notification/AddNotification.vue'
import NotificationInfoStaff from '../components/view/staff/notification/NotificationInfo.vue'
import ProfileStaff from '../components/view/staff/profile/Profile.vue'
import ChangePasswordStaff from '../components/view/staff/profile/ChangePassword.vue'

/** User Components */
// import DashBoardUser from '../components/view/user/dashboard/Dashboard.vue'
import ProductUser from '../components/view/user/product/Product.vue'

const routes = [
  {path: '/', component: Login, meta: {title: 'A&T Coffee | ????ng nh???p'}},
  {path: '/login', component: Login, meta: {title: 'A&T Coffee | ????ng nh???p'}},
  {path: '/forgot-password', component: ForgotPassword, meta: {title: 'A&T Coffee | Qu??n m???t kh???u'}},
  /**Admin URL */
  {path: '/admin', name: 'admin', component: DashBoard, meta: {title: 'A&T Coffee | Trang ch???'}},
  {path: '/admin/statistics', name: 'statistics', component: Statistics, meta: {title: 'A&T Coffee | Th???ng k??'}},
  {path: '/admin/products', name: 'products', component: Products, meta: {title: 'A&T Coffee | Danh s??ch s???n ph???m'}},
  {path: '/admin/add-product', name: 'add-product', component: AddProduct, meta: {title: 'A&T Coffee | Th??m s???n ph???m'}},
  {path: '/admin/product-info', name: 'product-info', component: ProductInfo, meta: {title: 'A&T Coffee | Th??ng tin s???n ph???m'}},
  {path: '/admin/edit-product', name: 'edit-product', component: AddProduct, meta: {title: 'A&T Coffee | Ch???nh s???a s???n ph???m'}},
  {path: '/admin/staffs', name: 'staffs', component: Staffs, meta: {title: 'A&T Coffee | Danh s??ch nh??n vi??n'}},
  {path: '/admin/add-staff', name: 'add-staff', component: AddStaff, meta: {title: 'A&T Coffee | Th??m nh??n vi??n'}},
  {path: '/admin/edit-staff', name: 'edit-staff', component: AddStaff, meta: {title: 'A&T Coffee | Ch???nh s???a nh??n vi??n'}},
  {path: '/admin/staff-info', name: 'staff-info', component: StaffInfo, meta: {title: 'A&T Coffee | Th??ng tin nh??n vi??n'}},
  {path: '/admin/stores', name: 'stores', component: Stores, meta: {title: 'A&T Coffee | Danh s??ch c???a h??ng'}},
  {path: '/admin/store-info', name: 'store-info', component: StoreInfo, meta: {title: 'A&T Coffee | Th??ng tin c???a h??ng'}},
  {path: '/admin/categories', name: 'categories', component: Categories, meta: {title: 'A&T Coffee | Danh s??ch lo???i s???n ph???m'}},
  {path: '/admin/category-info', name: 'category-info', component: CategoryInfo, meta: {title: 'A&T Coffee | Th??ng tin lo???i s???n ph???m'}},
  {path: '/admin/promotions', name: 'promotions', component: Promotions, meta: {title: 'A&T Coffee | Danh s??ch khuy???n m??i'}},
  {path: '/admin/promotion-info', name: 'promotion-info', component: PromotionInfo, meta: {title: 'A&T Coffee | Th??ng tin khuy???n m??i'}},
  {path: '/admin/rewards', name: 'rewards', component: Rewards, meta: {title: 'A&T Coffee | Danh s??ch ph???n th?????ng'}},
  {path: '/admin/reward-info', name: 'reward-info', component: RewardInfo, meta: {title: 'A&T Coffee | Th??ng tin ph???n th?????ng'}},
  {path: '/admin/rates', name: 'rates', component: Rates, meta: {title: 'A&T Coffee | Danh s??ch ????nh gi??'}},

  /**Statistics */
  {path: '/admin/statistics/orders', name: 'order-statistics', component: OrderStatistics, meta: {title: 'A&T Coffee | Th???ng k?? ????n h??ng'}},
  {path: '/admin/statistics/order-info', name: 'order-info-statistics', component: OrderInfoStatistics, meta: {title: 'A&T Coffee | Chi ti???t ????n h??ng'}},
  {path: '/admin/statistics/staffs', name: 'staff-statistics', component: StaffStatistics, meta: {title: 'A&T Coffee | Th???ng k?? nh??n vi??n'}},
  // {path: '/admin/statistics/order-info', name: 'order-info-statistics', component: OrderInfoStatistics, meta: {title: 'A&T Coffee | Chi ti???t ????n h??ng'}},

  {path: '/admin/profile', name: 'profile', component: Profile, meta: {title: 'A&T Coffee | Th??ng tin c?? nh??n'}},
  {path: '/admin/profile/change-password', name: 'change-password', component: ChangePassword, meta: {title: 'A&T Coffee | ?????i m???t kh???u'}},
  /**Staff URL */
  {path: '/staff', name: 'dashboard-staff', component: DashBoardStaff, meta: {title: 'A&T Coffee | Trang ch???'}},
  {path: '/staff/products', name: 'products-staff', component: ProductsStaff, meta: {title: 'A&T Coffee | Danh s??ch s???n ph???m'}},
  {path: '/staff/payment', name: 'payment-staff', component: PaymentStaff, meta: {title: 'A&T Coffee | Thanh to??n'}},
  {path: '/staff/orders', name: 'orders-staff', component: OrdersStaff, meta: {title: 'A&T Coffee | ????n h??ng'}},
  {path: '/staff/order-info', name: 'order-info-staff', component: OrderInfoStaff, meta: {title: 'A&T Coffee | Chi ti???t ????n h??ng'}},
  {path: '/staff/notifications', name: 'notification-staff', component: NotificationsStaff, meta: {title: 'A&T Coffee | Danh s??ch th??ng b??o'}},
  {path: '/staff/send-notifications', name: 'send-notification-staff', component: SendNotificationStaff, meta: {title: 'A&T Coffee | G???i th??ng b??o'}},
  {path: '/staff/add-notification', name: 'add-notification-staff', component: AddNotificationStaff, meta: {title: 'A&T Coffee | T???o th??ng b??o'}},
  {path: '/staff/notification-info', name: 'notification-info-staff', component: NotificationInfoStaff, meta: {title: 'A&T Coffee | Th??ng tin th??ng b??o'}},
  {path: '/staff/profile', name: 'profile-staff', component: ProfileStaff, meta: {title: 'A&T Coffee | Th??ng tin c?? nh??n'}},
  {path: '/staff/profile/change-password', name: 'change-password-staff', component: ChangePasswordStaff, meta: {title: 'A&T Coffee | ?????i m???t kh???u'}},

  /** User URL */
  // {path: '/', name: 'dashboard-user', component: DashBoardUser, meta: {title: 'A&T Coffee | Trang ch???'}},
  {path: '/product', name: 'product-user', component: ProductUser, meta: {title: 'A&T Coffee | Th??ng tin s???n ph???m'}},


  {path: '/:pathMatch(.*)', component: Error, meta: {title: 'A&T Coffee | L???i'}},
  
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  document.title = to.meta.title
  next()
});

export default router;