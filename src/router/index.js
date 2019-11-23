import Vue from 'vue'
import VueRouter from 'vue-router'
import App from "../App.vue"

Vue.use(VueRouter)

const Success = {
    template: '<div>Success</div>'
}

const Failed = {
    template: '<div>Error</div>'
}

export default new VueRouter ({
    mode: 'history',
    routes: [
        { path: '/', component: App },
        { path: '/success', component: Success},
        { path: '/error', component: Failed}
    ]
});