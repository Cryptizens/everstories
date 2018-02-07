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
<style lang="scss">
#app {
  font-family: 'Avenir', 'Open Sans', Helvetica, Arial, sans-serif;
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
  margin-top: 5px;
  text-align: center;
  font-family: 'Permanent Marker';
  font-size: 70px;
  margin-bottom: 20px;
}
h2 {
  text-align: center;
  font-size: 20px;
  margin-bottom: 40px;
}

.wrapper {
  min-height: 100vh;
}

.container {
  padding: 30px;
  padding-top: 70px;
  max-width: 1000px;
  height: 100%;
  margin: 0 auto;

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

.notepad {
  background: #f6f6f6;
  box-shadow: 0 1px 4px hsla(0,0%,0%,.25);
  margin: 10px auto;
  margin-bottom: 50px;
  position: relative;
  max-width: 550px;
  background-image: -webkit-radial-gradient(#E8E9FB 21%, transparent 21%),
                    -webkit-radial-gradient(hsla(0,0%,0%,.25) 21%, transparent 26%),
                    -webkit-linear-gradient(top, hsla(0,0%,0%,0) 0%, hsla(0,0%,0%,0) 95%,
                                                 hsla(180,25%,50%,.1) 95%, hsla(180,25%,50%,.1) 100%);
  background-image: -moz-radial-gradient(#E8E9FB 21%, transparent 21%),
                    -moz-radial-gradient(#E8E9FB 10%, transparent 12%),
                    -moz-linear-gradient(top, hsla(0,0%,0%,0) 0%, hsla(0,0%,0%,0) 95%,
                                                 hsla(180,25%,50%,.1) 95%, hsla(180,25%,50%,.1) 100%);
  background-image: radial-gradient(#E8E9FB 21%, transparent 21%),
                    radial-gradient(#E8E9FB 10%, transparent 12%),
                    linear-gradient(top, hsla(0,0%,0%,0) 0%, hsla(0,0%,0%,0) 95%,
                                                 hsla(180,25%,50%,.1) 95%, hsla(180,25%,50%,.1) 100%);
  background-position: 6px 6px, 6px 5px, 50% 18px;
  background-repeat: repeat-y, repeat-y, repeat;
  background-size: 48px 48px, 48px 48px, 24px 24px;
  padding: 24px 24px 24px 84px;

  p {
    color: #333;
    margin-top: 5px;
    margin-bottom: 24px;
  }
  small {
    font-size: 10px;
  }
  .country {
    font-variant: small-caps;
    font-family: 'Permanent Marker';
    font-size: 20px;
    color: lighten(grey, 10%);
  }

  .date {
    color: lighten(grey, 10%);
  }

  .coordinates {
    font-family: 'Permanent Marker';
    font-size: 38px;
    padding-right: 10px;
  }
}
.notepad:after {
  border-left: 1px solid #C7C0F4;
  border-right: 1px solid #C7C0F4;
  bottom: 0;
  content: '';
  left: 58px;
  position: absolute;
  top: 0;
  width: 5px;
}
.notepad:before {
  bottom: 8px;
  border-radius: 4px;
  box-shadow: 0 10px 10px hsla(0,0%,0%,.25);
  content: '';
  height: 100px;
  max-width: 300px;
  position: absolute;
  right: 5px;
  width: 300px;
  z-index: -10;
  -webkit-transform: rotate(2deg);
     -moz-transform: rotate(2deg);
      -ms-transform: rotate(2deg);
       -o-transform: rotate(2deg);
          transform: rotate(2deg);
}

@media screen and (max-width: 1000px){
    h1 {
      font-size: 30px;
    }
}
</style>
