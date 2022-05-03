import * as Constants from '../common/Constants'

const JWT = {

  /**
   * Function: setJWT
   * @param {*} jwt
   */
  setJWT: (jwt) => {
    localStorage.setItem(Constants.JWT_NAME, jwt);
  },

  /**
   * Function: getJWT
   * @returns
   */
  getJWT: () => {
    const jwt = localStorage.getItem(Constants.JWT_NAME);
    return jwt;
  },

  /**
   * Function: getBearerJWT
   * @returns
   */
   getBearerJWT: () => {
    const jwt = `Bearer ${localStorage.getItem(Constants.JWT_NAME)}`;
    return jwt;
  },
};

export default JWT;
