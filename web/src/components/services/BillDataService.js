import database from '../../configs/firebase'
import {ref, set, onValue, get, child, remove, query, orderByChild, /**limitToLast*/ equalTo, /**push*/ } from "firebase/database";
import * as MutationsName from '../common/MutationsName'
// import * as Constants from '../common/Constants'

const collectionName = 'bills';

var BillDataService = {

  save(bill) {

    // const newBillKey = push(child(ref(database), collectionName)).key;
    // bill.id = bill.id?? bill.code;
    const startCountRef = ref(database, `${collectionName}/${bill.code}`);
    set(startCountRef, bill);
  },

  findOne(id, store) {
    const startCountRef = ref(database, `${collectionName}/${id}`);
    onValue(startCountRef, (snapshot) => {
      const data = snapshot.val();
      store.commit(MutationsName.MUTATION_NAME_SET_BILL, data);
    })
  },

  findOnce(id) {
    const dbRef = ref(database);
    get(child(dbRef, `${collectionName}/${id}`)).then((snapshot) => {
      if (snapshot.exists()) {
        // TODO: process has data
        console.log(snapshot.val());
      } else {
        // TODO: process no data
        console.log("No data available");
      }
    }).catch((error) => {
      console.error(error);
    });
  },

  findAll(store) {
    const dbRef = ref(database, collectionName);

    onValue(dbRef, (snapshot) => {
      let bills = [];
      snapshot.forEach((childSnapshot) => {
        // const childKey = childSnapshot.key;
        const childData = childSnapshot.val();
        
        bills.push(childData);
      });
      store.commit(MutationsName.MUTATION_NAME_SET_BILLS, bills);
    }, {
      onlyOnce: false
    });
  },

  findAllTokens(store) {
    console.log("🚀 ~ file: BillDataService.js ~ line 59 ~ findAllTokens ~ store", store)
    // const dbRef = ref(database, collectionName);

    // onValue(dbRef, (snapshot) => {
    //   let bills = [];
    //   snapshot.forEach((childSnapshot) => {
    //     // const childKey = childSnapshot.key;
    //     const childData = childSnapshot.val();
        
    //     bills.push(childData);
    //   });
    //   let tokens = bills.map(item => {
    //     if (item.token && item.token != undefined)
    //     {
    //       return item.token;
    //     } 
    //   }).filter((v, i, a) => v !== undefined &&  a.indexOf(v) === i);
      
    //   store.commit(MutationsName.MUTATION_NAME_SET_TOKENS, tokens);
    // }, {
    //   onlyOnce: true
    // });
  },

  findByStoreId(store) {
    const dbRef = ref(database, collectionName);
    const lastBillsRef = query(dbRef, orderByChild('storeId'), equalTo(store.getters.user.storeId));
    onValue(lastBillsRef, (snapshot) => {
      let bills = [];
      snapshot.forEach((childSnapshot) => {
        // const childKey = childSnapshot.key;
        const childData = childSnapshot.val();
        bills.push(childData);
      });
      store.commit(MutationsName.MUTATION_NAME_SET_BILLS, bills);
    }, {
      onlyOnce: false
    });
  },

  //Need review
  update(bill, store = null) {
    const startCountRef = ref(database, `${collectionName}/${bill.code}`);
    set(startCountRef, bill);
    store != null ? store.commit(MutationsName.MUTATION_NAME_UPDATE_BILL, bill) : '';
  },

  remove(id, store = null) {
    const startCountRef = ref(database, `${collectionName}/${id}`);
    remove(startCountRef, id);
    store != null ? store.commit(MutationsName.MUTATION_NAME_REMOVE_BILL, id) : '';
  },


}

export default BillDataService;