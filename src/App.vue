<template>
  <div id="app">
    <img alt="EasyList logo" src="./assets/logo.svg">

    <Login v-if="!getConnectionStatus"/>
    <a v-else :href=getFormatedUrl>{{getFormatedUrl}}</a>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Login from './components/Login.vue'

export default {
  name: 'app',
  components: {
    Login
  },
  computed: {
    ...mapGetters([
      'getConnectionStatus',
      'getGuid'
    ]),
    getFormatedUrl: function () {
      return `https://easylist.aule.net/generate?guid=${this.getGuid}`;
    }
  },
  mounted: function() {
    if(this.$route.query.code) {
      this.$store.dispatch('isConnected', {code: this.$route.query.code})
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
