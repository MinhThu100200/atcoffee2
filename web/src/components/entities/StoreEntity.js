class StoreEntity {

  /**
   * Constructor StoreEntity
   * @param {*} code 
   * @param {*} name 
   * @param {*} image
   * @param {*} address 
   * @param {*} timeOpen 
   * @param {*} timeClose 
   * @param {*} state 
   * @param {*} latitude 
   * @param {*} longitude 
   */
  constructor(code, name, image, address, timeOpen, timeClose, state, latitude, longitude) {
    this.code = code;
    this.name = name;
    this.image = image;
    this.address = address;
    this.timeOpen = timeOpen;
    this.timeClose = timeClose;
    this.state = state;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

export default StoreEntity;