<template>
  <div id="app">
    <div class="wrapper">
      <div class="container">
        <router-view></router-view>
      </div>
      <app-footer></app-footer>
    </div>
  </div>
</template>

<script>
import Footer from './components/Footer.vue'

export default {
  name: 'app',
  components: {
    'app-footer': Footer
  }
}
</script>
<!-- http://jsfiddle.net/Mottie/dC3Kw/ -->
<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  background-image: url('./assets/watercolour.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}
body {
  margin: 0;
}

h1 {
  text-align: center;
  font-family: 'Permanent Marker';
  font-size: 70px;
}
h2 {
  text-align: center;
  margin-bottom: 80px;
}

.wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.container {
  padding: 30px;
  padding-top: 70px;
  max-width: 1000px;
  height: 100%;
  margin: 0 auto;
  flex-grow: 1;

  @media screen and (max-width: 1000px){
      margin-left: 20px !important;
      margin-right: 20px !important;
  }
}

@media screen and (max-width:1000px){
  .hide-mobile{
      display:none
  }
}

a {
  text-decoration: none;
  color: inherit;
}
</style>
