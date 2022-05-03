class CategoryEntity {

  /**
   * Constructor CategoryEntity
   * 
   * @param {*} id
   * @param {*} code 
   * @param {*} name 
   * @param {*} state 
   */
  constructor(id, code, name, state) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.state = state;
  }
}

export default CategoryEntity;