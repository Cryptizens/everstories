<template lang="pug">
    div
      h1 Write your own memory
      h2 You need to have <a href="https://faucet.rinkeby.io/" target="_blank"><u>MetaMask</u></a> installed with a few Ethers in your wallet<br>so you can engrave this memory on the Blockchain forever.
      small Drag the marker on the map to the place you want to tell a story about
      #map
      div.inputs
        input.input-narrow(name="timing" v-model="timing" placeholder="Approximate timing (e.g., Summer 1969)" maxlength="32")
        input.input-wide(name="story" v-model="story" placeholder="The story you want to tell" maxlength="32")
        button(@click="createMemory()") Engrave memory
</template>

<script>
import { abi } from '../contracts/abi'
import { address } from '../contracts/address'
import Memory from './shared/Memory.vue'

export default {
  components: {
    'app-memory': Memory
  },
  data() {
    return {
      lat: null,
      lon: null,
      story: null,
      timing: null
    }
  },
  computed: {
    integerLat() {
      return parseInt(this.lat * 10000);
    },
    integerLon() {
      return parseInt(this.lon * 10000);
    }
  },
  methods: {
    // Called when the user clicks on the save button; sends data to the
    // Blockchain for saving, requiring first that the user approves the
    // transaction since it takes some Gas to write this data on the Blockchain.
    // Note that we don't monitor here if the data was successfully written,
    // for this we use a contract Event instead (see below)
    // TODO: put the newly created memory as pending in the html for user feedback
    // NOTE: this function call will FALL if MetaMask has not injected their Web3 !
    createMemory() {
      this.memorial().recordMemory(this.integerLat, this.integerLon, this.timing, this.story, function(error, result){
        console.log(error);
        console.log('Memory sent to the Blockchain!');
      })
    },
    // Helper function to get the contract js interface, using an in-browser
    // wallet such as MetaMask - we cannot use infura here since we're making
    // a real transaction rather than a call and hence need the user to approve
    // the Tx before it is sent to the blockchain
    memorial() {
      return web3.eth.contract(abi).at(address);
    },
  },
  mounted() {
    // Listen to contract event for new memory, to automatically refresh the
    // memories list. The results object contains the full log entry; the args
    // key contains the actual items output in the log event
    // TODO: let the user know that their story has been written successfully
    this.memorial().NewMemory(function(error, result) {
      if (error) return
      console.log('Memory recorded on the Blockchain!');
      var memory = {
        lat: result.args.lat,
        lon: result.args.lon,
        timing: result.args.timing,
        story: result.args.story,
        owner: result.args.owner
      };
      console.log(memory);
    });

    // Google Map marker dragging logic, to retrieve coordinates from the map
    // Center on Brussels for the first time ;)
    var latlng = new google.maps.LatLng(50.84710339196623, 4.352660198437434);
    var map = new google.maps.Map(document.getElementById('map'), {
        center: latlng,
        zoom: 11,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        title: 'Set lat/lon values for this property',
        draggable: true
    });

    self = this;
    // Callback after the marker is dragged, where we retrieve the new coordinates
    google.maps.event.addListener(marker, 'dragend', function(a) {
        self.lat = a.latLng.lat();
        self.lon = a.latLng.lng();
    });
  }
}
</script>

<style lang="scss" scoped>
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

#map {
  height: 300px;
}

.input-narrow {
  width: 30%;
}

.input-wide {
  width: 50%;
}

.inputs {
  margin: 10px auto;
  text-align: center;
}
</style>
