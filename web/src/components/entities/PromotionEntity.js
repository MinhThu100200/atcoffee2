class PromotionEntity { 

  constructor(id, code, name, image, description, discount, object, proviso, startDate, endDate, state) {
    this.id = id;
    this.code = code;
    this.name = name;
    this.image = image;
    this.description = description;
    this.discount = discount;
    this.object = object;
    this.proviso = proviso;
    this.startDate = startDate;
    this.endDate = endDate;
    this.state = state;
  }
}

export default PromotionEntity;