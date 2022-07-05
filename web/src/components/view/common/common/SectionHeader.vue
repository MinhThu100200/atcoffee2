<template>
  <div class="section-header">
    <h1>{{title}}</h1>
    <div class="section-header-breadcrumb">
        <slot></slot>
    </div>
  </div>
</template>

<script>
import * as Constants from '../../../common/Constants'
export default {
  name: Constants.COMPONENT_NAME_SECTION_HEADER,

  props: ['title']
}
</script>

<style>
.section .section-header {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.03);
  background: #fff;
  border-radius: 3px;
  border: none;
  position: relative;
  margin-bottom: 30px;
  padding: 20px;
  display: flex;
  align-items: center;
  margin-top: -7px;
}

.section .section-header h1 {
  margin-bottom: 0px;
  font-weight: 700;
  display: inline-block;
  font-size: 24px;
  margin-top: 3px;
  color: #34395e;
  line-height: 1.2;
}

.section .section-header .section-header-breadcrumb {
  margin-left: auto;
  display: flex;
  align-items: center;
}

.section .section-header .section-header-breadcrumb .breadcrumb-item {
  font-size: 13px;
}

.breadcrumb-item.active {
  color: #6c757d;
}

a {
  color: var(--primary);
  font-weight: 500;
  text-decoration: none;
  background: transparent;
}

.section .section-header .breadcrumb-item a:hover {
  text-decoration: underline;
  color: var(--primary);
}

.section .section-header .breadcrumb-item a:visited, a:active, a:link {
  color: var(--primary);
  text-decoration: none;
}

</style>