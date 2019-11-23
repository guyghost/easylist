import Vue from 'vue'
import VueCookie from "vue-cookie";
import App from './App.vue'
import store from './store'
import router from './router'

Vue.config.productionTip = false
Vue.use(VueCookie)

new Vue({   
  store,
  router,
  render: h => h(App),
}).$mount('#app')
