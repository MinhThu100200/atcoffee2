<template>
  <div class="col-lg-3 col-md-6 col-sm-6 col-12">
    <div class="card card-statistic-1">
      <div class="card-icon" :class="color">
        <slot name="icon"></slot>
      </div>
      <div class="card-wrap">
        <div class="card-header">
          <h4><slot name="title"></slot></h4>
        </div>
        <div class="card-body">
          {{value}}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'

export default {
  name: Constants.COMPONENT_NAME_ITEM_STATISTICS,

  props: ['value', 'color']
}
</script>

<style>
.col-lg-3 {
  flex: 0 0 25%;
  max-width: 25%;
}

.card.card-statistic-1 {
  display: inline-block;
  width: 100%;
}

.card.card-statistic-1 .card-icon{
  line-height: 90px;
  width: 80px;
  height: 80px;
  margin: 10px;
  border-radius: 3px;
  text-align: center;
  float: left;
  margin-right: 15px;
}

.card.card-statistic-1 .card-icon .far, .card.card-statistic-1 .card-icon .fas {
  font-size: 22px;
  color: #fff;
}

.card.card-statistic-1 .card-header {
  border-color: transparent;
  height: auto;
  min-height: auto;
  display: block;
  padding-bottom: 8px;
}

.card.card-statistic-1 .card-header h4 {
  margin-bottom: 0px;
  font-weight: 600;
  font-size: 13px;
  margin-top: 10px;
  letter-spacing: .5px;
  line-height: 1.2;
  color: #98a6ad;
}

.card.card-statistic-1 .card-body {
  font-weight: 700;
  color: #34395e;
  padding-bottom: 0px;
  padding-top: 0px;
  font-size: 20px;
}

.bg-purple-1 {
  background: #6777ef;
}

.bg-orangered {
  background: orangered;
}

.bg-orange {
  background: orange;
}

.bg-green-1 {
  background: #47c363;
}
</style>