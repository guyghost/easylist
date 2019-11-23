<template>
  <div id="app" class="mdc-layout-grid">
    <div class="mdc-layout-grid__inner">
      <div class="mdc-layout-grid__cell--span-12 logo">
        <img alt="EasyList logo" src="./assets/logo.svg">
      </div>
    </div>
    <div v-if="!getConnectionStatus" class="mdc-layout-grid__inner">
      <div class="mdc-layout-grid__cell--span-12 connection">
        <Login />
      </div>
    </div>
    <div v-else class="mdc-layout-grid__inner">
      <div class="mdc-layout-grid__cell--span-6 connection">
        <a :href=getCsvdUrl><img alt="Google Sheet" src="./assets/google_sheet.png"></a>
      </div>
      <div class="mdc-layout-grid__cell--span-6 connection">
        <a :href=getJsonUrl><img alt="Json" src="./assets/json_logo.png"></a>
      </div>
    </div>
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
    getCsvdUrl: function () {
      return `https://easylist.aule.net/generate?guid=${this.getGuid}`;
    },
    getJsonUrl: function () {
      return `https://easylist.aule.net/json?guid=${this.getGuid}`;
    }
  },
  mounted: function() {
    if(this.$route.query.code || this.$cookie.get('guid')) {
      this.$store.dispatch('isConnected', {code: this.$route.query.code, guid:this.$cookie.get('guid')})
    }
  }
}
</script>

<style lang="scss">
  @import "@material/layout-grid/mdc-layout-grid";
  @import "@material/typography/mdc-typography";

  .logo, .connection {
    margin: 0 auto;
  }
</style>
