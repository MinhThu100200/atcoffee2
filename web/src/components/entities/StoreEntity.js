class StoreEntity {

  /**
   * Constructor StoreEntity
   * @param {*} code 
   * @param {*} name 
   * @param {*} address 
   * @param {*} timeOpen 
   * @param {*} timeClose 
   * @param {*} state 
   */
  constructor(code, name, address, timeOpen, timeClose, state) {
    this.code = code;
    this.name = name;
    this.address = address;
    this.timeOpen = timeOpen;
    this.timeClose = timeClose;
    this.state = state;
  }
}

export default StoreEntity;