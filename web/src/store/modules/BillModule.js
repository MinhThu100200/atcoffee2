import * as MutationsName from "../../components/common/MutationsName";
import * as Constants from '../../components/common/Constants'
import CommonUtils from '../../components/common/CommonUtils'

const BillModule = {

  state() {
    return {
      billsNotification: null,
      bills: [],
      billsLocal: [],
      bill: null,
      sortBill: {
        page: 1,
        totalPage: 0,
        status: 'PAID',
        type: '',
        keyword: '',
        start: '',
        end: '',
        selectedDate: '',
        storeId: null
      },
      billCurrentPage: 1
    };
  },

  getters: {

    bills(state) {
      return state.bills;
    },

    bill(state) {
      return state.bill;
    },

    billsLocal(state) {
      return state.billsLocal;
    },

    billsSortByCode(state) {
      return state.bills.sort((a, b) => {
        if (a.code > b.code) {
          return 1;
        } else if (a.code < b.code) {
          return -1;
        }
        return 0;
      });
    },

    billsUnread(state) {
      return state.bills != null ? state.bills.filter(bill => !bill.read) : [];
    },

    billsNotification(state) {
      return state.bills != null ? state.bills.slice(0, Constants.LIMIT_NOTIFICATION_SHOW) : [];
    },

    sortBill(state) {
      return state.sortBill;
    },

    billsPagination(state) {
      var len = state.bills == null ? 0 : state.bills.length;
      state.sortBill.totalPage = Math.ceil(len / Constants.PAGE_SIZE_ORDER);
      return state.bills != null ? CommonUtils.paginate(state.bills, Constants.PAGE_SIZE_ORDER, state.sortBill.page) : [];
    },

    billsTotalPage(state) {
      var len = state.bills == null ? 0 : state.bills.length;
      return Math.ceil(len / Constants.PAGE_SIZE_ORDER);
    }
  },

  mutations: {

    [MutationsName.MUTATION_NAME_SET_BILLS](state, bills) {
      state.bills = bills.sort((a, b) => {
        if (a.code < b.code) {
          return 1;
        } else if (a.code > b.code) {
          return -1;
        }
        return 0;
      });
    },

    [MutationsName.MUTATION_NAME_SET_BILLS_LOCAL](state, billsLocal) {
      state.billsLocal = billsLocal;
    },

    [MutationsName.MUTATION_NAME_SET_BILL](state, bill) {
      state.bill = bill;
    },

    [MutationsName.MUTATION_NAME_REMOVE_BILL](state, id) {
      state.bills = state.bills.filter(bill => bill.id != id);
    },

    [MutationsName.MUTATION_NAME_UPDATE_BILL](state, bill) {
      state.bills = state.bills.map(item => {
        if (bill.id == item.id) {
          item = bill;
        }
        return item;
      });
    },

    [MutationsName.MUTATION_NAME_SET_BILLS_NOTIFICATION](state, billsNotification) {
      state.billsNotification = billsNotification;
    },

    [MutationsName.MUTATION_NAME_UPDATE_BILL_NOTIFICATION](state, bill) {
      state.billsNotification = state.billsNotification.map(item => {
        if (bill.id == item.id) {
          item = bill;
        }
        return item;
      });
    },

    [MutationsName.MUTATION_NAME_SET_BILL_CURRENT_PAGE](state, page) {
      state.billCurrentPage = page;
    },

    [MutationsName.MUTATION_NAME_SET_SORT_BILL](state, sortBill) {
      state.sortBill = sortBill;
    }
  },
};

export default BillModule;
