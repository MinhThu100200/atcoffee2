import axios from 'axios'
import * as Constants from '../common/Constants'

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
  }
}

export default NotificationCommand;