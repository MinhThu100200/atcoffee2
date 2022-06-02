import database from '../../configs/firebase'
import {ref, set } from "firebase/database";

const collectionName = 'notifications';

var NotificationService = {

  save(notification) {
    const startCountRef = ref(database, `${collectionName}/${notification.id}/${notification.code}`);
    set(startCountRef, notification);
  },

}

export default NotificationService;