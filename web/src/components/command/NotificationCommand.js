import axios from 'axios'
import * as Constants from '../common/Constants'
import ConnectServer from '../server/ConnectServer'
import * as MutationsName from '../common/MutationsName'


const instance = axios.create({
  baseURL: 'http://localhost:8080',
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Methods': '*',
    'Authorization': 'key=' + Constants.TOKEN_FCM
  }
});

var NotificationCommand = {

  async sendNotification(title, message, token) {
    var url = Constants.HOSTNAME_NOTIFICATION + '/fcm/send';
    var data = {
      to: token,
      notification: {
           title, body: message
          }
      }
   
    var response = await instance.post(url, data);

    return response;
  },

  async sendAllNotifications(title, message, image, tokens) {
    var url = Constants.HOSTNAME_NOTIFICATION + '/fcm/send';
    var data = {
      registration_ids: tokens,
      notification: {
           title: title, 
           body: message,
           image: image
          }
      }
   
    var response = await instance.post(url, data);

    return response;
  },

  async save(notification) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/notification`;
    let res = await ConnectServer.postData(url, notification);
    return res != null ? res : null;
  },

  async delete(id) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/notification/${id}`;
    let res = await ConnectServer.deleteData(url);
    return res != null ? res : null;
  },

  async findOne(id, store) {
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/notification/${id}`;
    let result = await ConnectServer.getData(url);
    store != null ? store.commit(MutationsName.MUTATION_NAME_SET_NOTIFICATION, result) : '';
    return result;
  },

  async findAllByOrder(page, size, keyword, state, store = null) {
    var searchState = state != null && state !== '';
    if (searchState) {
      state = state != null && state !== '' ? state : true;
    }
    const url = `${Constants.HOSTNAME_DEFAULT}/api/staff/notification?keyword=${keyword}&state=${state}&searchState=${searchState}&page=${page}&size=${size}`;
    let result = await ConnectServer.getData(url);
    if (result != null) {
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_NOTIFICATIONS, result.notifications) : null;
      store != null ? store.commit(MutationsName.MUTATION_NAME_SET_SORT_NOTIFICATION, {page, totalPage: result.totalPage, keyword, state}) : null;
      return result.notifications;
    }
    return null;
  },
}

export default NotificationCommand;