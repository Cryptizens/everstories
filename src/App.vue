<template>
  <div id="app">
    <div>
      <h1>New memory</h1>
      <label for="story">Story</label>
      <input name="story" v-model="story">
      <label for="lat">Latitude</label>
      <input name="lat" v-model="lat">
      <label for="lon">Longitude</label>
      <input name="lon" v-model="lon">
    </div>
    <div>
      <h1>Memory preview</h1>
      {{ story}}
      {{ lat }}
      {{ lon }}
      <button @click="createMemory()">Save memory</button>
    </div>

    <img style="height: 200px" src="./assets/background.jpg">
    <div style="height: 200px">
      <v-map :zoom=13 :center="[47.413220, -1.219482]">
        <v-tilelayer url="http://{s}.tile.osm.org/{z}/{x}/{y}.png" attribution="&copy; <a href='http://osm.org/copyright'>OpenStreetMap</a> contributors"></v-tilelayer>
        <v-marker :lat-lng="[47.413220, -1.219482]" :title="title">
          <v-popup :content="text"></v-popup>
        </v-marker>
      </v-map>
    </div>
    <div>
      <h1>All memories</h1>
      {{ memories }}
    </div>
  </div>
</template>

<script>
import { abi } from './contracts/abi'
import { address } from './contracts/address'

export default {
  name: 'app',
  data() {
    return {
      memories: [],
      story: 'Your first story...',
      lat: 0,
      lon: 0,
      text: "Lol",
      title: "HEYHEY"
    }
  },
  methods: {
    // Called at page load, to retrieve all existing memories from the Blockchain.
    // We use an infura node instead of an in-browser wallet, so that all users
    // can see the full list of memories, even if they're not tech-savvy.
    // Initiates the recursive call to retrieveMemoryAtIndex, since Solidity does
    // not allow us to retrieve all elements of the contract array at one, so
    // we must iterate instead
    populateMemories() {
      var remoteWeb3 = new Web3(
          new Web3.providers.HttpProvider('https://rinkeby.infura.io/')
      );
      const Memorial = new remoteWeb3.eth.Contract(abi, address)
      this.retrieveMemoryAtIndex(0, Memorial);
    },
    // The recursive function progressing through the contract memories array
    // and populating the Vue instance data with memories along the way
    retrieveMemoryAtIndex: function(index, Memorial) {
      self = this;
      Memorial.methods.memories(index).call(function (error, result) {
        if (!error) {
          // No error means there are still other memories to come, hence we
          // can safely enter a new function recursion after having pushed the
          // retrieved memory in the Vue instance data
          self.insertMemory(result);
          self.retrieveMemoryAtIndex(index + 1, Memorial);
        } else {
          // Not very safe actually, but this is the simplest way to detect when
          // we've come to the last index of the memories array, as an out-of-bounds
          // index will return an error that we can catch here to then stop the
          // function recursion
          console.log('Done loading all memories');
        }
      });
    },
    // Called when the user clicks on the save button; sends data to the
    // Blockchain for saving, requiring first that the user approves the
    // transaction since it takes some Gas to write this data on the Blockchain.
    // Note that we don't monitor here if the data was successfully written,
    // for this we use a contract Event instead (see below)
    // TODO: put the newly created memory as pending in the html for user feedback
    createMemory() {
      this.memorial().recordMemory(this.story, this.lat, this.lon, function(){
        console.log('Memory sent to the Blockchain!');
      })
    },
    // Helper function to get the contract js interface, using an in-browser
    // wallet such as MetaMask - we cannot use infura here since we're making
    // a real transaction rather than a call and hence need the user to approve
    // the Tx before it is sent to the blockchain
    memorial() {
      const MemorialContract = web3.eth.contract(abi);
      const Memorial = MemorialContract.at(address);
      return Memorial;
    },
    // Helper function to create a Vue instance data memory from the Memory
    // struct in the contract
    insertMemory(result){
      var memory = {
        story: result[0],
        lat: result[1],
        lon: result[2],
        owner: result[3]
      };
      this.memories.push(memory);
    }
  },
  mounted() {
    // Called once at page load, to fetch all existing memories
    this.populateMemories();

    // Listen to contract event for new memory, to automatically refresh the
    // memories list. The results object contains the full log entry; the args
    // key contains the actual items output in the log event
    // TODO: let the user know that their story has been written successfully
    this.memorial().NewMemory(function(error, result) {
      if (error) return
      console.log('Memory recorded on the Blockchain!');
      var memory = {
        story: result.args.story,
        lat: result.args.lat,
        lon: result.args.lon,
        owner: result.args.owner
      };
      self.memories.push(memory);
    })
  }
}
</script>

<style lang="scss">
@import "~leaflet/dist/leaflet.css";

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
