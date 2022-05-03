import ConnectServer from '../server/ConnectServer'
import * as MutationsName from '../common/MutationsName'

const LoginCommand = {

  /**
   * Function: login by username and password
   * @param {*} user 
   * @returns 
   */
  async login (user, store) {

    try{
      
      const url = '/api/authenticate';
      const res = await ConnectServer.postDataLogin(url, user);
      if (res != null && res) {
        var params = {
          user: res.user,
          jwt: res.jwt
        }
        store.commit(MutationsName.MUTATION_LOGIN, params);
        return res;
      }
      return null;
    } catch (error){
      return null;
    }
    
  },

  logout(store) {
    localStorage.clear();
    store.commit(MutationsName.MUTATION_NAME_LOGOUT);
    return true;
  },

  /**
   * Function: authenticated
   * @returns 
   */
  async authenticated(store) {
    
    try{

      const url = '/api/user/authenticate';
      const res = await ConnectServer.getData(url);      
      if (res != null) {
        store.commit(MutationsName.AUTHENTICATED, res);
        return res;
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}

export default LoginCommand;