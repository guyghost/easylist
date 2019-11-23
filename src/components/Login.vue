<template>
    <div>
        <div @click="connect" class="mdc-touch-target-wrapper">
            <button class="mdc-button mdc-button--touch">
                <div class="mdc-button__ripple"></div>
                <span class="mdc-button__label">Connection</span>
                <div class="mdc-button__touch"></div>
            </button>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Login',
    methods: {
        connect: function() {
            this.$store.dispatch('authRequest')
        }
    }
}
</script>

<style lang="scss">
    @import "@material/button/mdc-button";
</style>