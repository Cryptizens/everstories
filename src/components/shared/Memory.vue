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
  }
}
</script>
