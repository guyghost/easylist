<template>
    <div>
        <div @click="connect" class="mdc-touch-target-wrapper">
            <button class="mdc-button mdc-button--touch mdc-button--raised">
                <div class="mdc-button__ripple"></div>
                <span v-if="getConnectionStatus" class="mdc-button__label">Logout</span>
                <span v-else class="mdc-button__label">Connect Your Account</span>
                <div class="mdc-button__touch"></div>
            </button>
        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
    name: 'Login',
    methods: {
        connect: function() {
            if (this.getConnectionStatus) {
                this.$store.dispatch('disconnection')
            } else {
                this.$store.dispatch('authRequest')
            }
            
        }
    },
    computed: {
        ...mapGetters([
            'getConnectionStatus',
        ]),
    }
}
</script>

<style lang="scss">
    @import "@material/button/mdc-button";
</style>