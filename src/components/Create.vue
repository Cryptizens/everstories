<template lang="pug">
    div
      h1 Write your own memory
      h2 You need to have <a href="https://faucet.rinkeby.io/" target="_blank"><u>MetaMask</u></a> installed with a few Ethers in your wallet<br>so you can engrave this memory on the Blockchain forever.

      label(for="story") Story
      input(name="story" v-model="story")
      label(for="lat") Latitude
      input(name="lat" v-model="lat")
      label(for="lon") Longitude
      input(name="lon" v-model="lon")

      button(@click="createMemory()") Save memory

      app-memory(:lat="lat" :lon="lon" :story="story")
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
      story: 'Your first story...',
      lat: 0,
      lon: 0,
      text: "Lol",
      title: "HEYHEY"
    }
  },
  methods: {
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

<style lang="scss" scoped>
h1 {
  margin-top: 5px;
  text-align: center;
  font-family: 'Permanent Marker';
  font-size: 70px;
}
h2 {
  text-align: center;
  font-size: 20px;
  margin-bottom: 80px;
}
</style>
