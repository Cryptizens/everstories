<template lang="html">
    <div class="footer-container">
      <div>
        © 2018 / <router-link :to="'/'"><u>Home</u></router-link> / <router-link :to="'about'"><u>About</u></router-link> / Brought to you by Thomas Vanderstraeten from <u><a target="_blank" href="https://cryptizens.io">Cryptizens.io</a></u>
      </div>
    </div>
</template>

<script>
export default {
}
</script>

<style lang="scss" scoped>
.footer-container {
  height: 50px;
  border-top: 1px solid grey;
  width: 1000px;
  margin: 0 auto;
  padding: 10px 20px 40px 20px;
  font-size: 14px;
  align-items: center;
}

@media screen and (max-width: 1000px){
  .footer-container {
    width: 100% !important;
  }
}
</style>
