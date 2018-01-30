<template lang="pug">
    div
      h1 Everstories.city
      h2 An experimental artistic project<br>to engrave the stories of our cities<br>forever on the Blockchain
      small Latest memories
      app-memory(v-for="(memory, index) in memories" v-if="index < 4" :key="memory.author + memory.lat" :lat="memory.lat" :lon="memory.lon" :timing="memory.timing" :story="memory.story" :author="memory.author")
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
    populateMemories() {
      // Retrieve the contract to interact with it
      var remoteWeb3 = new Web3(
          new Web3.providers.HttpProvider('https://rinkeby.infura.io/')
      );
      const Memorial = new remoteWeb3.eth.Contract(abi, address);

      self = this;

      // Get the current number of memories so we know till where we can iterate
      Memorial.methods.getMemoriesCount().call(function (error, result) {
        const MemoriesCount = result;
        var selff = self;
        // Iterate on all the memories and insert them in the Vue instance data
        for (var i = 0; i < MemoriesCount; i++) {
          Memorial.methods.memories(i).call(function (error, result) {
            selff.insertMemory(result);
          });
        };
        console.log('Done loading all memories');
      });
    },
    // Helper function to create a Vue instance data memory from the Memory
    // struct in the contract - need to reformat coordinates for the integer
    // storing and convert bytes32 to strings
    insertMemory: function(result) {
      var lat = result[0] / 10000;
      var lon = result[1] / 10000;

      var timing = this.toAscii(result[2]);
      var story  = this.toAscii(result[3]);

      var author = result[4];

      var memory = {
        lat: lat,
        lon: lon,
        timing: timing,
        story: story,
        author: author
      };

      this.memories.push(memory);
    },
    // Helper method to convert a bytes32 representation of a word to an ASCII
    // representation
    toAscii: function(hex) {
      var str = '',
          i = 0,
          l = hex.length;
      if (hex.substring(0, 2) === '0x') {
          i = 2;
      }
      for (; i < l; i+=2) {
          var code = parseInt(hex.substr(i, 2), 16);
          if (code === 0) continue; // this is added
          str += String.fromCharCode(code);
      }
      return str;
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
