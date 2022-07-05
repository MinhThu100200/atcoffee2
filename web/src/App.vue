<template>
  <div class="app">
    <router-view />
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
:root {
  --primary: #37A372;
  --primaryBackground: #37a37211;
  --lightPurple: "#595683";
  --yellow: "#F1CD7C";
  --lightYellow: "#FFD88A";
  --white: "#FFFFFF";
  --white1: "#F1E6D8";
  --while2: "#f4f6f9";
  --lightGreen: "#7EBDA2";
  --lightGreen2: "#BED2BB";
}

#app {
  font-family: "Nunito", "Segoe UI", arial;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: var(--white);
  font-size: 14px;
}

*, ::after, ::before{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  scrollbar-width: thin;
}
</style>
