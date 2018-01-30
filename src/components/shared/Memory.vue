<template lang="pug">
  article.notepad
    div.coordinates {{ coordinates }}
    div.country <span class="date">{{ timing }}</span>
    p {{ story}}
    br
    small Submitted by {{ author }} - <a v-bind:href="gMapLink" target="_blank">see memory on the map</a>
</template>

<script>
export default {
  props: [
    'lat',
    'lon',
    'timing',
    'story',
    'author'
  ],
  data() {
    return {
      city: ''
    }
  },
  computed: {
    coordinates() {
      return this.formatCoordinates(this.lat,this.lon);
    },
    gMapLink() {
      return 'https://www.google.com/maps/search/?api=1&query=' + this.lat + ',' + this.lon;
    }
  },
  methods: {
    getCity() {
      var request = new XMLHttpRequest();
      var url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' + this.lat + ',' + this.lon;

      self = this;

      request.open('GET', url, true);
      request.onreadystatechange = function () {
        if(request.readyState === XMLHttpRequest.DONE && request.status === 200) {
          var data = JSON.parse(request.responseText);
          var city = data.results[2].formatted_address;
          self.city = city;
        }
      }
      request.send();
    },
  },
  mounted() {
    // this.getCity();
  }
}
</script>

<style lang="scss">
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
    font: 16px/24px serif;
    margin-top: 5px;
    margin-bottom: 24px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
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

</style>
