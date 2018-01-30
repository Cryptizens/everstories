import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import Routes from './routes'
var formatCoords = require('formatcoords');

Vue.mixin({
  methods: {
    formatCoordinates: function(latitude, longitude) {
      return formatCoords(latitude, longitude).format({
        latLonSeparator: ',',
        decimalPlaces: '0'
      });
    }
  }
})

Vue.use(VueRouter);
const router = new VueRouter({
  routes: Routes
});

window.Web3 = require('web3');

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
