import axios from 'axios'
import JWT from '../common/Jwt'
import * as Constants from '../common/Constants' 

const instance = axios.create({
  baseURL: Constants.HOSTNAME_DEFAULT,
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Authorization': JWT.getBearerJWT()
  }
});

const instanceLogin = axios.create({
  baseURL: Constants.HOSTNAME_DEFAULT,
  headers: {
    'Content-Type': 'application/json',
  }
});

const connect = {

    /**
     * postData
     * @param {*} url 
     * @param {*} data 
     * @returns 
     */
    postData: async (url, data) => {
      try {
        let res = await instance.post(url, data, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': JWT.getBearerJWT()
          }
        });
        return res && res.data ? res.data : null;
      } catch (error) {
        return null;
      }
    },

    /**
     * putData
     * @param {*} url 
     * @param {*} data 
     * @returns 
     */
    putData: async (url, data) => {
      try{
        let res = await instance.put(url, data, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': JWT.getBearerJWT()
          }
        });
        return res && res.data ? res.data : null;
      } catch(error) {
        return null;
      }
    },

    /**
     * postDataLogin
     * @param {*} url 
     * @param {*} data 
     * @returns 
     */
     postDataLogin: async (url, data) => {
      try{
        let res = await instanceLogin.post(url, data);
        return res && res.data ? res.data : null;
      } catch {
        return null;
      }
    },

    getDataInfo: async (url) => {
      try {
        let res = await instanceLogin.get(url);
        return res != null && res.data ? res.data : null;
      } catch (error) {
        return null;
      }
    },

    /**
     * Function: getData
     * @param {*} url 
     * @returns 
     */
    getData: async (url) => {
      try{
        let res = await instance.get(url, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': JWT.getBearerJWT()
          }
        });
        return res != null && res.data ? res.data : null;
      } catch (error) {
        return null;
      }
    },

    /**
     * postData
     * @param {*} url 
     * @param {*} data 
     * @returns 
     */
     deleteData: async (url) => {
      try {
        let res = await instance.delete(url, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': JWT.getBearerJWT()
          }
        });
        return res && res.data ? res.data : null;
      } catch (error) {
        return null;
      }
    },
}

export default connect;