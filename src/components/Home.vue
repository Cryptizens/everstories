<template lang="pug">
    div
      h1 Everstories.city
      h2 An experimental artistic project<br>to engrave the stories of our cities<br>forever on the Blockchain
      app-memory(v-for="(memory, index) in memories" v-if="index < 4" :lat="memory.lat" :lon="memory.lon" :story="memory.story")
      router-link(:to="'create'")
        article.notepad.clickable
          div.coordinates Write your story, too
          div.country It's <span class="highlighted">simple</span> and <span class="highlighted">beautiful</span>. Click on this notepad
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
      memories: []
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
    // Helper function to create a Vue instance data memory from the Memory
    // struct in the contract
    insertMemory(result){
      var memory = {
        lat: result[0],
        lon: result[1],
        city: result[2],
        timing: result[3],
        story: result[4],
        owner: result[5]
      };
      this.memories.push(memory);
    }
  },
  mounted() {
    // Called once at page load, to fetch all existing memories
    this.populateMemories();
  }
}
</script>

<style lang="scss">
.highlighted {
  color: #C79EF3;
}

.clickable {
  cursor: pointer;
}
</style>
