class UserEntity {

  /**
   * constructor
   * @param {*} username 
   * @param {*} password 
   * @param {*} image 
   * @param {*} name 
   * @param {*} phone 
   * @param {*} gender 
   * @param {*} email 
   * @param {*} dob 
   * @param {*} identityCard 
   * @param {*} storeId 
   * @param {*} accumulatedPoints 
   * @param {*} currentPoints 
   * @param {*} typeId 
   * @param {*} roleName 
   */
  constructor(username, password, image, name, phone, gender, email, dob, identityCard, storeId, accumulatedPoints, currentPoints, typeId, roleName){
    this.username = username;
    this.password = password;
    this.image = image; 
    this.name = name;
    this.phone = phone;
    this.gender = gender;
    this.email = email;
    this.dob = dob;
    this.identityCard = identityCard;
    this.storeId = storeId;
    this.accumulatedPoints = accumulatedPoints;
    this.currentPoints = currentPoints;
    this.typeId = typeId;
    this.roleName = roleName;
  }
}

export default UserEntity;