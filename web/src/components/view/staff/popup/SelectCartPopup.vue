<template>
  <div class="select" :class="isSelectCartPopup ? 'open-popup' : ''">
    <div class="select-inner" v-click-outside="handleHide">
      <div id="rectangle">
        <form @submit.prevent="handleSubmit">
          <div class="row-custom">
            <button class="btn btn-outline-danger" @click.prevent="handleMinusQuantity"><i class="fas fa-minus"></i></button>
            <input class="form-control" type="number" min="1" :value="quantity"/>
            <button class="btn btn-outline-info" @click.prevent="handlePlusQuantity"><i class="fas fa-plus"></i></button>
          </div>
          <div class="row-custom">
            <div class="chip-size" :class="size == 'S' ? 'active' : ''" @click="handleChangeSize('S')">S</div>
            <div class="chip-size" :class="size == 'M' ? 'active' : ''" @click="handleChangeSize('M')">M</div>
            <div class="chip-size" :class="size == 'L' ? 'active' : ''" @click="handleChangeSize('L')">L</div>
          </div>
          <div class="action">
            <input type="submit" value="Cập nhật" class="btn btn-outline-success"/>
            <i class="far fa-trash-alt" @click.prevent="handleRemove"></i>
          </div>
        </form>
      </div> 
      <div id="triangle-down"></div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
import vClickOutside from 'click-outside-vue3'

export default {
  name: Constants.COMPONENT_NAME_SELECT_CART_POPUP,

  props: ['quantity', 'size', 'isSelectCartPopup'],

  directives: {
      clickOutside: vClickOutside.directive
  },

  data(){
    return {
      count: 0
    }
  },

  methods: {

    handleMinusQuantity() {
      var quantity = this.quantity == 1 ? this.quantity : this.quantity - 1;
      this.$emit('handleChange', quantity);
    },

    handlePlusQuantity() {
      var quantity = this.quantity + 1;
      this.$emit('handleChange', quantity);
    },

    handleChangeSize(size) {
      this.$emit('handleChangeSize', size);
    },

    handleRemove() {
      this.$emit('handleRemove');
    },

    handleSubmit() {
      this.$emit('handleSubmit');
    },

    handleHide() {
      this.count += this.isSelectCartPopup ? 1 : 0;
      this.count % 2 == 0 ? this.$emit('handleHide') : null;
    }
  }
}
</script>

<style scoped>
.select {
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  transition: all .3s;
  visibility: hidden;
  opacity: 0;
  transform: scale(0.8);
  z-index: 20000;
  cursor: default;
}

.open-popup {
  visibility: visible;
  opacity: 1;
  transform: scale(1);
}

.select-inner {
  display: flex;
  position: absolute;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: transparent;
  border-radius: 4px;
}

#rectangle {
  width: 140px;
  height: auto;
  border-radius: 4px;
  background: #fff;
  box-shadow: 2px 6px 12px rgba(0, 0, 0, 0.3);
}

#triangle-down {
  width: 0;
  height: 0;
  border-left: 20px solid transparent;
  border-right: 20px solid transparent;
  border-top: 40px solid #fff;
}

#rectangle form {
  height: 100%;
}

#rectangle input[type="submit"] {
  padding: 4px;
  margin: 8px 8px;
  width: 100%;
}

.row-custom {
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  width: 100%;
  justify-content: center;
  align-items: center;
  margin-top: 8px;
}

.row-custom input[type="number"] {
  text-align: center;
  padding: 4px;
  width: 50px !important;
}

.row-custom button {
  width: 32px !important; 
  text-align: center;
  padding: 4px 0px;
  margin: 0px 4px;
}

hr {
  width: 100%;
  border: 0.5px solid #ccc;
  margin-top: 0px;
  margin-bottom: 0;
}

.chip-size {
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  text-align: center;
  border: 1px solid #ffa500;
  border-radius: 4px;
  height: 34px;
  margin: 0px 4px;
  transition: all .3s;
}

.chip-size:nth-child(2) {
  width: 50px !important;
  margin: 0;
}

.chip-size.active {
  background: #ffa500;
  color: #fff;
  font-weight: bold;
}

.action {
  width: 100%;
  text-align: center;
  margin-top: 8px;
}

.action input[type="submit"] {
  margin-right: 4px !important;
}

.action i {
  display: flex;
  align-items: center;
  justify-content: center;
  color: red;
  cursor: pointer;
  font-size: 18px;
  margin-right: 8px;
  border: 1px solid #f00;
  border-radius: 4px;
  height: 34px;
  padding: 0 7px;
  transition: all .3s;
}

.action i:hover {
  color: white;
  background: #f00;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
</style>