<template>
  <div class="container section-user">
    <div class="section-header">
    <h1>{{title}}</h1>
    <div class="section-header-breadcrumb">
        <slot></slot>
    </div>
  </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
export default {
  name: Constants.COMPONENT_NAME_SECTION_HEADER_USER,

  props: ['title']
}
</script>

<style>

.section-user .section-header {
  background: #fff;
  border-radius: 3px;
  border: none;
  position: relative;
  padding-top: 25px;
  padding-bottom: 5px;
  display: flex;
  align-items: center;
  margin-top: -7px;
}

.section-user .section-header h1 {
  margin-bottom: 0px;
  font-weight: 700;
  display: inline-block;
  font-size: 24px;
  margin-top: 3px;
  color: #34395e;
  line-height: 1.2;
}

.section-user .section-header .section-header-breadcrumb {
  margin-left: 0;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
}

.section-user .section-header .section-header-breadcrumb .breadcrumb-item {
  font-size: 14px;
  font-weight: 600;
}

.section-user .breadcrumb-item {
  color: #6c757d ;
}

.section-user .breadcrumb-item.active a {
  color: #383838;
}

.section-user a {
  color: var(--primary);
  font-weight: 600;
  text-decoration: none;
  background: transparent;
}

.section-user .section-header .breadcrumb-item.active a:hover {
  color: var(--primary);
}

.section-user .section-header .breadcrumb-item.active a:visited, a:active, a:link {
  text-decoration: none;
}

@media (min-width: 1400px){
  .section-user.container {
  max-width: 1200px;
  }
}

</style>